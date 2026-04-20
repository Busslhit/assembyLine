AssemblyLine Skill

Commands:

/assemblyLine template[N] : Generates a chain template of length N.
/assemblyLine help : Shows macro definitions.
/assemblyLine (model) + ["prompt" + [macro]] > ... : Executes the chain.
Logic:

The tool passes the original goal, the previous model's output, and a specific "Refinement Instruction" (macro) to the next model in the line.
