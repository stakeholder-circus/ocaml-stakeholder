let contains haystack needle =
  let needle_length = String.length needle in
  let rec search index =
    index + needle_length <= String.length haystack
    && (String.sub haystack index needle_length = needle || search (index + 1))
  in
  if needle_length = 0 then true else search 0

let expect condition message = if not condition then failwith message

let capture args =
  match Runtime.execute args with
  | Ok output -> output
  | Error message -> failwith message

let () =
  let list_values = capture [| "ocaml-stakeholder"; "--list-values" |] in
  expect (contains list_values "\"classic_six\"") "classic-six group missing";
  expect (contains list_values "\"modern_core\"") "modern-core group missing";
  expect
    (contains list_values "\"later_fallback\"")
    "later-fallback group missing";
  expect (contains list_values "\"code_analyzer\"") "code_analyzer missing";
  expect
    (contains list_values "\"supply_chain_security\"")
    "supply_chain_security missing";
  expect (contains list_values "\"ai_governance\"") "ai_governance missing";
  expect (contains list_values "\"overlay_quantum\"") "overlay_quantum missing";

  let first =
    capture [| "ocaml-stakeholder"; "--seed"; "7"; "--family"; "classic-six" |]
  in
  let second =
    capture [| "ocaml-stakeholder"; "--seed"; "7"; "--family"; "classic-six" |]
  in
  expect (String.equal first second) "same-seed JSON is not stable";
  expect (contains first "\"run_id\":\"seed-7-count-6\"") "run_id missing";

  match
    Runtime.execute
      [| "ocaml-stakeholder"; "--experimental-provider"; "openai" |]
  with
  | Ok _ -> failwith "experimental provider should fail fast"
  | Error message -> (
      expect
        (contains message "experimental provider")
        "experimental provider error message missing";
      expect
        (contains message "not enabled")
        "experimental provider fail-fast wording missing";

      match
        Runtime.execute [| "ocaml-stakeholder"; "--family"; "unknown" |]
      with
      | Ok _ -> failwith "unknown family should fail"
      | Error message ->
          expect
            (contains message "unknown family selector")
            "unknown selector message missing")
