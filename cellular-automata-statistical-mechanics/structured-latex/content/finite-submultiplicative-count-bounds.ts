import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_submultiplicative_count_definition_certificate",
    kind: "definition",
    title: { text: "正整数値有限表の劣乗法証明書" },
    labels: ["def_finite_submultiplicative_count_certificate"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`K\in\mathbb{N}_{>0}`),
        " と、正整数値の有限表 ",
        math(String.raw`z_K:[1,K]_{\mathbb{N}}\to\mathbb{N}_{>0}`),
        " に対し、",
      ]),
      displayMath(String.raw`\mathsf{SubMult}_{\le K}(z_K)
\quad:\Longleftrightarrow\quad
\forall m,n\in[1,K]_{\mathbb{N}},\quad
m+n\le K\Longrightarrow z_K(m+n)\le z_K(m)z_K(n)`),
      paragraph([
        "と定める。加法、乗法、順序比較は自然数の演算である。この定義は有限表の内部にある不等式だけを述べ、",
        math(String.raw`K`),
        " より後の値、対数、除算、極限値、完備化、実数体を使わない。",
      ]),
    ],
  },
  {
    id: "finite_submultiplicative_count_claim_certificate_decidable",
    kind: "claim",
    title: { text: "有限劣乗法証明書は自然数の有限比較で決定できる" },
    labels: ["claim_finite_submultiplicative_count_certificate_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_finite_submultiplicative_count_certificate"),
        " の入力 ",
        math(String.raw`K`),
        " と有限表 ",
        math(String.raw`z_K`),
        " が与えられたとき、",
        math(String.raw`\mathsf{SubMult}_{\le K}(z_K)`),
        " の真偽は有限手続きで決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "候補対の集合 ",
        math(String.raw`P_K:=\{(m,n)\in[1,K]_{\mathbb{N}}^{2}:m+n\le K\}`),
        " は有限である。各 ",
        math(String.raw`(m,n)\in P_K`),
        " について、三つの表値 ",
        math(String.raw`z_K(m),z_K(n),z_K(m+n)\in\mathbb{N}_{>0}`),
        " を読み、自然数の乗法と順序比較により ",
        math(String.raw`z_K(m+n)\le z_K(m)z_K(n)`),
        " を決定する。全ての有限個の比較が真であることと ",
        ref("def_finite_submultiplicative_count_certificate"),
        " の条件は同値なので、主張を得る。",
      ]),
    ],
  },
  {
    id: "finite_submultiplicative_count_definition_density_comparison",
    kind: "definition",
    title: { text: "対数と除算を使わない有限段階密度比較" },
    labels: ["def_finite_count_density_comparison"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`m,n,a,b\in\mathbb{N}_{>0}`),
        " に対し、正整数値 ",
        math(String.raw`a`),
        " を段階 ",
        math(String.raw`m`),
        " で、正整数値 ",
        math(String.raw`b`),
        " を段階 ",
        math(String.raw`n`),
        " で得たときの有限段階密度比較を",
      ]),
      displayMath(String.raw`(m,a)\preccurlyeq_{\mathrm{dens}}(n,b)
\quad:\Longleftrightarrow\quad a^n\le b^m`),
      paragraph([
        "と定める。両辺は正整数であり、有限回の乗法と自然数の順序比較だけで決定できる。",
        math(String.raw`\log(a)/m`),
        " と ",
        math(String.raw`\log(b)/n`),
        " は定義していない。",
      ]),
    ],
  },
  {
    id: "finite_submultiplicative_count_claim_multiple_index_bound",
    kind: "claim",
    title: { text: "有限劣乗法証明書が与える倍数段階の密度上界" },
    labels: ["claim_finite_submultiplicative_count_multiple_index_density_bound"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_finite_submultiplicative_count_certificate"),
        " を満たす有限表 ",
        math(String.raw`z_K:[1,K]_{\mathbb{N}}\to\mathbb{N}_{>0}`),
        " と ",
        math(String.raw`m,q\in\mathbb{N}_{>0}`),
        " が ",
        math(String.raw`qm\le K`),
        " を満たすなら、",
      ]),
      displayMath(String.raw`z_K(qm)\le z_K(m)^q`),
      paragraph(["であり、従って"]),
      displayMath(String.raw`(qm,z_K(qm))\preccurlyeq_{\mathrm{dens}}(m,z_K(m)).`),
      paragraph([
        "これは一つの有限表の内部にある不等式であり、段階を無限へ送る操作を含まない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`q`),
        " に関する有限帰納法で第一の不等式を示す。",
        math(String.raw`q=1`),
        " では ",
        math(String.raw`z_K(m)=z_K(m)^1`),
        " である。正整数 ",
        math(String.raw`q`),
        " で ",
        math(String.raw`z_K(qm)\le z_K(m)^q`),
        " が成り立ち、さらに ",
        math(String.raw`(q+1)m\le K`),
        " とする。",
        ref("def_finite_submultiplicative_count_certificate"),
        " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
z_K((q+1)m)
&=z_K(qm+m)
  \quad(\because\ (q+1)m=qm+m)\\
&\le z_K(qm)z_K(m)
  \quad(\because\ \blkref{def_finite_submultiplicative_count_certificate})\\
&\le z_K(m)^qz_K(m)
  \quad(\because\ \text{帰納法の仮定と正整数の乗法の単調性})\\
&=z_K(m)^{q+1}
  \quad(\because\ \text{正整数冪の定義}).
\end{aligned}`),
      paragraph([
        "従って全ての ",
        math(String.raw`q\in\mathbb{N}_{>0}`),
        " について第一の不等式が成り立つ。両辺を正整数 ",
        math(String.raw`m`),
        " 乗すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
z_K(qm)^m
&\le\left(z_K(m)^q\right)^m
  \quad(\because\ \text{正整数冪の単調性})\\
&=z_K(m)^{qm}
  \quad(\because\ \text{冪の冪の法則}).
\end{aligned}`),
      paragraph([
        ref("def_finite_count_density_comparison"),
        " により第二の主張を得る。",
      ]),
    ],
  },
  {
    id: "finite_submultiplicative_count_definition_cutoff_extensions",
    kind: "definition",
    title: { text: "有限表が区別できない二つの後続列" },
    labels: ["def_finite_submultiplicative_count_cutoff_extensions"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`K\in\mathbb{N}_{>0}`),
        " に対し、二つの正整数列 ",
        math(String.raw`u_K,v_K:\mathbb{N}_{>0}\to\mathbb{N}_{>0}`),
        " を",
      ]),
      displayMath(String.raw`u_K(n):=1,\qquad
v_K(n):=
\begin{cases}
  2 & (n=K+1),\\
  1 & (n\ne K+1)
\end{cases}
\qquad(n\in\mathbb{N}_{>0})`),
      paragraph([
        "と定める。いずれも各段階で一つの正整数を与える可算な列であり、対数、除算、極限値は定義しない。",
      ]),
    ],
  },
  {
    id: "finite_submultiplicative_count_claim_cutoff_does_not_determine_next_inequality",
    kind: "claim",
    title: { text: "有限劣乗法証明書は次の段階の不等式を決めない" },
    labels: ["claim_finite_submultiplicative_count_cutoff_not_global"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_finite_submultiplicative_count_cutoff_extensions"),
        " の二列は ",
        math(String.raw`[1,K]_{\mathbb{N}}`),
        " 上で一致し、どちらの制限も ",
        math(String.raw`\mathsf{SubMult}_{\le K}`),
        " を満たす。一方、",
      ]),
      displayMath(String.raw`u_K(K+1)\le u_K(K)u_K(1),\qquad
v_K(K+1)>v_K(K)v_K(1).`),
      paragraph([
        "従って、有限劣乗法証明書は全段階の劣乗法性を含意しない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_finite_submultiplicative_count_cutoff_extensions"),
        " により、任意の ",
        math(String.raw`n\le K`),
        " で ",
        math(String.raw`u_K(n)=v_K(n)=1`),
        " である。従って、",
      ]),
      displayMath(String.raw`\begin{aligned}
u_K(m+n)
&=1
  \quad(\because\ m+n\le K)\\
&=1\cdot1
  \quad(\because\ \text{自然数の単位元})\\
&=u_K(m)u_K(n)
  \quad(\because\ m,n\le K),
\end{aligned}`),
      paragraph([
        "かつ同じ計算が ",
        math(String.raw`v_K`),
        " の制限にも成り立つので、",
        ref("def_finite_submultiplicative_count_certificate"),
        " により両方の制限が証明書を持つ。次の段階では、",
      ]),
      displayMath(String.raw`\begin{aligned}
u_K(K+1)
&=1
  \quad(\because\ \blkref{def_finite_submultiplicative_count_cutoff_extensions})\\
&=u_K(K)u_K(1)
  \quad(\because\ u_K(K)=u_K(1)=1),\\
v_K(K+1)
&=2
  \quad(\because\ \blkref{def_finite_submultiplicative_count_cutoff_extensions})\\
&>1
  \quad(\because\ 2>1)\\
&=v_K(K)v_K(1)
  \quad(\because\ v_K(K)=v_K(1)=1).
\end{aligned}`),
      paragraph(["従って主張を得る。"]),
    ],
  },
  {
    id: "finite_submultiplicative_count_remark_limit_boundary",
    kind: "remark",
    title: { text: "有限不等式列と熱力学極限の存在の境界" },
    labels: ["remark_finite_submultiplicative_count_limit_boundary"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("claim_finite_submultiplicative_count_certificate_decidable"),
        " と ",
        ref("claim_finite_submultiplicative_count_multiple_index_density_bound"),
        " が与えるのは、指定した有限打ち切りまでの決定可能な不等式だけである。",
        ref("claim_finite_submultiplicative_count_cutoff_not_global"),
        " により、どれほど大きい有限打ち切りでも、その表だけから全段階の劣乗法性は得られない。全段階の仮定を別に証明した後、全てのそのような列へ下限を極限値として割り当てる一般主張には、値域、収束概念、下限が属する完備な住処を別に定義する必要がある。本節はそれらを定義せず、熱力学極限の存在を主張しない。",
      ]),
    ],
  },
]);
