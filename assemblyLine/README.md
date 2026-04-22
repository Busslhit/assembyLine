# Assemblyline Skill

### Commands:
- `/assemblyline template[N]` : Generates a chain template of length N.
- `/assemblyline help` : Shows macro definitions.
- `/assemblyline (model) + ["prompt" + [macro]] > ...` : Executes the chain.

### Logic:
The tool passes the original goal, the previous model's output, and a specific "Refinement Instruction" (macro) to the next model in the line.


# How the macros work: The macros are in the pass_on.txt. You can edit it to add any macro you want with the macros description.

if model 1 is asked: summararize this article. the next macro can tell model 2 what to do with that summary. 
