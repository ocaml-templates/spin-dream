(name dream)

(description "Dream web application")

(raw_files asset/favicon.ico asset/vendors/**)

(config project_name
  (input (prompt "Project name:")))

(config project_slug
  (input (prompt "Project slug:"))
  (default (slugify :project_name))
  (rules
    ("The project slug must be lowercase and contain ASCII characters and '-' only."
      (eq :project_slug (slugify :project_slug)))))

(config project_snake
  (default (snake_case :project_slug)))

(config create_switch
  (default true))

(config project_description
  (input (prompt "Description:"))
  (default "A short, but powerful statement about your project")
  (rules
    ("The last character of the description cannot be a \".\" to comply with opam"
      (neq . (last_char :project_description)))))

(config author_name
  (input (prompt "Name of the author:")))

(post_gen
  (actions
    (run make create_switch)
    (run make deps)
    (run make build))
  (message "🎁  Installing packages in a switch. This might take a couple minutes.")
  (enabled_if (eq :create_switch true)))

(post_gen
  (actions
    (run make deps)
    (run make build))
  (message "🎁  Installing packages globally. This might take a couple minutes.")
  (enabled_if (eq :create_switch false)))

(example_commands
  (commands
    ("make start" "Run the server.")
    ("make build" "Build the dependencies and the project.")
    ("make deps" "Download runtime and development dependencies.")))
