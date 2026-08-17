/**
 * 奇数周期で回文性が崩れる証明から、整数座標の算術を落とす。
 *
 * 有限集合、方向の有限集合、軌道長が一定の置換だけを置く。
 * 非可算な量は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "periodic_structural_core_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 周期族から整数の算術を落とす" },
    labels: [],
  },

  {
    id: "periodic_structural_core_definition_successor_system",
    kind: "definition",
    title: { text: "軌道長が一定の有限周期後続系" },
    labels: ["def_periodic_successor_system"],
    habitat: "N",
    statement: [
      paragraph([
        "空でない有限集合 ",
        math(String.raw`V`),
        "、空でない方向の有限集合 ",
        math(String.raw`I`),
        "、正の自然数 ",
        math(String.raw`L`),
        " を取る。各 ",
        math(String.raw`i\in I`),
        " に対して全単射 ",
        math(String.raw`s_i:V\to V`),
        " を取り、各 ",
        math(String.raw`a\in V`),
        " について",
      ]),
      displayMath(
        String.raw`s_i^{\circ L}(a)=a,\qquad
s_i^{\circ k}(a)\ne a\quad(0<k<L)`,
      ),
      paragraph([
        "が成り立つと仮定する。ここで ",
        math(String.raw`s_i^{\circ k}`),
        " は写像 ",
        math(String.raw`s_i`),
        " の ",
        math(String.raw`k`),
        " 回の合成である。このデータ全体を軌道長 ",
        math(String.raw`L`),
        " の有限周期後続系と呼ぶ。整数の加法・順序・剰余類は置かない。",
      ]),
    ],
  },

  {
    id: "periodic_structural_core_definition_edges",
    kind: "definition",
    title: { text: "有限周期後続系の辺と端点写像" },
    labels: ["def_periodic_successor_edges"],
    habitat: "N",
    statement: [
      paragraph([
        "軌道長 ",
        math(String.raw`L`),
        " の有限周期後続系（",
        ref("def_periodic_successor_system"),
        "）に対して、辺の有限集合と二つの端点写像を",
      ]),
      displayMath(
        String.raw`E=V\times I,\qquad
\partial_0(a,i)=a,\qquad
\partial_1(a,i)=s_i(a)`,
      ),
      paragraph(["で定める。"]),
    ],
  },

  {
    id: "periodic_structural_core_definition_multiplicity",
    kind: "definition",
    title: { text: "有限周期後続系の破れ数と多重度" },
    labels: ["def_periodic_successor_multiplicity"],
    habitat: "N",
    statement: [
      paragraph([
        "配位の有限集合を ",
        math(String.raw`\Sigma=\{\,\sigma:V\to\{+1,-1\}\,\}`),
        " と置く。配位 ",
        math(String.raw`\sigma\in\Sigma`),
        " の破れ辺集合と破れ数を",
      ]),
      displayMath(
        String.raw`D(\sigma)=\{\,e\in E:\sigma(\partial_0e)\ne\sigma(\partial_1e)\,\},\qquad
b(\sigma)=\#D(\sigma)`,
      ),
      paragraph(["と定める。自然数 ", math(String.raw`m`), " に対して"]),
      displayMath(String.raw`\Omega_E(m)=\#\{\,\sigma\in\Sigma:b(\sigma)=m\,\}`),
      paragraph(["を有限周期後続系の多重度と呼ぶ。"]),
    ],
  },

  {
    id: "periodic_structural_core_claim_odd_orbit_not_palindrome",
    kind: "claim",
    standing: "mainTheorem",
    title: { text: "奇数軌道では多重度は回文でない" },
    labels: ["claim_periodic_successor_not_palindrome"],
    habitat: "N",
    statement: [
      paragraph([
        "軌道長 ",
        math(String.raw`L`),
        " が奇数ならば",
      ]),
      displayMath(String.raw`\Omega_E(0)\ne\Omega_E(\#E-0)`),
      paragraph([
        "が成り立つ。したがって周期族の非回文性（",
        ref("claim_periodic_not_palindrome"),
        "）に、整数の加法・順序・座標・剰余類は要らない。",
      ]),
    ],
    proof: [
      paragraph([
        "定数配位 ",
        math(String.raw`\sigma^+(a)=+1`),
        " はすべての辺で両端の値が等しいので ",
        math(String.raw`b(\sigma^+)=0`),
        " である（",
        ref("def_periodic_successor_edges"),
        "、",
        ref("def_periodic_successor_multiplicity"),
        "）。したがって ",
        math(String.raw`\Omega_E(0)\ge1`),
        " である。",
      ]),
      paragraph([
        "次に、すべての辺を破る配位 ",
        math(String.raw`\sigma\in\Sigma`),
        " があると仮定する。方向 ",
        math(String.raw`i\in I`),
        " と点 ",
        math(String.raw`a\in V`),
        " を一つ取り、",
        math(String.raw`v_k=s_i^{\circ k}(a)`),
        " と置く。軌道長の条件から ",
        math(String.raw`v_L=v_0`),
        " である（",
        ref("def_periodic_successor_system"),
        "）。各 ",
        math(String.raw`k\in\{0,\ldots,L-1\}`),
        " で辺 ",
        math(String.raw`(v_k,i)`),
        " は破れているから、値が ",
        math(String.raw`\{+1,-1\}`),
        " に属することより ",
        math(String.raw`\sigma(v_k)\sigma(v_{k+1})=-1`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
-1
&=(-1)^L
&&(\because\ L\ \text{は奇数})\\
&=\prod_{k=0}^{L-1}\sigma(v_k)\sigma(v_{k+1})
&&(\because\ \text{各軌道辺は破れている})\\
&=\left(\prod_{k=0}^{L-1}\sigma(v_k)\right)
  \left(\prod_{k=0}^{L-1}\sigma(v_{k+1})\right)
&&(\because\ \text{整数の積の交換法則と結合法則})\\
&=\left(\prod_{k=0}^{L-1}\sigma(v_k)\right)^2
&&(\because\ v_L=v_0\ \text{なので二つの有限積の因子は同じ})\\
&=1
&&(\because\ \sigma(v_k)\in\{+1,-1\}\ \text{なので有限積も}\ \{+1,-1\}\ \text{に属する})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`-1\ne1`),
        " なので矛盾である。したがってすべての辺を破る配位は無い。",
        math(String.raw`D(\sigma)\subseteq E`),
        " であるため、",
        math(String.raw`b(\sigma)=\#E`),
        " ならば有限集合の部分集合と全体の元の個数が等しく ",
        math(String.raw`D(\sigma)=E`),
        " となる。ゆえに ",
        math(String.raw`\Omega_E(\#E)=0`),
        " である（",
        ref("def_periodic_successor_multiplicity"),
        "）。ゆえに",
      ]),
      displayMath(
        String.raw`\Omega_E(0)\ge1>0=\Omega_E(\#E)=\Omega_E(\#E-0)`,
      ),
      paragraph(["であり、二つの多重度は等しくない。"]),
    ],
  },
]);
