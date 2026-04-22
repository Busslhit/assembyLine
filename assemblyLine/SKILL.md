name: assemblyline
description: "Sequential chain of Ollama models with custom pass-on macros and dynamic templates."
slash:
  trigger: "/assemblyline"
  description: "Run a chain or generate a template."
  examples:
    - "/assemblyline template[3]"
    - "/assemblyline (llama3) + [\"Hello\" + [upscale]]"
disable-model-invocation: false
requirements:
  - cli: ollama
  - shell: bash
command-dispatch: true
