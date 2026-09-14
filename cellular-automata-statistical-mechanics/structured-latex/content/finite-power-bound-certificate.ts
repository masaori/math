import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_power_bound_definition_certificate",
    kind: "definition",
    title: { text: "正整数値有限表の交差冪上界証明書" },
    labels: ["def_finite_power_bound_certificate"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`K,p,q\in\mathbb{N}_{>0}`),
        " と正整数値有限表 ",
        math(String.raw`z_K:[1,K]_{\mathbb{N}}\to\mathbb{N}_{>0}`),
        " に対し、",
      ]),
      displayMath(String.raw`\mathsf{PowUpper}_{\le K}(z_K;p,q)
\quad:\Longleftrightarrow\quad
\forall n\in[1,K]_{\mathbb{N}},\quad z_K(n)^q\le n^p`),
      paragraph([
        "と定める。指数の候補は正整数の順序対 ",
        math(String.raw`(p,q)`),
        " として保持し、商 ",
        math(String.raw`p/q`),
        "、根、対数、極限は定義しない。証明書の両辺は自然数の有限回の乗法だけで得られる。",
      ]),
    ],
  },
  {
    id: "finite_power_bound_claim_certificate_decidable",
    kind: "claim",
    title: { text: "交差冪上界証明書は自然数の有限比較で決定できる" },
    labels: ["claim_finite_power_bound_certificate_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_finite_power_bound_certificate"),
        " の入力が与えられたとき、",
        math(String.raw`\mathsf{PowUpper}_{\le K}(z_K;p,q)`),
        " の真偽は有限手続きで決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "候補添字の集合 ",
        math(String.raw`[1,K]_{\mathbb{N}}`),
        " は有限である。各 ",
        math(String.raw`n\in[1,K]_{\mathbb{N}}`),
        " について、自然数冪 ",
        math(String.raw`z_K(n)^q`),
        " と ",
        math(String.raw`n^p`),
        " を有限乗算で求め、自然数の順序比較を一回行う。全ての有限個の比較が真であることと ",
        ref("def_finite_power_bound_certificate"),
        " の条件は同値なので、主張を得る。",
      ]),
    ],
  },
  {
    id: "finite_power_bound_definition_cutoff_extensions",
    kind: "definition",
    title: { text: "有限表が区別できない交差冪上界の二つの後続列" },
    labels: ["def_finite_power_bound_cutoff_extensions"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`K,p,q\in\mathbb{N}_{>0}`),
        " に対し、正整数列 ",
        math(String.raw`a_K,b_{K,p}:\mathbb{N}_{>0}\to\mathbb{N}_{>0}`),
        " を",
      ]),
      displayMath(String.raw`a_K(n):=1,\qquad
b_{K,p}(n):=
\begin{cases}
  (K+1)^p+1 & (n=K+1),\\
  1 & (n\ne K+1)
\end{cases}`),
      paragraph([
        "と定める。どちらも正整数値の可算な列であり、有限打ち切り ",
        math(String.raw`K`),
        " より後の値を一つだけ変える。",
      ]),
    ],
  },
  {
    id: "finite_power_bound_claim_cutoff_does_not_determine_next_bound",
    kind: "claim",
    title: { text: "有限交差冪上界証明書は次の段階の上界を決めない" },
    labels: ["claim_finite_power_bound_cutoff_not_global"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_finite_power_bound_cutoff_extensions"),
        " の二列は ",
        math(String.raw`[1,K]_{\mathbb{N}}`),
        " 上で一致し、どちらの制限も ",
        math(String.raw`\mathsf{PowUpper}_{\le K}(-;p,q)`),
        " を満たす。一方、段階 ",
        math(String.raw`K+1`),
        " では",
      ]),
      displayMath(String.raw`a_K(K+1)^q\le(K+1)^p,
\qquad b_{K,p}(K+1)^q>(K+1)^p.`),
      paragraph([
        "従って、どれほど大きい有限打ち切りの証明書も、同じ正整数順序対 ",
        math(String.raw`(p,q)`),
        " による全後続段階の交差冪上界を含意しない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_finite_power_bound_cutoff_extensions"),
        " により、任意の ",
        math(String.raw`n\in[1,K]_{\mathbb{N}}`),
        " で ",
        math(String.raw`a_K(n)=b_{K,p}(n)=1`),
        " である。正整数 ",
        math(String.raw`n,p,q`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
a_K(n)^q
&=1
  \quad(\because\ a_K(n)=1)\\
&\le n^p
  \quad(\because\ n\ge1),\\
b_{K,p}(n)^q
&=1
  \quad(\because\ b_{K,p}(n)=1)\\
&\le n^p
  \quad(\because\ n\ge1).
\end{aligned}`),
      paragraph([
        ref("def_finite_power_bound_certificate"),
        " により、両方の制限が証明書を持つ。次の段階では、",
      ]),
      displayMath(String.raw`\begin{aligned}
a_K(K+1)^q
&=1
  \quad(\because\ \blkref{def_finite_power_bound_cutoff_extensions})\\
&\le(K+1)^p
  \quad(\because\ K+1\ge1),\\
b_{K,p}(K+1)^q
&=\left((K+1)^p+1\right)^q
  \quad(\because\ \blkref{def_finite_power_bound_cutoff_extensions})\\
&\ge(K+1)^p+1
  \quad(\because\ q\ge1\text{ と正整数冪の単調性})\\
&>(K+1)^p
  \quad(\because\ \text{自然数の後者は元より大きい}).
\end{aligned}`),
      paragraph(["従って主張を得る。"]),
    ],
  },
  {
    id: "finite_power_bound_remark_scaling_boundary",
    kind: "remark",
    title: { text: "有限べき比較とスケーリング指数の境界" },
    labels: ["remark_finite_power_bound_scaling_boundary"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("claim_finite_power_bound_certificate_decidable"),
        " は、有限サイズの正整数値データに対する有理べき型の上界候補を、商・根・対数なしで検査する有限の足跡を与える。しかし ",
        ref("claim_finite_power_bound_cutoff_not_global"),
        " により、有限の足跡だけでは全段階のべき上界を決められない。本節は漸近的な指数、スケーリング極限、実数値の臨界指数を定義せず、それらの存在も主張しない。",
      ]),
    ],
  },
]);
