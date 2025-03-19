open Alcotest
open Cohttp
open Softserve.Utils

(******************************************************************************)
(* Tests for the utility functions in utils.ml *)
(******************************************************************************)

(** Test the to_index function 
    *)
let test_to_index () =
  check string "root becomes /index.html" "/index.html" (to_index "/");
  check string "folder gets index appended" "/blog/index.html"
    (to_index "/blog/");
  check string "file remains unchanged" "/about.html" (to_index "/about.html")

(** Test the generate_file_path function 
    *)
let test_generate_file_path () =
  let uri = Uri.of_string "/blog/" in
  let req = Request.make ~headers:(Header.init ()) uri in
  (* generate_file_path prepends a "." to the path, so "/blog/" becomes "./blog/index.html" *)
  check string "generate file path" "./blog/index.html" (generate_file_path req)

(** Test the read_file function
    *)
let test_read_file () =
  let temp_file = "temp_test_file.txt" in
  let content = "Hello, world!" in

  (* Write a temporary file *)
  let write =
    Lwt_io.with_file ~mode:Lwt_io.Output temp_file (fun oc ->
        Lwt_io.write oc content)
  in

  Lwt_main.run write;

  (* Read back the file *)
  let read_content = Lwt_main.run (read_file temp_file) in

  (* cleanup *)
  Sys.remove temp_file;

  check string "read file content" content read_content

(** Test the log_request function
    *)
let test_log_request () =
  (* We won't capture the printed output here,
     just ensure the function completes without error. *)
  Lwt_main.run (log_request "dummy") |> ignore;
  ()

(** Test the get_port function
    *)
let test_get_port () =
  (* If a valid port is provided, it should return that value *)
  check int "cli port provided" 8080 (get_port 8080);
  (* For a cli port of -1, it should fall back to environment variable or default *)
  (try Sys.remove "PORT" with _ -> ());
  check int "default port when no env var" 5173 (get_port (-1));
  (* Now set the environment variable and test *)
  Unix.putenv "PORT" "3000";
  check int "env port overrides default" 3000 (get_port (-1));
  (* Reset environment variable *)
  Unix.putenv "PORT" ""

(* Run the tests *)
let () =
  run "Utils Tests"
    [
      ("to_index", [ test_case "test to_index" `Quick test_to_index ]);
      ( "generate_file_path",
        [ test_case "test generate_file_path" `Quick test_generate_file_path ]
      );
      ("read_file", [ test_case "test read_file" `Quick test_read_file ]);
      ("log_request", [ test_case "test log_request" `Quick test_log_request ]);
      ("get_port", [ test_case "test get_port" `Quick test_get_port ]);
    ]
