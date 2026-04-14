type t =
  | Null
  | Bool of bool
  | Int of int
  | String of string
  | Array of t list
  | Object of (string * t) list

let null = Null
let bool value = Bool value
let int value = Int value
let string value = String value
let array values = Array values
let object_ fields = Object fields

let escape_string value =
  let buffer = Buffer.create (String.length value + 16) in
  String.iter
    (fun ch ->
      match ch with
      | '"' -> Buffer.add_string buffer "\\\""
      | '\\' -> Buffer.add_string buffer "\\\\"
      | '\b' -> Buffer.add_string buffer "\\b"
      | '\012' -> Buffer.add_string buffer "\\f"
      | '\n' -> Buffer.add_string buffer "\\n"
      | '\r' -> Buffer.add_string buffer "\\r"
      | '\t' -> Buffer.add_string buffer "\\t"
      | ch when Char.code ch < 0x20 ->
          Buffer.add_string buffer (Printf.sprintf "\\u%04x" (Char.code ch))
      | ch -> Buffer.add_char buffer ch)
    value;
  Buffer.contents buffer

let rec to_buffer buffer = function
  | Null -> Buffer.add_string buffer "null"
  | Bool value -> Buffer.add_string buffer (if value then "true" else "false")
  | Int value -> Buffer.add_string buffer (string_of_int value)
  | String value ->
      Buffer.add_char buffer '"';
      Buffer.add_string buffer (escape_string value);
      Buffer.add_char buffer '"'
  | Array values ->
      Buffer.add_char buffer '[';
      values
      |> List.iteri (fun index value ->
          if index > 0 then Buffer.add_char buffer ',';
          to_buffer buffer value);
      Buffer.add_char buffer ']'
  | Object fields ->
      Buffer.add_char buffer '{';
      fields
      |> List.iteri (fun index (key, value) ->
          if index > 0 then Buffer.add_char buffer ',';
          Buffer.add_char buffer '"';
          Buffer.add_string buffer (escape_string key);
          Buffer.add_string buffer "\":";
          to_buffer buffer value);
      Buffer.add_char buffer '}'

let to_string value =
  let buffer = Buffer.create 256 in
  to_buffer buffer value;
  Buffer.contents buffer
