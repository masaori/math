/** 対象の正本。停止・起動の状態はここへ固定せず、毎回一次情報を読む。 */
export const projects = [
  { name: "cellular-automata-statistical-mechanics", title: "セルオートマトン統計力学", state: "auto-loop-state.md", runbook: "auto-loop-runbook.md" },
  { name: "exact-solution-of-2d-ising-model", title: "複素行列版二次元イジング", state: "paper-organization-state.md", runbook: "paper-organization-runbook.md" },
  { name: "exact-solution-of-2d-ising-model-lambda", title: "可算二次元イジング", state: "auto-loop-state.md", runbook: "auto-loop-runbook.md" },
  { name: "countable-core-of-3d-ising", title: "三次元イジングの可算コア", state: "auto-loop-state.md", runbook: "auto-loop-runbook.md" },
  { name: "finite-graph-ising-partition-polynomial-and-fisher-zeros", title: "一般有限グラフのイジング", state: "auto-loop-state.md", runbook: "auto-loop-runbook.md" },
  { name: "countable-ising-on-hyperbolic-surfaces", title: "双曲曲面のイジング", state: "auto-loop-state.md", runbook: "auto-loop-runbook.md" },
] as const;

export function projectNamed(name: string) {
  const project = projects.find(project => project.name === name);
  if (!project) throw new Error(`監督対象にない研究: ${name}`);
  return project;
}
