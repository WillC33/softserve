open Cohttp_lwt_unix

(*[<Main>]*)
let () =
  Softserve.Cli.parse_args ();

  let port = Softserve.Utils.get_port !Softserve.Cli.cli_port in

  let server_callback = Softserve.Server.server_callback in
  let conn_closed = Softserve.Server.conn_closed in
  let server =
    Cohttp_lwt_unix.Server.create
      ~mode:(`TCP (`Port port))
      (Server.make ~callback:server_callback ~conn_closed ())
  in
  Printf.printf "Serving HTTP on port %d\n%!" port;
  Lwt_main.run server
