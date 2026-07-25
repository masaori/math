import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_Z_Y_anticommutation",
    kind: "heading",
    level: 2,
    sourcePath: "main.typ",
    sourceOrdinal: 8,
    title: { tex: String.raw`Z\text{と}Y\text{の反交換関係}` },
    labels: [],
    conversion: { status: "converted" },
  },
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
        String.raw`\begin{aligned}
[Z_\mu, Z_\mu]_+
&= Z_\mu Z_\mu + Z_\mu Z_\mu \\
&= 2 I_{(\mathbb{C}^2)^{\otimes M}}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu < \nu`),
        " のとき、",
        math(String.raw`Z_\mu, Z_\nu`),
        " をテンソル積で表して各サイトごとに積をとると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\nu]_+
&= Z_\mu Z_\nu + Z_\nu Z_\mu \\
&= (\sigma_1^x\cdots\sigma_{\mu-1}^x\cdot\sigma_\mu^z)(\sigma_1^x\cdots\sigma_\mu^x\cdots\sigma_{\nu-1}^x\sigma_\nu^z)
+ (\sigma_1^x\cdots\sigma_\mu^x\cdots\sigma_{\nu-1}^x\sigma_\nu^z)(\sigma_1^x\cdots\sigma_{\mu-1}^x\cdot\sigma_\mu^z) \\
&= \left(\sigma^x\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}\otimes\overbrace{\sigma^z}^{\mu\text{th}}\right)
\left(\sigma^x\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}\otimes\overbrace{\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}\otimes\overbrace{\sigma^z}^{\nu\text{th}}\right) \\
&\quad + \left(\sigma^x\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}\otimes\overbrace{\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}\otimes\overbrace{\sigma^z}^{\nu\text{th}}\right)
\left(\sigma^x\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}\otimes\overbrace{\sigma^z}^{\mu\text{th}}\right) \\
&= \left(\sigma^x\sigma^x\otimes\cdots\otimes\overbrace{\sigma^x\sigma^x}^{(\mu-1)\text{th}}\otimes\overbrace{\sigma^z\sigma^x}^{\mu\text{th}}\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}\otimes\overbrace{\sigma^z}^{\nu\text{th}}\right) \\
&\quad + \left(\sigma^x\sigma^x\otimes\cdots\otimes\overbrace{\sigma^x\sigma^x}^{(\mu-1)\text{th}}\otimes\overbrace{\sigma^x\sigma^z}^{\mu\text{th}}\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}\otimes\overbrace{\sigma^z}^{\nu\text{th}}\right) \\
&= \left(I_{(\mathbb{C}^2)^{\otimes M}}\otimes\cdots\otimes\overbrace{I_{(\mathbb{C}^2)^{\otimes M}}}^{(\mu-1)\text{th}}\otimes\overbrace{\sigma^z\sigma^x}^{\mu\text{th}}\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}\otimes\overbrace{\sigma^z}^{\nu\text{th}}\right) \\
&\quad + \left(I_{(\mathbb{C}^2)^{\otimes M}}\otimes\cdots\otimes\overbrace{I_{(\mathbb{C}^2)^{\otimes M}}}^{(\mu-1)\text{th}}\otimes\overbrace{\sigma^x\sigma^z}^{\mu\text{th}}\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}\otimes\overbrace{\sigma^z}^{\nu\text{th}}\right) \\
&= \left(I_{(\mathbb{C}^2)^{\otimes M}}\otimes\cdots\otimes\overbrace{\sigma^z\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^z}^{\nu\text{th}}\right)
- \left(I_{(\mathbb{C}^2)^{\otimes M}}\otimes\cdots\otimes\overbrace{\sigma^z\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^z}^{\nu\text{th}}\right) \\
&= 0
\end{aligned}`,
      ),
      paragraph([
        "最後から 2 つ目の等号は、第 ",
        math(String.raw`\mu`),
        " 因子について ",
        math(String.raw`\sigma^x\sigma^z = -\sigma^z\sigma^x`),
        " より第 2 項が第 1 項の ",
        math(String.raw`-1`),
        " 倍になることによる。",
        math(String.raw`\mu > \nu`),
        " のときも左右対称に同様であるから、",
        math(String.raw`\mu\neq\nu`),
        " では ",
        math(String.raw`[Z_\mu,Z_\nu]_+ = 0 = 2I_{(\mathbb{C}^2)^{\otimes M}}\delta^M_{(\mu,\nu)}`),
        "。",
      ]),
      paragraph([todo("TODO: [Z_μ, Y_ν]_+ = 0 および [Y_μ, Y_ν]_+ も同様（原文も TODO のまま）")]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の μ<ν のテンソル積展開を全ステップ忠実に再現した（σ^x σ^z = -σ^z σ^x による相殺）。",
        "[Z_μ,Y_ν]_+ と [Y_μ,Y_ν]_+ は原文自体が TODO のため todo() で保持。",
      ],
    },
  },
]);
