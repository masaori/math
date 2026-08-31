/**
 * 章「自己写像の反復と軌道の最終周期性」: 第二の探索列の最初の章。
 * 有限集合上の自己写像 F: X → X（前章までの定義）を自然数回反復し、
 * 有限集合上の写像であることだけから内在的に定まる構造を抽出する。
 *
 * - 反復 F^n と軌道 O(y) の定義（時刻・物理的意味を入れない）
 * - 軌道の衝突: 各元 y について 0 ≤ i < j ≤ |X| で F^i y = F^j y となる組がある（鳩の巣）
 * - 最終周期性: 衝突から、ある p ≥ 1 と i について全ての n ≥ i で F^{n+p} y = F^n y
 * - 有限決定可能性: 衝突する組は高々 |X|+1 個の元の等号検査で見つかる
 *
 * 使う ℕ の構造は大小比較・後者・加法・等号だけである。無限集合・極限集合・
 * 位相は扱わない（remark に明記）。ℝ/ℂ は現れない。
 * 文書順はこの配列の並びが正本である。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_self_map_iteration_definition_finite_self_map",
    kind: "definition",
    title: { text: "有限集合上の自己写像" },
    labels: ["def_finite_self_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`X`), " と写像 ", math(String.raw`F:X\to X`),
        " の組を有限集合上の自己写像と呼ぶ。", math(String.raw`|X|\in\mathbb N`),
        " は ", ref("def_cardinality_notation"), " の記法で表す。",
      ]),
    ],
  },

  {
    id: "global_map_iteration_claim_binary_ca_specialization",
    kind: "claim",
    title: { text: "有限舞台上の 2 値セルオートマトンは有限自己写像を定める" },
    labels: ["claim_finite_binary_ca_specializes_to_finite_self_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台上の 2 値セルオートマトン（", ref("def_finite_ca"), "）に対し、",
        math(String.raw`X:=A^V`), " と置く。その大域写像（", ref("def_global_map"), "）は ",
        math(String.raw`F:X\to X`), " であり、", ref("def_finite_self_map"),
        " の有限自己写像を定める。さらに ", math(String.raw`|X|=2^{|V|}`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A`), " と ", math(String.raw`V`), " は有限集合（",
        ref("def_state_set"), "、", ref("def_finite_stage"), "）なので、写像集合 ",
        math(String.raw`X=A^V`), " は有限集合である。大域写像の始域と終域はともに ",
        math(String.raw`A^V=X`), " である。元数は",
      ]),
      displayMath(String.raw`\begin{aligned}
|X|
&=|A^V|\qquad(\because\ X=A^V)\\
&=|A|^{|V|}\qquad(\because\ \text{有限集合間の写像の個数})\\
&=2^{|V|}\qquad(\because\ |A|=2.\ \blkref{def_state_set})
\end{aligned}`),
    ],
  },

  {
    id: "finite_self_map_iteration_definition_iterate",
    kind: "definition",
    title: { text: "自己写像の反復" },
    labels: ["def_finite_self_map_iterate"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合上の自己写像 ", math(String.raw`F:X\to X`), "（",
        ref("def_finite_self_map"), "）に対し、各 ",
        math(String.raw`n\in\mathbb{N}`),
        " について写像 ",
        math(String.raw`F^{n}:X\to X`),
        " を ",
        math(String.raw`n`),
        " についての再帰で",
      ]),
      displayMath(
        String.raw`F^{0}\,y:=y,\qquad F^{n+1}\,y:=F\,(F^{n}\,y)\qquad(y\in X,\ n\in\mathbb{N})`,
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
    id: "finite_self_map_iteration_definition_orbit",
    kind: "definition",
    title: { text: "元の軌道" },
    labels: ["def_orbit"],
    habitat: "finite",
    statement: [
      paragraph([
        "元 ",
        math(String.raw`y\in X`),
        " に対し、集合",
      ]),
      displayMath(String.raw`O(y):=\{\,F^{n}\,y\ :\ n\in\mathbb{N}\,\}\subseteq X`),
      paragraph([
        "を ",
        math(String.raw`y`),
        " の軌道と呼ぶ（",
        math(String.raw`F^{n}`),
        " は ",
        ref("def_finite_self_map_iterate"),
        "）。",
      ]),
    ],
  },

  {
    id: "finite_self_map_iteration_claim_orbit_finite",
    kind: "claim",
    title: { text: "有限自己写像の軌道は有限集合である" },
    labels: ["claim_finite_self_map_orbit_finite"],
    habitat: "finite",
    statement: [
      paragraph([
        "各 ", math(String.raw`y\in X`), " について、軌道 ",
        math(String.raw`O(y)`), " は有限集合である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_orbit"), " より ", math(String.raw`O(y)\subseteq X`),
        " であり、", ref("def_finite_self_map"), " より ", math(String.raw`X`),
        " は有限集合である。有限集合の部分集合は有限集合なので、",
        math(String.raw`O(y)`), " は有限集合である。",
      ]),
    ],
  },

  {
    id: "finite_self_map_iteration_claim_orbit_collision",
    kind: "claim",
    title: { text: "軌道は高々 |X| 回の反復のうちに衝突する" },
    labels: ["claim_orbit_collision"],
    habitat: "N",
    statement: [
      paragraph([
        "各元 ",
        math(String.raw`y\in X`),
        " について、",
        math(String.raw`0\le i<j\le |X|`),
        " を満たす ",
        math(String.raw`i,j\in\mathbb{N}`),
        " で ",
        math(String.raw`F^{i}\,y=F^{j}\,y`),
        " となるものが存在する。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`M:=|X|\in\mathbb{N}`),
        " と置く。写像 ",
        math(String.raw`\iota_y:\{0,1,\dots,M\}\to X`),
        " を ",
        math(String.raw`\iota_y(n):=F^{n}\,y`),
        " で定める（",
        ref("def_finite_self_map_iterate"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
|\{0,1,\dots,M\}|
&=M+1\qquad(\because\ 0 \text{ から } M \text{ までの自然数は } M+1 \text{ 個})\\
&>M\qquad(\because\ \mathbb{N} \text{ の大小比較})\\
&=|X|\qquad(\because\ M=|X|)
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
        math(String.raw`0\le i<j\le M=|X|`),
        " が示された。",
      ]),
    ],
  },

  {
    id: "finite_self_map_iteration_claim_shift_invariance",
    kind: "claim",
    title: { text: "衝突は反復で保たれる" },
    labels: ["claim_collision_shift"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`y\in X`),
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
&=F\,(F^{i+k}\,y)\qquad(\because\ \blkref{def_finite_self_map_iterate})\\
&=F\,(F^{j+k}\,y)\qquad(\because\ \text{帰納法の仮定})\\
&=F^{(j+k)+1}\,y\qquad(\because\ \blkref{def_finite_self_map_iterate})\\
&=F^{j+(k+1)}\,y\qquad(\because\ \mathbb{N} \text{ の加法の結合則})
\end{aligned}`),
    ],
  },

  {
    id: "finite_self_map_iteration_claim_repeating_tail",
    kind: "claim",
    title: { text: "軌道は最終的に周期的である" },
    labels: ["claim_finite_self_map_repeating_tail"],
    habitat: "N",
    statement: [
      paragraph([
        "各元 ",
        math(String.raw`y\in X`),
        " について、",
        math(String.raw`i\in\mathbb{N}`),
        " と ",
        math(String.raw`p\in\mathbb{N}`),
        " で、",
        math(String.raw`p\ge 1`),
        "、",
        math(String.raw`i+p\le |X|`),
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
        math(String.raw`0\le i<j\le |X|`),
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
        math(String.raw`i+p=j\le |X|`),
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
    id: "finite_self_map_iteration_claim_collision_finite_decidability",
    kind: "claim",
    title: { text: "衝突する組は有限個の等号検査で見つかる" },
    labels: ["claim_collision_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "各元 ",
        math(String.raw`y\in X`),
        " について、",
        ref("claim_orbit_collision"),
        " の組 ",
        math(String.raw`(i,j)`),
        " は、元 ",
        math(String.raw`F^{0}y,F^{1}y,\dots,F^{|X|}y`),
        " の間の等号検査高々 ",
        math(String.raw`\tfrac{1}{2}\,|X|\,(|X|+1)`),
        " 回で見つかる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`M:=|X|`),
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
&=\tfrac{1}{2}\,|X|\,(|X|+1)\qquad(\because\ M \text{ の定義})
\end{aligned}`),
      paragraph([
        "以上の走査で使う対象は有限集合 ", math(String.raw`X`),
        " の元と自然数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "finite_self_map_iteration_remark_not_claimed",
    kind: "remark",
    title: { text: "この章で主張しないこと" },
    labels: ["remark_iteration_not_claimed"],
    habitat: "finite",
    statement: [
      paragraph([
        "この章の一般論は有限集合 ", math(String.raw`X`), " と、その上の写像 ",
        math(String.raw`F`),
        " の反復についてのものである。無限集合上の自己写像、その上の位相、極限集合、",
        "周期点の個数の母関数（形式的冪級数）は、この章では定義も主張もしない。",
        "また、",
        ref("claim_finite_self_map_repeating_tail"),
        " の ",
        math(String.raw`(i,p)`),
        " は存在だけを述べており、最小の前周期・最小の周期の定義と一意性は次の層で扱う。",
      ]),
    ],
  },
]);
