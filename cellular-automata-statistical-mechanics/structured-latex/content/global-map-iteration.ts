/**
 * 章「大域写像の反復と軌道の最終周期性」: 第二の探索列の最初の章。
 * 有限舞台上の大域写像 F: A^V → A^V（前章までの定義）を自然数回反復し、
 * 有限集合上の写像であることだけから内在的に定まる構造を抽出する。
 *
 * - 反復 F^n と軌道 O(y) の定義（時刻・物理的意味を入れない）
 * - 軌道の衝突: 各配位 y について 0 ≤ i < j ≤ 2^{|V|} で F^i y = F^j y となる組がある（鳩の巣）
 * - 最終周期性: 衝突から、ある p ≥ 1 と i について全ての n ≥ i で F^{n+p} y = F^n y
 * - 有限決定可能性: 衝突する組は高々 2^{|V|}+1 個の配位の等号検査で見つかる
 *
 * 使う ℕ の構造は大小比較・後者・加法・等号だけである。無限舞台・極限集合・
 * 全配位空間の位相は扱わない（remark に明記）。ℝ/ℂ は現れない。
 * 文書順はこの配列の並びが正本である。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "global_map_iteration_heading",
    kind: "heading",
    level: 1,
    title: { text: "大域写像の反復と軌道の最終周期性" },
    labels: [],
  },

  {
    id: "global_map_iteration_definition_iterate",
    kind: "definition",
    title: { text: "大域写像の反復" },
    labels: ["def_global_map_iterate"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台上の 2 値セルオートマトン ",
        math(String.raw`\bigl((V,N),(f_v)_{v\in V}\bigr)`),
        "（",
        ref("def_finite_ca"),
        "）の大域写像 ",
        math(String.raw`F:A^{V}\to A^{V}`),
        "（",
        ref("def_global_map"),
        "）に対し、各 ",
        math(String.raw`n\in\mathbb{N}`),
        " について写像 ",
        math(String.raw`F^{n}:A^{V}\to A^{V}`),
        " を ",
        math(String.raw`n`),
        " についての再帰で",
      ]),
      displayMath(
        String.raw`F^{0}\,y:=y,\qquad F^{n+1}\,y:=F\,(F^{n}\,y)\qquad(y\in A^{V},\ n\in\mathbb{N})`,
      ),
      paragraph([
        "と定め、",
        math(String.raw`F`),
        " の ",
        math(String.raw`n`),
        " 回反復と呼ぶ。",
        math(String.raw`\mathbb{N}`),
        " について使うのは後者 ",
        math(String.raw`n\mapsto n+1`),
        "、加法、大小比較、等号だけである。",
      ]),
    ],
  },

  {
    id: "global_map_iteration_definition_orbit",
    kind: "definition",
    title: { text: "配位の軌道" },
    labels: ["def_orbit"],
    habitat: "finite",
    statement: [
      paragraph([
        "配位 ",
        math(String.raw`y\in A^{V}`),
        " に対し、集合",
      ]),
      displayMath(String.raw`O(y):=\{\,F^{n}\,y\ :\ n\in\mathbb{N}\,\}\subseteq A^{V}`),
      paragraph([
        "を ",
        math(String.raw`y`),
        " の軌道と呼ぶ（",
        math(String.raw`F^{n}`),
        " は ",
        ref("def_global_map_iterate"),
        "）。",
        math(String.raw`O(y)`),
        " は有限集合 ",
        math(String.raw`A^{V}`),
        " の部分集合なので有限集合である（",
        math(String.raw`A^{V}`),
        " の有限性は、",
        math(String.raw`A`),
        " と ",
        math(String.raw`V`),
        " がともに有限集合であることによる。",
        ref("def_state_set"),
        "、",
        ref("def_finite_stage"),
        "）。",
      ]),
    ],
  },

  {
    id: "global_map_iteration_claim_orbit_collision",
    kind: "claim",
    title: { text: "軌道は高々 2^{|V|} 回の反復のうちに衝突する" },
    labels: ["claim_orbit_collision"],
    habitat: "N",
    statement: [
      paragraph([
        "各配位 ",
        math(String.raw`y\in A^{V}`),
        " について、",
        math(String.raw`0\le i<j\le 2^{|V|}`),
        " を満たす ",
        math(String.raw`i,j\in\mathbb{N}`),
        " で ",
        math(String.raw`F^{i}\,y=F^{j}\,y`),
        " となるものが存在する（",
        math(String.raw`|V|`),
        " は ",
        ref("def_cardinality_notation"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`M:=2^{|V|}\in\mathbb{N}`),
        " と置く。写像 ",
        math(String.raw`\iota_y:\{0,1,\dots,M\}\to A^{V}`),
        " を ",
        math(String.raw`\iota_y(n):=F^{n}\,y`),
        " で定める（",
        ref("def_global_map_iterate"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
|A^{V}|
&=|A|^{|V|}\qquad(\because\ \text{有限集合 } V \text{ から有限集合 } A \text{ への写像の個数は } |A|^{|V|})\\
&=2^{|V|}\qquad(\because\ |A|=2.\ \blkref{def_state_set})\\
&=M\qquad(\because\ M \text{ の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
|\{0,1,\dots,M\}|
&=M+1\qquad(\because\ 0 \text{ から } M \text{ までの自然数は } M+1 \text{ 個})\\
&>M\qquad(\because\ \mathbb{N} \text{ の大小比較})\\
&=|A^{V}|\qquad(\because\ \text{上の等式})
\end{aligned}`),
      paragraph([
        "定義域の元の個数が終域の元の個数より大きいので、",
        math(String.raw`\iota_y`),
        " は単射でない（鳩の巣原理：単射があれば定義域の個数は終域の個数以下である）。",
        "すなわち ",
        math(String.raw`i\ne j`),
        " かつ ",
        math(String.raw`\iota_y(i)=\iota_y(j)`),
        " を満たす ",
        math(String.raw`i,j\in\{0,1,\dots,M\}`),
        " が存在する。",
        math(String.raw`\mathbb{N}`),
        " の大小は全順序なので、必要なら ",
        math(String.raw`i`),
        " と ",
        math(String.raw`j`),
        " を入れ替えて ",
        math(String.raw`i<j`),
        " としてよく、",
        math(String.raw`\iota_y`),
        " の定義から ",
        math(String.raw`F^{i}\,y=F^{j}\,y`),
        " である。",
        math(String.raw`0\le i<j\le M=2^{|V|}`),
        " が示された。",
      ]),
    ],
  },

  {
    id: "global_map_iteration_claim_shift_invariance",
    kind: "claim",
    title: { text: "衝突は反復で保たれる" },
    labels: ["claim_collision_shift"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`y\in A^{V}`),
        "、",
        math(String.raw`i,j\in\mathbb{N}`),
        " が ",
        math(String.raw`F^{i}\,y=F^{j}\,y`),
        " を満たすならば、すべての ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`F^{i+k}\,y=F^{j+k}\,y`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k`),
        " についての帰納法で示す。",
        math(String.raw`k=0`),
        " のときは ",
        math(String.raw`i+0=i`),
        "、",
        math(String.raw`j+0=j`),
        "（",
        math(String.raw`\mathbb{N}`),
        " の加法の単位元）なので仮定そのものである。",
        math(String.raw`k`),
        " で成り立つとして ",
        math(String.raw`k+1`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{i+(k+1)}\,y
&=F^{(i+k)+1}\,y\qquad(\because\ \mathbb{N} \text{ の加法の結合則})\\
&=F\,(F^{i+k}\,y)\qquad(\because\ \blkref{def_global_map_iterate})\\
&=F\,(F^{j+k}\,y)\qquad(\because\ \text{帰納法の仮定})\\
&=F^{(j+k)+1}\,y\qquad(\because\ \blkref{def_global_map_iterate})\\
&=F^{j+(k+1)}\,y\qquad(\because\ \mathbb{N} \text{ の加法の結合則})
\end{aligned}`),
    ],
  },

  {
    id: "global_map_iteration_claim_eventual_periodicity",
    kind: "claim",
    title: { text: "軌道は最終的に周期的である" },
    labels: ["claim_eventual_periodicity"],
    habitat: "N",
    statement: [
      paragraph([
        "各配位 ",
        math(String.raw`y\in A^{V}`),
        " について、",
        math(String.raw`i\in\mathbb{N}`),
        " と ",
        math(String.raw`p\in\mathbb{N}`),
        " で、",
        math(String.raw`p\ge 1`),
        "、",
        math(String.raw`i+p\le 2^{|V|}`),
        "、かつすべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について ",
        math(String.raw`n\ge i`),
        " ならば ",
        math(String.raw`F^{n+p}\,y=F^{n}\,y`),
        " となるものが存在する。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_orbit_collision"),
        " により ",
        math(String.raw`0\le i<j\le 2^{|V|}`),
        " かつ ",
        math(String.raw`F^{i}\,y=F^{j}\,y`),
        " を満たす ",
        math(String.raw`i,j\in\mathbb{N}`),
        " を取る。",
        math(String.raw`p:=j-i\in\mathbb{N}`),
        " と置く（",
        math(String.raw`i<j`),
        " なので ",
        math(String.raw`\mathbb{N}`),
        " の中で差が取れ、",
        math(String.raw`p\ge 1`),
        "。また ",
        math(String.raw`i+p=j\le 2^{|V|}`),
        "）。",
        math(String.raw`n\in\mathbb{N}`),
        "、",
        math(String.raw`n\ge i`),
        " を任意に取り、",
        math(String.raw`k:=n-i\in\mathbb{N}`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n+p}\,y
&=F^{(i+k)+p}\,y\qquad(\because\ n=i+k.\ k \text{ の定義})\\
&=F^{(i+p)+k}\,y\qquad(\because\ \mathbb{N} \text{ の加法の結合則と交換則})\\
&=F^{j+k}\,y\qquad(\because\ i+p=j.\ p \text{ の定義})\\
&=F^{i+k}\,y\qquad(\because\ \blkref{claim_collision_shift}\ \text{を } F^{i}y=F^{j}y \text{ と } k \text{ に適用})\\
&=F^{n}\,y\qquad(\because\ i+k=n.\ k \text{ の定義})
\end{aligned}`),
    ],
  },

  {
    id: "global_map_iteration_claim_collision_finite_decidability",
    kind: "claim",
    title: { text: "衝突する組は有限個の等号検査で見つかる" },
    labels: ["claim_collision_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "各配位 ",
        math(String.raw`y\in A^{V}`),
        " について、",
        ref("claim_orbit_collision"),
        " の組 ",
        math(String.raw`(i,j)`),
        " は、配位 ",
        math(String.raw`F^{0}y,F^{1}y,\dots,F^{2^{|V|}}y`),
        " の間の等号検査高々 ",
        math(String.raw`\tfrac{1}{2}\,2^{|V|}\,(2^{|V|}+1)`),
        " 回で見つかり、",
        math(String.raw`A^{V}`),
        " の元の等号検査 1 回は ",
        math(String.raw`A`),
        " の元の等号検査 ",
        math(String.raw`|V|`),
        " 回で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`M:=2^{|V|}`),
        " と置く。",
        math(String.raw`0\le i<j\le M`),
        " を満たす組 ",
        math(String.raw`(i,j)`),
        " の全体を走査し、各組で ",
        math(String.raw`F^{i}y`),
        " と ",
        math(String.raw`F^{j}y`),
        " の等号を検査する。",
        ref("claim_orbit_collision"),
        " により、少なくとも一つの組で等号が成り立つので、走査は等号の成り立つ組を返す。",
      ]),
      displayMath(String.raw`\begin{aligned}
|\{(i,j)\ :\ 0\le i<j\le M\}|
&=\binom{M+1}{2}\qquad(\because\ M+1 \text{ 個の元から 2 個を選ぶ選び方の個数})\\
&=\tfrac{1}{2}\,(M+1)\,M\qquad(\because\ \text{二項係数の定義。}(M+1)M \text{ は偶数なので商は } \mathbb{N} \text{ の元})\\
&=\tfrac{1}{2}\,2^{|V|}\,(2^{|V|}+1)\qquad(\because\ M \text{ の定義})
\end{aligned}`),
      paragraph([
        "二つの配位 ",
        math(String.raw`z,z'\in A^{V}`),
        " について、",
        math(String.raw`z=z'`),
        " は「すべての ",
        math(String.raw`v\in V`),
        " について ",
        math(String.raw`z(v)=z'(v)`),
        "」と同値である（写像の外延性）。右辺は ",
        math(String.raw`A`),
        " の元の等号検査 ",
        math(String.raw`|V|`),
        " 回で決定できる。",
        "以上の走査で使う対象はすべて有限集合の元であり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "global_map_iteration_remark_not_claimed",
    kind: "remark",
    title: { text: "この章で主張しないこと" },
    labels: ["remark_iteration_not_claimed"],
    habitat: "finite",
    statement: [
      paragraph([
        "この章の主張はすべて有限舞台 ",
        math(String.raw`(V,N)`),
        " 上の有限集合 ",
        math(String.raw`A^{V}`),
        " と、その上の写像 ",
        math(String.raw`F`),
        " の反復についてのものである。舞台のセル集合を無限にした場合の配位空間、",
        "その上の位相、極限集合、周期点の個数の母関数（形式的冪級数）は、この章では定義も主張もしない。",
        "また、",
        ref("claim_eventual_periodicity"),
        " の ",
        math(String.raw`(i,p)`),
        " は存在だけを述べており、最小の前周期・最小の周期の定義と一意性は次の層で扱う。",
      ]),
    ],
  },
]);
