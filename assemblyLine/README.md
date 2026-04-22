# Assemblyline Skill

### Commands:
- `/assemblyline template[N]` : Generates a chain template of length N.
- `/assemblyline help` : Shows macro definitions.
- `/assemblyline (model) + ["prompt" + [macro]] > ...` : Executes the chain.

### Logic:
The tool passes the original goal, the previous model's output, and a specific "Refinement Instruction" (macro) to the next model in the line.
