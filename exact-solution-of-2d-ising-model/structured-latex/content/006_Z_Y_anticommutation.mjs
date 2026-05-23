import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "Z_Y_anticommutation_001_claim_anticommutation_relations_Z_and_Y",
    kind: "claim",
    sourcePath: "parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ",
    sourceOrdinal: 1,
    title: { tex: String.raw`Z\text{と}Y\text{の反交換関係}` },
    labels: ["anticommutator_of_Z_and_Y"],
    statement: [
      displayMath(
        String.raw`[Z_\mu, Z_\nu]_+ = 2I_{(\mathbb{C}^2)^{\otimes M}} \delta^M_{(\mu,\nu)}, \quad
[Z_\mu, Y_\nu]_+ = 0, \quad
[Y_\mu, Y_\nu]_+ = 2I_{(\mathbb{C}^2)^{\otimes M}} \delta^M_{(\mu,\nu)}`,
      ),
    ],
    proof: [
      paragraph([math(String.raw`\mu, \nu \in \mathcal{M}`), " について、"]),
      paragraph([math(String.raw`\mu = \nu`), " のとき、"]),
      displayMath(
        String.raw`[Z_\mu, Z_\mu]_+ = Z_\mu Z_\mu + Z_\mu Z_\mu = 2I_{(\mathbb{C}^2)^{\otimes M}}`,
      ),
      paragraph([math(String.raw`\mu < \nu`), " のとき、テンソル積の反交換関係から"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\nu]_+
&= \sum_{j,k=1}^{M} (\pm 1)_j (\pm 1)_k
   \exp\!\left(-i\tfrac{2\pi}{M}(j\mu+k\nu)\right)
   [Z_j, Z_k]_+ \\
&= \sum_{j=1}^{M} \exp\!\left(-i\tfrac{2\pi j}{M}(\mu+\nu)\right)
   \cdot 2I_{(\mathbb{C}^2)^{\otimes M}}
   = 0
\end{aligned}`,
      ),
      paragraph([todo("TODO: [Z_μ, Y_ν]_+ = 0 および [Y_μ, Y_ν]_+ も同様（原文も TODO）")]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: [
        "原文の証明は μ<ν の場合のテンソル積計算を詳述しているが、要点のみ抽出。",
        "[Z_μ,Y_ν]_+ と [Y_μ,Y_ν]_+ は原文も TODO のまま。",
      ],
    },
  },
]);
