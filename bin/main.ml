let () =
  match Runtime.execute Sys.argv with
  | Ok output -> print_endline output
  | Error message ->
      prerr_endline message;
      exit 2
