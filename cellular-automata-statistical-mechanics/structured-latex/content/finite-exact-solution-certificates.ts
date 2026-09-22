/**
 * 厳密解の候補を限定する個別の有限証明書を、可解性一般から分離する。
 * 各証明書の入力型・出力・有限判定を明示し、異なる証明書を一つの述語へ潰さない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_exact_solution_certificates_remark_scope",
    kind: "remark",
    title: { text: "有限証明書と可解性一般を区別する" },
    labels: ["remark_finite_certificates_not_general_solvability"],
    habitat: "none",
    statement: [
      paragraph([
        "本節でいう有限証明書は、有限入力上の個別の等式または全単射条件が成り立つことを証明する有限データである。",
        "Yang--Baxter 条件、古典的非退化性、", ref("def_binary_field_linear_local_rule_family"),
        " の二元体上の線形性は入力型も結論も異なるため、一つの「可解性」述語と同一視しない。",
        "T. Gombor--B. Pozsgay, “Superintegrable cellular automata and dual unitary gates from Yang--Baxter maps,” SciPost Physics 12 (2022) 102 は、非退化な Yang--Baxter 写像から得る構造を扱う一方、観測量を計算する一般解法は未確立と明記する。",
        "B. Bertini--P. Kos--T. Prosen, “Exact correlation functions for dual-unitary lattice models in 1+1 dimensions,” Physical Review Letters 123 (2019) 210601 は双ユニタリ模型を可積分性とは独立に扱う。",
        "従って本節の出力は各有限条件の真偽であり、有限舞台上の 2 値セルオートマトンから別途定義する量の一般的な計算法ではない。",
      ]),
    ],
  },
  {
    id: "finite_exact_solution_certificates_definition_classical_nondegeneracy",
    kind: "definition",
    title: { text: "有限二体写像の古典的非退化性" },
    labels: ["def_finite_pair_map_classical_nondegeneracy"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_pair_map"), " の有限二体写像 ", math(String.raw`R:X\times X\to X\times X`),
        " を ", math(String.raw`R(x,y)=(R_1(x,y),R_2(x,y))`), " と書く。各 ",
        math(String.raw`x\in X`), " に対する写像 ", math(String.raw`L_x:X\to X`), " と、各 ",
        math(String.raw`y\in X`), " に対する写像 ", math(String.raw`M_y:X\to X`), " を",
      ]),
      displayMath(String.raw`L_x(y):=R_1(x,y),\qquad M_y(x):=R_2(x,y)`),
      paragraph([
        "で定める。全ての ", math(String.raw`x,y\in X`), " について ", math(String.raw`L_x`),
        " と ", math(String.raw`M_y`), " が全単射であるとき、", math(String.raw`R`),
        " は古典的に非退化であるという。有限集合、成分射影、写像の全単射性以外の構造は仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_exact_solution_certificates_claim_classical_nondegeneracy_decidable",
    kind: "claim",
    title: { text: "古典的非退化性は有限表の全走査で決定できる" },
    labels: ["claim_finite_pair_map_classical_nondegeneracy_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`|X|=n\in\mathbb N`), " とする。",
        ref("def_finite_pair_map_classical_nondegeneracy"),
        " の条件は、各 ", math(String.raw`L_x`), " と ", math(String.raw`M_y`),
        " の値表に重複がないことを比較する有限手続きで決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "有限集合 ", math(String.raw`X`), " から自身への写像は、値表に重複がなければ単射である。",
        "定義域と終域がともに元数 ", math(String.raw`n`), " なので、その単射は全単射である。",
        "逆に全単射なら値表に重複はない。従って ", math(String.raw`n`), " 個の ", math(String.raw`L_x`),
        " と ", math(String.raw`n`), " 個の ", math(String.raw`M_y`),
        " について、それぞれ有限個の値を比較すれば条件の真偽が決まる。",
      ]),
    ],
  },
  {
    id: "finite_exact_solution_certificates_claim_nondegenerate_not_yang_baxter",
    kind: "claim",
    title: { text: "古典的非退化性だけでは有限 Yang–Baxter 条件は従わない" },
    labels: ["claim_classical_nondegeneracy_does_not_imply_yang_baxter"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`B:=\{0,1\}`), " とし、有限二体写像 ", math(String.raw`Q:B^2\to B^2`), " を",
      ]),
      displayMath(String.raw`Q(0,0)=(0,0),\quad Q(0,1)=(1,0),\quad Q(1,0)=(1,1),\quad Q(1,1)=(0,1)`),
      paragraph([
        "で定める。この ", math(String.raw`Q`), " は古典的に非退化だが、有限 Yang--Baxter 写像ではない。",
      ]),
    ],
    proof: [
      paragraph([
        "第一成分について ", math(String.raw`L_0(0)=0,L_0(1)=1,L_1(0)=1,L_1(1)=0`),
        " であり、第二成分について ", math(String.raw`M_0(0)=0,M_0(1)=1,M_1(0)=0,M_1(1)=1`),
        " である。従って四写像は全て ", math(String.raw`B`), " の全単射であり、",
        ref("def_finite_pair_map_classical_nondegeneracy"), " を満たす。",
      ]),
      paragraph([ref("def_finite_pair_map_adjacent_lifts"), " により"]),
      displayMath(String.raw`\begin{aligned}
(Q_{12}\circ Q_{23}\circ Q_{12})(1,0,0)&=(0,1,1),\\
(Q_{23}\circ Q_{12}\circ Q_{23})(1,0,0)&=(1,1,1).
\end{aligned}`),
      paragraph([
        "一つの入力で値が異なるので ", ref("def_finite_yang_baxter_map"), " は成り立たない。",
      ]),
    ],
  },
  {
    id: "finite_exact_solution_certificates_claim_individual_decisions",
    kind: "claim",
    title: { text: "三つの有限証明書は別々の判定手続きを持つ" },
    labels: ["claim_exact_solution_candidate_certificates_individually_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("remark_finite_certificates_not_general_solvability"), " の区別の下で、有限二体写像の Yang--Baxter 条件は ", ref("claim_finite_yang_baxter_condition_decidable"),
        "、古典的非退化性は ", ref("claim_finite_pair_map_classical_nondegeneracy_decidable"),
        "、有限舞台上の二元体線形な局所規則族への所属は ", ref("claim_binary_field_linear_membership_finite_decidable"),
        " の各有限手続きで決定できる。前二者の入力は ", math(String.raw`X^2\to X^2`),
        " の二体写像であり、最後の入力は近傍ごとの ", math(String.raw`A^{N(v)}\to A`),
        " の局所規則族である。従って比較写像を定義せずに三条件を同じ入力上の一つの述語として扱わない。",
      ]),
    ],
    proof: [
      paragraph([
        "三つの決定手続きは引用した各主張で既に与えられている。入力型の相違は各定義域の直積出力と一成分出力の相違から従う。",
        ref("claim_classical_nondegeneracy_does_not_imply_yang_baxter"),
        " は、同じ入力型を持つ二条件でさえ一方から他方が従わない有限反例を与える。",
      ]),
    ],
  },
]);
