import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_word_complexity_definition_two_symbol_words",
    kind: "definition",
    title: { text: "有限二元語の集合" },
    labels: ["def_finite_two_symbol_word_set"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`A:=\{0,1\}`),
        " を二元集合とする。各 ",
        math(String.raw`n\in\mathbb N_{>0}`),
        " に対し、長さ ",
        math(String.raw`n`),
        " の有限二元語の集合を",
      ]),
      displayMath(String.raw`\mathcal W(n):=A^{[0,n-1]_{\mathbb{N}}}`),
      paragraph([
        "と定める。各元は有限自然数区間から ",
        math(String.raw`A`),
        " への写像である。ここでは有限集合だけを使う。",
      ]),
    ],
  },
  {
    id: "finite_word_complexity_claim_two_symbol_word_count",
    kind: "claim",
    title: { text: "有限二元語の個数" },
    labels: ["claim_finite_two_symbol_word_set_cardinality"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_finite_two_symbol_word_set"),
        " の有限語集合について、",
      ]),
      displayMath(String.raw`\lvert\mathcal W(n)\rvert=2^n\in\mathbb N_{>0}.`),
    ],
    proof: [
      paragraph([
        "定義域 ",
        math(String.raw`[0,n-1]_{\mathbb{N}}`),
        " は ",
        math(String.raw`n`),
        " 個の元を持ち、各元の像は二元集合 ",
        math(String.raw`A`),
        " から独立に一つ選ばれる。従って写像の個数は二を ",
        math(String.raw`n`),
        " 回掛けた自然数 ",
        math(String.raw`2^n`),
        " である。",
      ]),
    ],
  },
  {
    id: "finite_word_complexity_definition_forbidden_run_language",
    kind: "definition",
    title: { text: "指定長の連続した一を禁じる有限語族" },
    labels: ["def_forbidden_one_run_word_family"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`K,n\in\mathbb N_{>0}`),
        " とする。",
        ref("def_finite_two_symbol_word_set"),
        " の部分集合を",
      ]),
      displayMath(String.raw`\mathcal L_K(n):=
\left\{
  w\in\mathcal W(n)
  \ \middle|\ 
  \forall i\in[0,n-1]_{\mathbb{N}},\
  \ i+K<n\Longrightarrow
  \exists j\in[0,K]_{\mathbb{N}},\ w(i+j)=0
\right\}`),
      paragraph([
        "と定める。これは長さ ",
        math(String.raw`K+1`),
        " の連続した位置が全て値一になることを禁じる有限語族である。",
      ]),
    ],
  },
  {
    id: "finite_word_complexity_claim_agreement_below_forbidden_length",
    kind: "claim",
    title: { text: "禁制長より短い有限語は全て許される" },
    labels: ["claim_forbidden_one_run_words_full_below_cutoff"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`K,n\in\mathbb N_{>0}`),
        " と ",
        math(String.raw`n\le K`),
        " に対し、",
      ]),
      displayMath(String.raw`\mathcal L_K(n)=\mathcal W(n),
\qquad \lvert\mathcal L_K(n)\rvert=2^n.`),
    ],
    proof: [
      paragraph([
        ref("def_forbidden_one_run_word_family"),
        " の条件に現れる任意の ",
        math(String.raw`i\in[0,n-1]_{\mathbb{N}}`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
i+K
&\ge K
  \quad(\because\ i\ge0)\\
&\ge n
  \quad(\because\ n\le K).
\end{aligned}`),
      paragraph([
        "従って ",
        math(String.raw`i+K<n`),
        " を満たす ",
        math(String.raw`i`),
        " はなく、定義中の条件は空な全称量化として全ての ",
        math(String.raw`w\in\mathcal W(n)`),
        " について成り立つ。ゆえに集合の等号を得る。個数の等号は ",
        ref("claim_finite_two_symbol_word_set_cardinality"),
        " から従う。",
      ]),
    ],
  },
  {
    id: "finite_word_complexity_claim_next_length_divergence",
    kind: "claim",
    title: { text: "同じ有限語個数表を持つ二語族は次の長さで分かれる" },
    labels: ["claim_finite_word_counts_do_not_determine_next_length"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`K\in\mathbb N_{>0}`),
        " とする。全有限二元語族 ",
        math(String.raw`(\mathcal W(n))_{n\in\mathbb N_{>0}}`),
        " と ",
        ref("def_forbidden_one_run_word_family"),
        " の語族は、全ての ",
        math(String.raw`n\in[1,K]_{\mathbb{N}}`),
        " で個数が一致する一方、次の長さでは",
      ]),
      displayMath(String.raw`\lvert\mathcal W(K+1)\rvert=2^{K+1},
\qquad
\lvert\mathcal L_K(K+1)\rvert=2^{K+1}-1`),
      paragraph([
        "となる。従って、どれほど大きい有限打ち切りまでの有限語個数表も、次の長さの個数を一意に決めない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_forbidden_one_run_words_full_below_cutoff"),
        " により、長さ ",
        math(String.raw`K`),
        " までの一致を得る。長さ ",
        math(String.raw`K+1`),
        " では ",
        math(String.raw`i+K<K+1`),
        " を満たす添字は ",
        math(String.raw`i=0`),
        " だけである。従って ",
        ref("def_forbidden_one_run_word_family"),
        " の条件を満たさない語は、全ての ",
        math(String.raw`j\in[0,K]_{\mathbb{N}}`),
        " で値一を取る唯一の語だけである。ゆえに、",
      ]),
      displayMath(String.raw`\begin{aligned}
\lvert\mathcal L_K(K+1)\rvert
&=\lvert\mathcal W(K+1)\rvert-1
  \quad(\because\ \text{除かれる語は全一語だけ})\\
&=2^{K+1}-1
  \quad(\because\ \blkref{claim_finite_two_symbol_word_set_cardinality}).
\end{aligned}`),
      paragraph(["従って主張を得る。"]),
    ],
  },
  {
    id: "finite_word_complexity_remark_entropy_boundary",
    kind: "remark",
    title: { text: "有限語個数と位相的エントロピーの境界" },
    labels: ["remark_finite_word_count_entropy_boundary"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("claim_finite_word_counts_do_not_determine_next_length"),
        " が与えるのは、有限語個数が各長さで自然数として有限決定できても、その有限打ち切りから後続の個数列は決まらないという境界である。本節は、無限添字上の全関数集合、実対数、極限、位相的エントロピーを定義せず、それらの値も存在も主張しない。",
      ]),
    ],
  },
]);
