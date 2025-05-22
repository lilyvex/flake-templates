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

      default = self.templates.rust;
    };
  };
}
