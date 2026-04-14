module Catalog = Catalog
module Json = Json

type output_format = Json

type config = {
  list_values : bool;
  seed : int;
  family_selector : string option;
  experimental_provider : string option;
  output_format : output_format;
}

let usage =
  "Usage: ocaml-stakeholder [--list-values] [--family \
   <name|classic-six|modern-core|later-fallback>] [--seed <int>] \
   [--output-format json] [--experimental-provider <name>]"

let default_config =
  {
    list_values = false;
    seed = 0;
    family_selector = None;
    experimental_provider = None;
    output_format = Json;
  }

let family_to_json family =
  Json.object_
    [
      ("name", Json.string family.Catalog.name);
      ("group", Json.string (Catalog.group_name family.Catalog.group));
      ("parity_class", Json.string family.Catalog.parity_class);
      ("status", Json.string "implemented");
    ]

let contract_json =
  Json.object_
    [
      ("cli_contract", Json.string "deterministic-first-tranche");
      ("tranche", Json.string "classic-six+modern-core+grouped-fallback");
      ("same_seed", Json.bool true);
      ("live_provider", Json.string "deferred");
      ("experimental_provider", Json.string "fail-fast");
    ]

let run_id seed families =
  Printf.sprintf "seed-%d-count-%d" seed (List.length families)

let render_list_values () =
  Json.object_
    [
      ("repo", Json.string Catalog.repo);
      ("contract", contract_json);
      ("classic_six", Json.array (List.map family_to_json Catalog.classic_six));
      ("modern_core", Json.array (List.map family_to_json Catalog.modern_core));
      ( "later_fallback",
        Json.array (List.map family_to_json Catalog.later_fallback) );
    ]

let selected_families selector =
  match selector with
  | None -> Ok Catalog.all
  | Some "all" -> Ok Catalog.all
  | Some name -> (
      match Catalog.families_for_group name with
      | Some families -> Ok families
      | None -> (
          match Catalog.find_family name with
          | Some family -> Ok [ family ]
          | None -> Error (Printf.sprintf "unknown family selector: %s" name)))

let render_run config =
  match selected_families config.family_selector with
  | Error message -> Error message
  | Ok families ->
      let document =
        Json.object_
          [
            ("repo", Json.string Catalog.repo);
            ("contract", contract_json);
            ("seed", Json.int config.seed);
            ("run_id", Json.string (run_id config.seed families));
            ("families", Json.array (List.map family_to_json families));
          ]
      in
      Ok (Json.to_string document)

let rec parse argv index config =
  if index >= Array.length argv then Ok config
  else
    match argv.(index) with
    | "--list-values" ->
        parse argv (index + 1) { config with list_values = true }
    | "--seed" -> (
        if index + 1 >= Array.length argv then
          Error "--seed expects an integer argument"
        else
          match int_of_string_opt argv.(index + 1) with
          | Some value -> parse argv (index + 2) { config with seed = value }
          | None -> Error "--seed expects an integer argument")
    | "--family" ->
        if index + 1 >= Array.length argv then
          Error "--family expects a selector"
        else
          parse argv (index + 2)
            { config with family_selector = Some argv.(index + 1) }
    | "--experimental-provider" ->
        if index + 1 >= Array.length argv then
          Error "--experimental-provider expects a provider name"
        else
          parse argv (index + 2)
            { config with experimental_provider = Some argv.(index + 1) }
    | "--output-format" ->
        if index + 1 >= Array.length argv then
          Error "--output-format expects a value"
        else if String.lowercase_ascii argv.(index + 1) = "json" then
          parse argv (index + 2) config
        else Error "only JSON output is supported in the deterministic tranche"
    | "--help" | "-h" -> Error usage
    | unknown -> Error (Printf.sprintf "unknown argument: %s" unknown)

let execute argv =
  match parse argv 1 default_config with
  | Error message -> Error message
  | Ok config -> (
      match config.experimental_provider with
      | Some provider ->
          Error
            (Printf.sprintf
               "experimental provider %S is not enabled in ocaml-stakeholder \
                yet"
               provider)
      | None ->
          if config.output_format <> Json then
            Error "only JSON output is supported"
          else if config.list_values then
            Ok (Json.to_string (render_list_values ()))
          else render_run config)
