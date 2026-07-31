/**
 * 論文本体 第 3 章: アルキメデス素点側（既知）。
 *
 * ここが本論文で唯一 ℝ を使う章である。内容はすべて既知定理であり、
 * 本論文は文献の命題番号と仮定を特定して引用するだけである。
 */

import { defineBlocks, displayMath, list, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "paper_030_heading_archimedean",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex/content/003_archimedean.ts", ordinal: 1 },
    title: { text: "アルキメデス素点側（既知）— ここだけが ℝ を使う" },
    labels: [],
  },
  {
    id: "paper_031_theorem_lsw",
    kind: "theorem",
    origin: { path: "structured-latex/content/003_archimedean.ts", ordinal: 2 },
    title: { text: "エントロピー＝Mahler 測度、および周期点の増大率（いずれも既知）" },
    labels: ["paper_thm_archimedean"],
    habitat: "R",
    realEscape:
      "本定理の結論そのものが ℝ の元（log m(P)）への収束である。本論文で ℝ を使うのはこの一点だけであり、" +
      "第 4 章以降の Λ 側の主張はいずれもこの定理に依存しない。",
    statement: [
      paragraph([
        math(String.raw`P\in\mathbb{Z}[z_1^{\pm},\dots,z_d^{\pm}]\setminus\{0\}`),
        " の Mahler 測度を ",
        math(String.raw`m(P)`),
        "、複素単位トーラス上の零点集合を ",
        math(String.raw`\mathsf U(P)=\{z\in\mathbb{S}^d:P(z)=0\}`),
        " とする。次はいずれも**既知**である。",
      ]),
      list([
        [
          "**(i)** 代数的 ",
          math(String.raw`\mathbb{Z}^d`),
          " 作用の位相的エントロピーは ",
          math(String.raw`\log m(P)`),
          " に等しい。**仮定は無い**（Lind–Schmidt–Ward, Invent. math. **101** (1990) 593–629, Theorem 3.1）。",
        ],
        [
          "**(ii)** 周期点の増大率がエントロピーに一致することは**一般には成立しない**。",
          "expansive な作用（",
          math(String.raw`\mathsf U(P)=\varnothing`),
          " と同値）では成立する（同 Theorem 7.1）。",
        ],
        [
          "**(iii)** ",
          math(String.raw`\mathsf U(P)`),
          " が**有限集合**なら成立する（Lind–Schmidt–Verbitskiy, arXiv:1108.4989, Theorem 1.2）。",
        ],
        [
          "**(iv)** より一般に ",
          math(String.raw`\dim\mathsf U(P)\le d-2`),
          "（",
          math(String.raw`P`),
          " が **atoral**）なら成立する（同 Theorem 1.3）。",
        ],
      ]),
      paragraph([
        "したがって ",
        math(String.raw`P`),
        " が atoral ならば",
      ]),
      displayMath(
        String.raw`\frac{1}{L^{d}}\log\bigl|a^{\mathrm{red}}_L\bigr|\ \longrightarrow\ \log m(P)\qquad(L\to\infty).`,
      ),
    ],
    proof: [
      paragraph([
        "**証明しない。上記 (i)–(iv) は既知定理であり、本論文はこれを引用するだけである。**",
        "本論文の寄与は、この定理が成り立つ一般性の 3 段（expansive / ",
        math(String.raw`\mathsf U`),
        " 有限 / atoral）を命題番号つきで特定し、",
        ref("paper_def_curve"),
        " の設定と接続したことに限られる。",
      ]),
      paragraph([
        "**注意（規約の差）**: Lind–Schmidt–Verbitskiy が扱う ",
        math(String.raw`\mathsf P_\Gamma`),
        " は周期成分の個数であり、本論文の ",
        math(String.raw`a^{\mathrm{red}}_L`),
        "（トーラス零点を除いた積）とは因子 ",
        math(String.raw`c_\Gamma(f)`),
        " だけずれる。同論文はこのずれを明記したうえで、",
        math(String.raw`\frac{1}{|\mathbb{Z}^d/\Gamma|}\log c_\Gamma(f)\to0`),
        " なので漸近的には一致すると述べている。上式はその意味で読む。",
      ]),
    ],
  },
  {
    id: "paper_032_remark_ising_known",
    kind: "remark",
    origin: { path: "structured-latex/content/003_archimedean.ts", ordinal: 3 },
    title: { text: "統計力学側の既知結果" },
    labels: ["paper_remark_ising_known"],
    habitat: "R",
    realEscape:
      "自由エネルギー密度そのものが ℝ の量である。本注記は既知結果の所在を示すだけで、" +
      "本論文の主張はこれに依存しない。",
    statement: [
      paragraph([
        "統計力学の自由エネルギー密度が Mahler 測度で書けること、および 2 次元 Ising 模型について",
        "特殊温度で楕円曲線の Hasse–Weil ",
        math(String.raw`L`),
        " 函数、臨界点で Dirichlet ",
        math(String.raw`L`),
        " 函数が現れることは**既知**である",
        "（arXiv:2407.19531 / Phys. Rev. E **110**, 054134 (2024)）。",
      ]),
      paragraph([
        math(String.raw`\mathbb{Z}^2`),
        " トーラスの全域木エントロピーが ",
        math(String.raw`4G/\pi`),
        "（",
        math(String.raw`G`),
        " は Catalan 定数）に収束することも古典的に既知である。本論文ではこれを",
        "**枠組みの妥当性検査**としてのみ使い、他の量との接続は主張しない。",
      ]),
    ],
  },
]);
