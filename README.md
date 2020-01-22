# discoball

Discoball is a wrapper for the Discord API made in Ballerina. 

## Installation

First, you must execute these commands in a command prompt.

```bash
$ git clone https://github.com/discoball/discoball
$ cd discoball
$ ballerina build -c --all
```

Then, in your source, refer to the `.balo` files that can be found at `discoball/target/balo` in the `Ballerina.toml` configuration file.

```toml
[dependencies]
"discoball/http" = { path = "discoball/target/balo/http-YYYYrV-any-MAJOR.MINOR.PATCH.balo" }
"discoball/models" = { path = "discoball/target/balo/models-YYYYrV-any-MAJOR.MINOR.PATCH.balo" }
```

## Documentation

This can be found at https://discoball.github.io/docs.
