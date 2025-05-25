{
  description = "Lily's flake templates";

  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust template, using Naersk";
      };

      go = {
        path = ./go;
        description = "Go template";
      };

      cpp-meson = {
        path = ./cpp-meson;
        description = "C++ Meson template with Clang";
      };

      c-meson = {
        path = ./c-meson;
        description = "C Meson template with Clang";
      };

      latex = {
        path = ./latex;
        description = "LaTeX template";
      };

      nodejs = {
        path = ./nodejs;
        description = "NodeJS template";
      };

      default = self.templates.rust;
    };
  };
}
