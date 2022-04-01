module Handler = struct
  let not_found _req = Dream.html ~code:404 (Template.Not_found.render ())
  let homepage _req = Dream.html (Template.Homepage.render ())
end

module Router = struct
  let loader root path request =
    match Asset.read (root ^ path) with
    | None -> Handler.not_found request
    | Some asset -> Dream.respond ~headers:(Dream.mime_lookup path) asset

  let t =
    Dream.router
      [
        Dream.get "/" Handler.homepage;
        Dream.get "/**" (Dream.static ~loader "");
      ]
end

let main =
  Dream.serve
  @@ Dream.logger
  @@ Router.t

let () = Lwt_main.run main