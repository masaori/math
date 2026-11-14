import { defineBlocks, displayMath, list, math, paragraph, ref } from "../../schema.ts";

export default defineBlocks([
  {
    id: "isomorphism_heading",
    kind: "heading",
    level: 1,
    title: { text: "同型の証明" },
    labels: [],
  },
  {
    id: "isomorphism_definition_count_of_subset_elements_below_index",
    kind: "definition",
    title: { text: "部分集合のうち番号より小さい元を数える個数" },
    labels: ["def_count_of_subset_elements_below_index"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`T\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について、整数 ",
        math(String.raw`N_i(T)\in\mathbb{Z}_{\ge 0}`),
        " を、",
        math(String.raw`i`),
        " についての帰納法で次のように定める。",
      ]),
      list([
        [
          math(String.raw`i=1`),
          " のとき、",
          math(String.raw`N_1(T):=0`),
          " とする。",
        ],
        [
          math(String.raw`i\in\{2,\dots,M\}`),
          " のとき、",
          math(String.raw`i-1\in T`),
          " なら ",
          math(String.raw`N_i(T):=N_{i-1}(T)+1`),
          "、",
          math(String.raw`i-1\notin T`),
          " なら ",
          math(String.raw`N_i(T):=N_{i-1}(T)`),
          " とする。",
        ],
      ]),
      paragraph([
        "この式が各 ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " に ",
        math(String.raw`\mathbb{Z}_{\ge 0}`),
        " の元を一つずつ定めることを、",
        math(String.raw`i`),
        " についての帰納法で確かめる。",
        math(String.raw`i=1`),
        " のとき、",
        math(String.raw`0\in\mathbb{Z}_{\ge 0}`),
        " である。",
        math(String.raw`i\in\{2,\dots,M\}`),
        " とし、",
        math(String.raw`N_{i-1}(T)\in\mathbb{Z}_{\ge 0}`),
        " が一つに定まっているとする。",
        math(String.raw`i-1\in\{1,\dots,M\}`),
        " なので、",
        math(String.raw`\mathcal{P}_M`),
        " の定義（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）により ",
        math(String.raw`i-1\in T`),
        " か ",
        math(String.raw`i-1\notin T`),
        " のどちらか一方だけが成り立ち、",
        math(String.raw`N_i(T)`),
        " は一つに決まる。",
        math(String.raw`N_{i-1}(T)+1`),
        " と ",
        math(String.raw`N_{i-1}(T)`),
        " はどちらも ",
        math(String.raw`\mathbb{Z}_{\ge 0}`),
        " の元である（",
        math(String.raw`+`),
        " は ",
        math(String.raw`\mathbb{Z}`),
        " の加法）。",
      ]),
      paragraph([
        math(String.raw`N_i(T)`),
        " は、",
        math(String.raw`t=1,\dots,i-1`),
        " の順に ",
        math(String.raw`t\in T`),
        " であるたびに 1 を足した値である。記号 ",
        math(String.raw`N_i(T)`),
        " は ",
        math(String.raw`M`),
        " を書かないが、",
        math(String.raw`M`),
        " を固定して定める。",
        math(String.raw`N_i(T)`),
        " は生成作用素の行列の成分の符号に使う。",
      ]),
      paragraph([
        "この定義は、有限集合の元の個数と、",
        math(String.raw`T`),
        " の元を小さい順に並べる写像を使わない。",
        math(String.raw`N_i(T)`),
        " が集合 ",
        math(String.raw`\{t\in T : t<i\}`),
        " の元の個数に等しいことは、元の個数を定めないので主張しない。",
        math(String.raw`T`),
        " に一つの元を足したときの ",
        math(String.raw`N_i`),
        " の値は、後の主張で示す。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_sign_of_nonnegative_integer",
    kind: "definition",
    title: { text: "非負整数の偶奇による符号" },
    labels: ["def_sign_of_nonnegative_integer"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\varsigma(n)\in\mathbb{C}`),
        " を、",
        math(String.raw`n`),
        " についての帰納法で次のように定める。",
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        math(String.raw`1_{\mathbb{C}}`),
        " の加法の逆元（",
        math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})=0_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`\mathbb{C}`),
        " の元）である。",
      ]),
      list([
        [
          math(String.raw`n=0`),
          " のとき、",
          math(String.raw`\varsigma(0):=1_{\mathbb{C}}`),
          " とする。",
        ],
        [
          math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
          " のとき、",
          math(String.raw`\varsigma(n):=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)`),
          " とする。",
        ],
      ]),
      paragraph([
        "この式が各 ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元を一つずつ定めることを、",
        math(String.raw`n`),
        " についての帰納法で確かめる。",
        math(String.raw`n=0`),
        " のとき、",
        math(String.raw`1_{\mathbb{C}}\in\mathbb{C}`),
        " である。",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`n-1\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\varsigma(n-1)\in\mathbb{C}`),
        " が一つに定まっているとする。",
        math(String.raw`-1_{\mathbb{C}}\in\mathbb{C}`),
        " なので、",
        math(String.raw`\mathbb{C}`),
        " の乗法の値 ",
        math(String.raw`(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        math(String.raw`\varsigma(n)`),
        " は、生成作用素の行列の成分の符号 ",
        math(String.raw`(-1)^{N_i(T)}`),
        " を ",
        math(String.raw`\varsigma(N_i(T))`),
        "（",
        ref("def_count_of_subset_elements_below_index"),
        "）と書くために置く。",
        math(String.raw`\mathbb{C}`),
        " の元の冪の一般の定義と指数法則は使わないので置かない。",
        math(String.raw`\varsigma(n)`),
        " の値が ",
        math(String.raw`1_{\mathbb{C}}`),
        " か ",
        math(String.raw`-1_{\mathbb{C}}`),
        " であることと、",
        math(String.raw`\varsigma(n)\cdot_{\mathbb{C}}\varsigma(n)=1_{\mathbb{C}}`),
        " であることは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_creation_operator_matrix",
    kind: "definition",
    title: { text: "生成作用素の行列" },
    labels: ["def_creation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`\mathcal{P}_M`),
        " を ",
        math(String.raw`\{1,\dots,M\}`),
        " の部分集合全体の集合（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。",
        math(String.raw`\mathcal{P}_M`),
        " は有限集合である（",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）ので、",
        math(String.raw`\mathcal{P}_M`),
        " で添字づけた行列の集合 ",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）が定まる。",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について、",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元 ",
        math(String.raw`c_i`),
        " を、",
        math(String.raw`S,T\in\mathcal{P}_M`),
        " についての成分で次のように定め、生成作用素の行列と呼ぶ。",
      ]),
      displayMath(String.raw`(c_i)_{S,T}:=
\begin{cases}
  \varsigma(N_i(T)) & (i\notin T\ \text{かつ}\ S=T\cup\{i\}),\\
  0_{\mathbb{C}} & (\text{それ以外}).
\end{cases}`),
      paragraph([
        "右辺の ",
        math(String.raw`N_i(T)\in\mathbb{Z}_{\ge 0}`),
        " は部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "。",
        math(String.raw`i\in\{1,\dots,M\}`),
        " かつ ",
        math(String.raw`T\in\mathcal{P}_M`),
        " なので定まる）であり、",
        math(String.raw`\varsigma(N_i(T))\in\mathbb{C}`),
        " は非負整数の偶奇による符号（",
        ref("def_sign_of_nonnegative_integer"),
        "）である。",
        math(String.raw`T\cup\{i\}`),
        " は ",
        math(String.raw`T\subseteq\{1,\dots,M\}`),
        " と ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " から ",
        math(String.raw`\{1,\dots,M\}`),
        " の部分集合なので、",
        math(String.raw`\mathcal{P}_M`),
        " の元である。",
      ]),
      paragraph([
        "各 ",
        math(String.raw`(S,T)\in\mathcal{P}_M\times\mathcal{P}_M`),
        " について、条件「",
        math(String.raw`i\notin T`),
        " かつ ",
        math(String.raw`S=T\cup\{i\}`),
        "」は成り立つか成り立たないかのどちらか一方だけである（",
        math(String.raw`i\notin T`),
        " は ",
        ref("def_power_set_of_first_m_positive_integers"),
        " により真偽が一つに決まり、",
        math(String.raw`S=T\cup\{i\}`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        " の元の等しさとして真偽が一つに決まる）。どちらの場合も右辺は ",
        math(String.raw`\mathbb{C}`),
        " の元を一つ定める。したがって ",
        math(String.raw`c_i`),
        " は写像 ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M\to\mathbb{C}`),
        "、すなわち ",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        "記号 ",
        math(String.raw`c_i`),
        " は ",
        math(String.raw`M`),
        " を書かないが、",
        math(String.raw`M`),
        " を固定して定める。下付きの添字 ",
        math(String.raw`i`),
        " は行列を選ぶ添字であり、成分の添字 ",
        math(String.raw`(S,T)`),
        " とは別である。",
        math(String.raw`c_i`),
        " の成分が ",
        math(String.raw`0_{\mathbb{C}}`),
        " 以外の式で定まるのは、列の添字 ",
        math(String.raw`T`),
        " が ",
        math(String.raw`i`),
        " を含まないときの、行の添字 ",
        math(String.raw`T\cup\{i\}`),
        " の位置だけにある。",
        math(String.raw`T\cup\{i\}`),
        " は二つの集合の和集合であり、",
        math(String.raw`\mathcal{P}_M`),
        " の上の演算としては定めない。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_annihilation_operator_matrix",
    kind: "definition",
    title: { text: "消滅作用素の行列" },
    labels: ["def_annihilation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とする。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元 ",
        math(String.raw`c_i^{\mathsf T}`),
        " を、",
        math(String.raw`S,T\in\mathcal{P}_M`),
        " についての成分で次のように定め、消滅作用素の行列と呼ぶ。",
      ]),
      displayMath(String.raw`(c_i^{\mathsf T})_{S,T}:=(c_i)_{T,S}.`),
      paragraph([
        "各 ",
        math(String.raw`(S,T)\in\mathcal{P}_M\times\mathcal{P}_M`),
        " について ",
        math(String.raw`(T,S)\in\mathcal{P}_M\times\mathcal{P}_M`),
        " であり、",
        math(String.raw`c_i`),
        " は写像 ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M\to\mathbb{C}`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）ので、右辺 ",
        math(String.raw`(c_i)_{T,S}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の元を一つ定める。したがって ",
        math(String.raw`c_i^{\mathsf T}`),
        " は写像 ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M\to\mathbb{C}`),
        "、すなわち ",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        "記号 ",
        math(String.raw`c_i^{\mathsf T}`),
        " は一つの記号であり、",
        math(String.raw`c_i`),
        " ごとにこの式で直接定める。上付きの ",
        math(String.raw`\mathsf T`),
        " は成分の添字 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " とは別のものである。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の一般の元の転置は定義せず、転置の性質も使わない。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_count_below_index_after_adding_one_element",
    kind: "claim",
    title: { text: "部分集合に一つの元を足したときの、番号より小さい元を数える個数の値" },
    labels: ["claim_count_below_index_after_adding_one_element"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`T\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）、",
        math(String.raw`j\in\{1,\dots,M\}`),
        " で ",
        math(String.raw`j\notin T`),
        " とする。このとき ",
        math(String.raw`T\cup\{j\}\in\mathcal{P}_M`),
        " であり、すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について、部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "）は次を満たす（",
        math(String.raw`+`),
        " は ",
        math(String.raw`\mathbb{Z}`),
        " の加法）。",
      ]),
      displayMath(String.raw`N_i(T\cup\{j\})=
\begin{cases}
  N_i(T)+1 & (j<i),\\
  N_i(T) & (j\ge i).
\end{cases}`),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`T\subseteq\{1,\dots,M\}`),
        " と ",
        math(String.raw`j\in\{1,\dots,M\}`),
        " から ",
        math(String.raw`T\cup\{j\}\subseteq\{1,\dots,M\}`),
        " なので、",
        math(String.raw`T\cup\{j\}\in\mathcal{P}_M`),
        " であり、",
        math(String.raw`N_i(T\cup\{j\})`),
        " が定まる（",
        ref("def_count_of_subset_elements_below_index"),
        "）。和集合と ",
        math(String.raw`\{j\}`),
        " の定義により、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " で ",
        math(String.raw`t\neq j`),
        " なら ",
        math(String.raw`t\in T\cup\{j\}`),
        " と ",
        math(String.raw`t\in T`),
        " は同値であり（",
        math(String.raw`\star`),
        "）、",
        math(String.raw`j\in T\cup\{j\}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`T`),
        " と ",
        math(String.raw`j`),
        " を固定し、",
        math(String.raw`i`),
        " についての帰納法で示す。",
        math(String.raw`i=1`),
        " のとき。",
        math(String.raw`j\in\{1,\dots,M\}`),
        " なので ",
        math(String.raw`j\ge 1=i`),
        " であり、示す等式は ",
        math(String.raw`N_1(T\cup\{j\})=N_1(T)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_1(T\cup\{j\})
&=0
&&\left(\because\ N_1\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_1(T)
&&\left(\because\ N_1\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in\{2,\dots,M\}`),
        " とし、",
        math(String.raw`i-1`),
        " について主張が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`j`),
        " と ",
        math(String.raw`i-1`),
        " の大小で三つの場合に分ける。",
      ]),
      list([
        [
          math(String.raw`j<i-1`),
          " のとき。",
          math(String.raw`j<i`),
          " なので、示す等式は ",
          math(String.raw`N_i(T\cup\{j\})=N_i(T)+1`),
          " である。帰納法の仮定（",
          math(String.raw`j<i-1`),
          " の場合）から ",
          math(String.raw`N_{i-1}(T\cup\{j\})=N_{i-1}(T)+1`),
          " である。",
          math(String.raw`i-1\neq j`),
          " なので、（",
          math(String.raw`\star`),
          "）から ",
          math(String.raw`i-1\in T\cup\{j\}`),
          " と ",
          math(String.raw`i-1\in T`),
          " は同値である。",
          math(String.raw`i-1\in T`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})+1
&&\left(\because\ i-1\in T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\bigl(N_{i-1}(T)+1\bigr)+1
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)+1
&&\left(\because\ i-1\in T\ \text{なので}\ N_i(T)=N_{i-1}(T)+1\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i-1\notin T`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})
&&\left(\because\ i-1\notin T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_{i-1}(T)+1
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)+1
&&\left(\because\ i-1\notin T\ \text{なので}\ N_i(T)=N_{i-1}(T)\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`j=i-1`),
          " のとき。",
          math(String.raw`j<i`),
          " なので、示す等式は ",
          math(String.raw`N_i(T\cup\{j\})=N_i(T)+1`),
          " である。",
          math(String.raw`j\ge i-1`),
          " なので、帰納法の仮定（",
          math(String.raw`j\ge i-1`),
          " の場合）から ",
          math(String.raw`N_{i-1}(T\cup\{j\})=N_{i-1}(T)`),
          " である。",
          math(String.raw`i-1=j\in T\cup\{j\}`),
          " であり、",
          math(String.raw`i-1=j\notin T`),
          " である。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})+1
&&\left(\because\ i-1\in T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_{i-1}(T)+1
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)+1
&&\left(\because\ i-1\notin T\ \text{なので}\ N_i(T)=N_{i-1}(T)\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`j\ge i`),
          " のとき。示す等式は ",
          math(String.raw`N_i(T\cup\{j\})=N_i(T)`),
          " である。",
          math(String.raw`j\ge i>i-1`),
          " なので、帰納法の仮定（",
          math(String.raw`j\ge i-1`),
          " の場合）から ",
          math(String.raw`N_{i-1}(T\cup\{j\})=N_{i-1}(T)`),
          " である。",
          math(String.raw`i-1\neq j`),
          " なので、（",
          math(String.raw`\star`),
          "）から ",
          math(String.raw`i-1\in T\cup\{j\}`),
          " と ",
          math(String.raw`i-1\in T`),
          " は同値である。",
          math(String.raw`i-1\in T`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})+1
&&\left(\because\ i-1\in T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_{i-1}(T)+1
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)
&&\left(\because\ i-1\in T\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i-1\notin T`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T\cup\{j\})
&=N_{i-1}(T\cup\{j\})
&&\left(\because\ i-1\notin T\cup\{j\}\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=N_{i-1}(T)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=N_i(T)
&&\left(\because\ i-1\notin T\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        "三つの場合は ",
        math(String.raw`j<i-1`),
        "、",
        math(String.raw`j=i-1`),
        "、",
        math(String.raw`j>i-1`),
        "（整数なので ",
        math(String.raw`j\ge i`),
        " と同じ）を尽くすので、",
        math(String.raw`i`),
        " について主張が成り立つ。以上で、すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_entry_of_matrix_times_creation_operator_matrix",
    kind: "claim",
    title: { text: "右から生成作用素の行列を掛けた行列の成分" },
    labels: ["claim_entry_of_matrix_times_creation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`j\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_j\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とする。",
        math(String.raw`A\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、行列の積 ",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）の成分は次のとおりである。",
      ]),
      displayMath(String.raw`\bigl(A\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}=
\begin{cases}
  A_{S,U\cup\{j\}}\cdot_{\mathbb{C}}\varsigma(N_j(U)) & (j\notin U),\\
  0_{\mathbb{C}} & (j\in U).
\end{cases}`),
      paragraph([
        "右辺の ",
        math(String.raw`N_j(U)\in\mathbb{Z}_{\ge 0}`),
        " は部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "）、",
        math(String.raw`\varsigma(N_j(U))\in\mathbb{C}`),
        " は非負整数の偶奇による符号（",
        ref("def_sign_of_nonnegative_integer"),
        "）である。",
        math(String.raw`U\subseteq\{1,\dots,M\}`),
        " と ",
        math(String.raw`j\in\{1,\dots,M\}`),
        " から ",
        math(String.raw`U\cup\{j\}\in\mathcal{P}_M`),
        " なので、",
        math(String.raw`A_{S,U\cup\{j\}}\in\mathbb{C}`),
        " が定まる。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        "（有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        "、",
        math(String.raw`X:=\mathcal{P}_M`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
        math(String.raw`j\in U`),
        " か ",
        math(String.raw`j\notin U`),
        " かで二つの場合に分ける。",
      ]),
      list([
        [
          math(String.raw`j\in U`),
          " のとき。準備として、各 ",
          math(String.raw`T\in\mathcal{P}_M`),
          " について次の等式を示す。",
          math(String.raw`j\in U`),
          " なので、",
          math(String.raw`c_j`),
          " の定義の条件「",
          math(String.raw`j\notin U`),
          " かつ ",
          math(String.raw`T=U\cup\{j\}`),
          "」は成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
A_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_j)_{T,U}
&=A_{S,T}\cdot_{\mathbb{C}}(c_j)_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=A_{S,T}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\text{（二回）}\right)\\
&=(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}A_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_j)_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}
&&\left(\because\ \text{各}\ T\ \text{で準備の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}\right)
&&\left(\because\ \rho:=0_{\mathbb{C}}\text{、}\lambda_T:=1_{\mathbb{C}}\text{、}v_T:=1_{\mathbb{C}}\ \text{を当てる。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=0_{\mathbb{C}^{\mathrm{vec}}}
&&\left(\because\ \text{零のスカラー倍は零ベクトル。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`j\notin U`),
          " のとき。",
          math(String.raw`R:=U\cup\{j\}\in\mathcal{P}_M`),
          " と置く。",
          math(String.raw`j\notin U`),
          " なので、",
          math(String.raw`T\in\mathcal{P}_M`),
          " について ",
          math(String.raw`c_j`),
          " の定義の条件「",
          math(String.raw`j\notin U`),
          " かつ ",
          math(String.raw`T=U\cup\{j\}`),
          "」は ",
          math(String.raw`T=R`),
          " と同値である。準備として、各 ",
          math(String.raw`T\in\mathcal{P}_M`),
          " について ",
          math(String.raw`(c_j)_{T,U}=\delta_{R,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))`),
          " を示す。",
          math(String.raw`\delta_{R,T}\in\mathbb{C}`),
          " は ",
          math(String.raw`\mathcal{P}_M`),
          " の二元についてのクロネッカーのデルタ（",
          ref("def_kronecker_delta"),
          "）である。",
          math(String.raw`T=R`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
(c_j)_{T,U}
&=\varsigma(N_j(U))
&&\left(\because\ T=R\ \text{なので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ R=T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`T\neq R`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_j)_{T,U}
&=0_{\mathbb{C}}
&&\left(\because\ T\neq R\ \text{なので条件が成り立たず、}c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ R\neq T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        "さらに、",
        math(String.raw`T\in\mathcal{P}_M`),
        " について ",
        math(String.raw`r_T:=A_{S,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について、和の項のデルタを係数の位置へ移した次の等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
A_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_j)_{T,U}
&=A_{S,T}\cdot_{\mathbb{C}}(c_j)_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=A_{S,T}\cdot_{\mathbb{C}}\bigl(\delta_{R,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \text{上の準備の等式}\right)\\
&=(A_{S,T}\cdot_{\mathbb{C}}\delta_{R,T})\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(\delta_{R,T}\cdot_{\mathbb{C}}A_{S,T})\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}}\bigl(A_{S,T}\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}}r_T
&&\left(\because\ r_T\ \text{の置き方}\right)\\
&=\delta_{R,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}A_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_j)_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}\delta_{R,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_R
&&\left(\because\ \text{主張の}\ x\ \text{に}\ R\text{、和の変数に}\ T\text{、}v_T:=r_T\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=A_{S,R}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ r_T\ \text{の置き方で}\ T:=R\right)\\
&=A_{S,U\cup\{j\}}\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ R\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        "二つの場合は ",
        math(String.raw`j\in U`),
        " と ",
        math(String.raw`j\notin U`),
        " を尽くすので、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_creation_operator_matrices_anticommute",
    kind: "claim",
    title: { text: "生成作用素の行列どうしの反交換関係" },
    labels: ["claim_creation_operator_matrices_anticommute"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i,j\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i,c_j\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とする。",
        math(String.raw`i=j`),
        " の場合も含めて、",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の中で次が成り立つ（演算と零行列は ",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
      displayMath(String.raw`c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j
+_{\mathrm{Mat}_{\mathcal{P}_M}}
c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i
=0_{\mathrm{Mat}_{\mathcal{P}_M}}.`),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`k,l\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、条件 ",
        math(String.raw`\mathrm{C}_{k,l}(S,U)`),
        " を「",
        math(String.raw`k\notin U`),
        " かつ ",
        math(String.raw`l\notin U`),
        " かつ ",
        math(String.raw`k\neq l`),
        " かつ ",
        math(String.raw`S=(U\cup\{l\})\cup\{k\}`),
        "」と置く。各 ",
        math(String.raw`k,l,S,U`),
        " について、次の等式（",
        math(String.raw`\star`),
        "）を示す。",
      ]),
      displayMath(String.raw`\bigl(c_k\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l\bigr)_{S,U}=
\begin{cases}
  \varsigma\bigl(N_k(U\cup\{l\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_l(U)) & (\mathrm{C}_{k,l}(S,U)\ \text{が成り立つ}),\\
  0_{\mathbb{C}} & (\text{成り立たない}).
\end{cases}
\qquad(\star)`),
      list([
        [
          math(String.raw`l\in U`),
          " のとき。",
          math(String.raw`\mathrm{C}_{k,l}(S,U)`),
          " は成り立たず、右から生成作用素の行列を掛けた行列の成分の主張（",
          ref("claim_entry_of_matrix_times_creation_operator_matrix"),
          "）を ",
          math(String.raw`A:=c_k`),
          "、主張の ",
          math(String.raw`j`),
          " に ",
          math(String.raw`l`),
          " を当てると、",
          math(String.raw`(c_k\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l)_{S,U}=0_{\mathbb{C}}`),
          " である。",
        ],
        [
          math(String.raw`l\notin U`),
          " のとき。",
          math(String.raw`U\cup\{l\}\in\mathcal{P}_M`),
          " である。和集合の定義により、",
          math(String.raw`k\notin U\cup\{l\}`),
          " は「",
          math(String.raw`k\notin U`),
          " かつ ",
          math(String.raw`k\neq l`),
          "」と同値である。したがって、",
          math(String.raw`c_k`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）で列の添字を ",
          math(String.raw`U\cup\{l\}`),
          " としたときの条件「",
          math(String.raw`k\notin U\cup\{l\}`),
          " かつ ",
          math(String.raw`S=(U\cup\{l\})\cup\{k\}`),
          "」は、",
          math(String.raw`\mathrm{C}_{k,l}(S,U)`),
          " と同値である。",
          math(String.raw`\mathrm{C}_{k,l}(S,U)`),
          " が成り立つなら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_k\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l\bigr)_{S,U}
&=(c_k)_{S,U\cup\{l\}}\cdot_{\mathbb{C}}\varsigma(N_l(U))
&&\left(\because\ A:=c_k\text{、主張の}\ j\ \text{に}\ l\ \text{を当て、}l\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=\varsigma\bigl(N_k(U\cup\{l\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_l(U))
&&\left(\because\ \text{条件が成り立つので}\ c_k\ \text{の定義。}\blkref{def_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{C}_{k,l}(S,U)`),
        " が成り立たないなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_k\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l\bigr)_{S,U}
&=(c_k)_{S,U\cup\{l\}}\cdot_{\mathbb{C}}\varsigma(N_l(U))
&&\left(\because\ A:=c_k\text{、主張の}\ j\ \text{に}\ l\ \text{を当て、}l\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_l(U))
&&\left(\because\ \text{条件が成り立たないので}\ c_k\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "以上で（",
        math(String.raw`\star`),
        "）が示された。次に、",
        math(String.raw`\mathrm{C}_{i,j}(S,U)`),
        " と ",
        math(String.raw`\mathrm{C}_{j,i}(S,U)`),
        " は同値である。実際、",
        math(String.raw`i\neq j`),
        " と ",
        math(String.raw`j\neq i`),
        " は同値であり、和集合の定義により、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\in(U\cup\{j\})\cup\{i\}`),
        " と ",
        math(String.raw`t\in(U\cup\{i\})\cup\{j\}`),
        " はどちらも「",
        math(String.raw`t\in U`),
        " または ",
        math(String.raw`t=i`),
        " または ",
        math(String.raw`t=j`),
        "」と同値なので、",
        math(String.raw`(U\cup\{j\})\cup\{i\}=(U\cup\{i\})\cup\{j\}`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        " の元の等しさ）。",
      ]),
      paragraph([
        "本題。行列の等しさの定義（",
        ref("def_matrices_indexed_by_finite_set"),
        "）により、すべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について両辺の ",
        math(String.raw`(S,U)`),
        " 成分が等しいことを示せばよい。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定する。",
        math(String.raw`\mathrm{C}_{i,j}(S,U)`),
        " が成り立つか否かで場合を分ける（上で示した同値により、",
        math(String.raw`\mathrm{C}_{j,i}(S,U)`),
        " も同じ真偽をとる）。",
      ]),
      list([
        [
          math(String.raw`\mathrm{C}_{i,j}(S,U)`),
          " が成り立たないとき。",
          math(String.raw`\mathrm{C}_{j,i}(S,U)`),
          " も成り立たない。",
          math(String.raw`i=j`),
          " の場合はつねにこちらに入る（",
          math(String.raw`i\neq j`),
          " が成り立たないため）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ (k,l):=(i,j)\ \text{と}\ (k,l):=(j,i)\ \text{で}\ (\star)\text{。条件は成り立たない}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`\mathrm{C}_{i,j}(S,U)`),
          " が成り立つとき。",
          math(String.raw`\mathrm{C}_{j,i}(S,U)`),
          " も成り立ち、",
          math(String.raw`i\notin U`),
          "、",
          math(String.raw`j\notin U`),
          "、",
          math(String.raw`i\neq j`),
          " である。",
          math(String.raw`i,j`),
          " は整数なので、",
          math(String.raw`j<i`),
          " か ",
          math(String.raw`i<j`),
          " のどちらか一方である。どちらの場合も、部分集合に一つの元を足したときの個数の値の主張（",
          ref("claim_count_below_index_after_adding_one_element"),
          "）を ",
          math(String.raw`T:=U`),
          " に当てる。",
          math(String.raw`j<i`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma\bigl(N_i(U\cup\{j\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ (k,l):=(i,j)\ \text{と}\ (k,l):=(j,i)\ \text{で}\ (\star)\text{。条件は成り立つ}\right)\\
&\quad=\varsigma\bigl(N_i(U)+1\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{足す元}\ j\text{、番号}\ i\text{、}j<i\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\varsigma\bigl(N_i(U)+1\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma(N_j(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{足す元}\ i\text{、番号}\ j\text{、}i\ge j\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_i(U))\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma(N_j(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ n:=N_i(U)+1\in\mathbb{Z}_{\ge 1}\text{、}n-1=N_i(U)\ \text{で}\ \varsigma\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
  +_{\mathbb{C}}\varsigma(N_j(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&\quad=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
  +_{\mathbb{C}}\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&\quad=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
  +_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&\quad=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i<j`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma\bigl(N_i(U\cup\{j\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ (k,l):=(i,j)\ \text{と}\ (k,l):=(j,i)\ \text{で}\ (\star)\text{。条件は成り立つ}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{足す元}\ j\text{、番号}\ i\text{、}j\ge i\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\varsigma\bigl(N_j(U)+1\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{足す元}\ i\text{、番号}\ j\text{、}i<j\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ n:=N_j(U)+1\in\mathbb{Z}_{\ge 1}\text{、}n-1=N_j(U)\ \text{で}\ \varsigma\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_j(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&\quad=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))
  +_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
  +_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_j(U))\bigr)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "場合分けはすべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を尽くすので、両辺の成分はすべて等しく、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_annihilation_operator_matrices_anticommute",
    kind: "claim",
    title: { text: "消滅作用素の行列どうしの反交換関係" },
    labels: ["claim_annihilation_operator_matrices_anticommute"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i,j\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i^{\mathsf T},c_j^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"),
        "）とする。",
        math(String.raw`i=j`),
        " の場合も含めて、",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の中で次が成り立つ（演算と零行列は ",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
      displayMath(String.raw`c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}
+_{\mathrm{Mat}_{\mathcal{P}_M}}
c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}
=0_{\mathrm{Mat}_{\mathcal{P}_M}}.`),
    ],
    proof: [
      paragraph([
        "準備。和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        "（有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）の上の和（",
        ref("def_sum_over_finite_set"),
        "）である。",
        math(String.raw`k,l\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、次の等式（",
        math(String.raw`\star`),
        "）を示す。",
      ]),
      displayMath(String.raw`\bigl(c_k^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l^{\mathsf T}\bigr)_{S,U}
=\bigl(c_l\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_k\bigr)_{U,S}.
\qquad(\star)`),
      paragraph([
        "まず、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について和の項を書き直す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_k^{\mathsf T})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_l^{\mathsf T})_{T,U}
&=(c_k^{\mathsf T})_{S,T}\cdot_{\mathbb{C}}(c_l^{\mathsf T})_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(c_k)_{T,S}\cdot_{\mathbb{C}}(c_l)_{U,T}
&&\left(\because\ c_k^{\mathsf T}\ \text{と}\ c_l^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=(c_l)_{U,T}\cdot_{\mathbb{C}}(c_k)_{T,S}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(c_l)_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_k)_{T,S}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って（",
        math(String.raw`\star`),
        "）の左辺を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_k^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_l^{\mathsf T}\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}(c_k^{\mathsf T})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_l^{\mathsf T})_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}(c_l)_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_k)_{T,S}
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\bigl(c_l\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_k\bigr)_{U,S}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "本題。行列の等しさの定義（",
        ref("def_matrices_indexed_by_finite_set"),
        "）により、すべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について両辺の ",
        math(String.raw`(S,U)`),
        " 成分が等しいことを示せばよい。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}\bigr)_{S,U}\\
&\quad=\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{U,S}+_{\mathbb{C}}\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{U,S}
&&\left(\because\ (k,l):=(i,j)\ \text{と}\ (k,l):=(j,i)\ \text{で}\ (\star)\right)\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\bigr)_{U,S}+_{\mathbb{C}}\bigl(c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{U,S}
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{U,S}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{U,S}
&&\left(\because\ \text{生成作用素の行列どうしの反交換関係。}\blkref{claim_creation_operator_matrices_anticommute}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S,U\in\mathcal{P}_M`),
        " は任意なので、両辺の成分はすべて等しく、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_sign_of_nonnegative_integer_squares_to_one",
    kind: "claim",
    title: { text: "非負整数の偶奇による符号の自分自身との積は 1 であること" },
    labels: ["claim_sign_of_nonnegative_integer_squares_to_one"],
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について、非負整数の偶奇による符号 ",
        math(String.raw`\varsigma(n)\in\mathbb{C}`),
        "（",
        ref("def_sign_of_nonnegative_integer"),
        "）は ",
        math(String.raw`\mathbb{C}`),
        " の中で次を満たす。",
      ]),
      displayMath(String.raw`\varsigma(n)\cdot_{\mathbb{C}}\varsigma(n)=1_{\mathbb{C}}.`),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        math(String.raw`1_{\mathbb{C}}`),
        " の加法の逆元である（",
        ref("def_sign_of_nonnegative_integer"),
        "）。まず ",
        math(String.raw`(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}(-1_{\mathbb{C}})=0_{\mathbb{C}}`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}(-1_{\mathbb{C}})
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "これを使って、",
        math(String.raw`(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)+_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \text{上の等式}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "本題。",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n=0`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varsigma(0)\cdot_{\mathbb{C}}\varsigma(0)
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \varsigma(0)\ \text{の定義を二つの因子に。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`n-1\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\varsigma(n-1)\cdot_{\mathbb{C}}\varsigma(n-1)=1_{\mathbb{C}}`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varsigma(n)\cdot_{\mathbb{C}}\varsigma(n)
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)
&&\left(\because\ n\in\mathbb{Z}_{\ge 1}\ \text{での}\ \varsigma(n)\ \text{の定義を二つの因子に。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\Bigl(\varsigma(n-1)\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\Bigl(\bigl(\varsigma(n-1)\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\varsigma(n-1)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\Bigl(\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)\cdot_{\mathbb{C}}\varsigma(n-1)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\Bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\varsigma(n-1)\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\bigl(\varsigma(n-1)\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(\varsigma(n-1)\cdot_{\mathbb{C}}\varsigma(n-1)\bigr)
&&\left(\because\ \text{準備の}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph([
        "帰納法により、すべての ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_entry_of_creation_operator_matrix_times_matrix",
    kind: "claim",
    title: { text: "左から生成作用素の行列を掛けた行列の成分" },
    labels: ["claim_entry_of_creation_operator_matrix_times_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とする。",
        math(String.raw`S\in\mathcal{P}_M`),
        " が ",
        math(String.raw`i\in S`),
        " を満たすとき、",
        math(String.raw`S'`),
        " を次の集合とする。",
      ]),
      displayMath(String.raw`S':=\{\,t\in\{1,\dots,M\}\ :\ t\in S\ \text{かつ}\ t\neq i\,\}.`),
      paragraph([
        math(String.raw`S'\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`S'\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）である。",
        math(String.raw`A\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、行列の積 ",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）の成分は次のとおりである。",
      ]),
      displayMath(String.raw`\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}A\bigr)_{S,U}=
\begin{cases}
  \varsigma(N_i(S'))\cdot_{\mathbb{C}}A_{S',U} & (i\in S),\\
  0_{\mathbb{C}} & (i\notin S).
\end{cases}`),
      paragraph([
        "右辺の ",
        math(String.raw`N_i(S')\in\mathbb{Z}_{\ge 0}`),
        " は部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "）、",
        math(String.raw`\varsigma(N_i(S'))\in\mathbb{C}`),
        " は非負整数の偶奇による符号（",
        ref("def_sign_of_nonnegative_integer"),
        "）である。記号 ",
        math(String.raw`S'`),
        " は ",
        math(String.raw`S`),
        " と ",
        math(String.raw`i`),
        " を書かないが、",
        math(String.raw`S`),
        " と ",
        math(String.raw`i`),
        " ごとに別の集合である。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        "（有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        "、",
        math(String.raw`X:=\mathcal{P}_M`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
        math(String.raw`i\notin S`),
        " か ",
        math(String.raw`i\in S`),
        " かで二つの場合に分ける。",
      ]),
      list([
        [
          math(String.raw`i\notin S`),
          " のとき。準備として、各 ",
          math(String.raw`T\in\mathcal{P}_M`),
          " について次の等式を示す。",
          math(String.raw`S=T\cup\{i\}`),
          " なら ",
          math(String.raw`i\in S`),
          " となるので、",
          math(String.raw`i\notin S`),
          " から ",
          math(String.raw`S\neq T\cup\{i\}`),
          " であり、",
          math(String.raw`c_i`),
          " の定義の条件「",
          math(String.raw`i\notin T`),
          " かつ ",
          math(String.raw`S=T\cup\{i\}`),
          "」は成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{T,U}
&=(c_i)_{S,T}\cdot_{\mathbb{C}}A_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}A_{T,U}
&&\left(\because\ \text{条件が成り立たないので}\ c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\text{（二回）}\right)\\
&=(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}A\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}(c_i)_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}
&&\left(\because\ \text{各}\ T\ \text{で準備の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}}\right)
&&\left(\because\ \rho:=0_{\mathbb{C}}\text{、}\lambda_T:=1_{\mathbb{C}}\text{、}v_T:=1_{\mathbb{C}}\ \text{を当てる。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=0_{\mathbb{C}^{\mathrm{vec}}}
&&\left(\because\ \text{零のスカラー倍は零ベクトル。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`i\in S`),
          " のとき。準備として、",
          math(String.raw`T\in\mathcal{P}_M`),
          " について、",
          math(String.raw`c_i`),
          " の定義の条件「",
          math(String.raw`i\notin T`),
          " かつ ",
          math(String.raw`S=T\cup\{i\}`),
          "」が ",
          math(String.raw`T=S'`),
          " と同値であることを示す。",
          math(String.raw`\mathcal{P}_M`),
          " の二元が等しいことは、各 ",
          math(String.raw`t\in\{1,\dots,M\}`),
          " での所属が同値であることである（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
        [
          "条件が成り立つとする。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in S'`),
          " は ",
          math(String.raw`S'`),
          " の置き方で「",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\neq i`),
          "」と同値であり、",
          math(String.raw`S=T\cup\{i\}`),
          " から「（",
          math(String.raw`t\in T`),
          " または ",
          math(String.raw`t=i`),
          "）かつ ",
          math(String.raw`t\neq i`),
          "」と同値であり、これは「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\neq i`),
          "」と同値である。",
          math(String.raw`i\notin T`),
          " なので ",
          math(String.raw`t\in T`),
          " なら ",
          math(String.raw`t\neq i`),
          " であり、これは ",
          math(String.raw`t\in T`),
          " と同値である。したがって ",
          math(String.raw`T=S'`),
          " である。",
        ],
        [
          math(String.raw`T=S'`),
          " とする。",
          math(String.raw`S'`),
          " の置き方で ",
          math(String.raw`i\notin S'`),
          " なので ",
          math(String.raw`i\notin T`),
          " である。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in T\cup\{i\}`),
          " は「（",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\neq i`),
          "）または ",
          math(String.raw`t=i`),
          "」と同値である。",
          math(String.raw`t=i`),
          " なら ",
          math(String.raw`i\in S`),
          " から ",
          math(String.raw`t\in S`),
          " なので、これは ",
          math(String.raw`t\in S`),
          " と同値である。したがって ",
          math(String.raw`S=T\cup\{i\}`),
          " であり、条件が成り立つ。",
        ],
      ]),
      paragraph([
        "次に、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について ",
        math(String.raw`(c_i)_{S,T}=\delta_{S',T}\cdot_{\mathbb{C}}\varsigma(N_i(S'))`),
        " を示す。",
        math(String.raw`\delta_{S',T}\in\mathbb{C}`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）である。",
        math(String.raw`T=S'`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}
&=\varsigma(N_i(T))
&&\left(\because\ T=S'\ \text{なので上の同値により条件が成り立ち、}c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=\varsigma(N_i(S'))
&&\left(\because\ T=S'\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ S'=T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`T\neq S'`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}
&=0_{\mathbb{C}}
&&\left(\because\ T\neq S'\ \text{なので上の同値により条件が成り立たず、}c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ S'\neq T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        "さらに、",
        math(String.raw`T\in\mathcal{P}_M`),
        " について ",
        math(String.raw`r_T:=\varsigma(N_i(S'))\cdot_{\mathbb{C}}A_{T,U}\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について、和の項を次のように書き直す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{T,U}
&=(c_i)_{S,T}\cdot_{\mathbb{C}}A_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\bigl(\delta_{S',T}\cdot_{\mathbb{C}}\varsigma(N_i(S'))\bigr)\cdot_{\mathbb{C}}A_{T,U}
&&\left(\because\ \text{上の準備の等式}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}}\bigl(\varsigma(N_i(S'))\cdot_{\mathbb{C}}A_{T,U}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}}r_T
&&\left(\because\ r_T\ \text{の置き方}\right)\\
&=\delta_{S',T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}A\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}(c_i)_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}\delta_{S',T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_{S'}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ S'\text{、和の変数に}\ T\text{、}v_T:=r_T\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}A_{S',U}
&&\left(\because\ r_T\ \text{の置き方で}\ T:=S'\right).
\end{aligned}`),
      paragraph([
        "二つの場合は ",
        math(String.raw`i\notin S`),
        " と ",
        math(String.raw`i\in S`),
        " を尽くすので、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_creation_and_annihilation_operator_matrices_anticommute",
    kind: "claim",
    title: { text: "生成作用素の行列と消滅作用素の行列の反交換関係" },
    labels: ["claim_creation_and_annihilation_operator_matrices_anticommute"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i,j\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）、",
        math(String.raw`c_j^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"),
        "）とする。",
        math(String.raw`\delta_{i,j}\in\mathbb{C}`),
        " を集合 ",
        math(String.raw`\{1,\dots,M\}`),
        " の二元のクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）とする。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の中で次が成り立つ（演算と単位行列は ",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
      displayMath(String.raw`c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}
+_{\mathrm{Mat}_{\mathcal{P}_M}}
c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i
=\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}.`),
    ],
    proof: [
      paragraph([
        "行列の等しさの定義（",
        ref("def_matrices_indexed_by_finite_set"),
        "）により、すべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について両辺の ",
        math(String.raw`(S,U)`),
        " 成分が等しいことを示せばよい。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定し、",
        math(String.raw`S`),
        " から ",
        math(String.raw`i`),
        " を除いた集合を次のように置く。",
      ]),
      displayMath(String.raw`S':=\{\,t\in\{1,\dots,M\}\ :\ t\in S\ \text{かつ}\ t\neq i\,\}\in\mathcal{P}_M.`),
      paragraph([
        "これは左から生成作用素の行列を掛けた行列の成分の主張（",
        ref("claim_entry_of_creation_operator_matrix_times_matrix"),
        "）の ",
        math(String.raw`S'`),
        " と同じ式である（右辺の式は ",
        math(String.raw`i\notin S`),
        " のときも ",
        math(String.raw`\mathcal{P}_M`),
        " の元を定める）。",
        math(String.raw`S'`),
        " の置き方により ",
        math(String.raw`i\notin S'`),
        " である。また ",
        math(String.raw`i\in S`),
        " なら ",
        math(String.raw`S'\cup\{i\}=S`),
        " である（",
        math(String.raw`\sharp`),
        "）。実際、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\in S'\cup\{i\}`),
        " は「（",
        math(String.raw`t\in S`),
        " かつ ",
        math(String.raw`t\neq i`),
        "）または ",
        math(String.raw`t=i`),
        "」と同値であり、",
        math(String.raw`i\in S`),
        " なのでこれは ",
        math(String.raw`t\in S`),
        " と同値である（",
        ref("def_power_set_of_first_m_positive_integers"),
        " の元の等しさ）。",
      ]),
      paragraph([
        "準備。右辺の成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&=\delta_{i,j}\cdot_{\mathbb{C}}\bigl(1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ \ast_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ 1_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}
\qquad(\flat)`),
      paragraph([
        "準備。左辺の一つ目の項の成分について、条件 ",
        math(String.raw`\mathrm{D}_1`),
        " を「",
        math(String.raw`i\in S`),
        " かつ ",
        math(String.raw`j\notin S'`),
        " かつ ",
        math(String.raw`U=S'\cup\{j\}`),
        "」と置き、次の等式（",
        math(String.raw`\star_1`),
        "）を示す。",
      ]),
      displayMath(String.raw`\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}=
\begin{cases}
  \varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S')) & (\mathrm{D}_1\ \text{が成り立つ}),\\
  0_{\mathbb{C}} & (\text{成り立たない}).
\end{cases}
\qquad(\star_1)`),
      list([
        [
          math(String.raw`i\notin S`),
          " のとき。",
          math(String.raw`\mathrm{D}_1`),
          " は成り立たず、左から生成作用素の行列を掛けた行列の成分の主張（",
          ref("claim_entry_of_creation_operator_matrix_times_matrix"),
          "）を ",
          math(String.raw`A:=c_j^{\mathsf T}`),
          " に当てると、",
          math(String.raw`(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T})_{S,U}=0_{\mathbb{C}}`),
          " である。",
        ],
        [
          math(String.raw`i\in S`),
          " のとき。",
          math(String.raw`c_j`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）で行の添字を ",
          math(String.raw`U`),
          "、列の添字を ",
          math(String.raw`S'`),
          " としたときの条件「",
          math(String.raw`j\notin S'`),
          " かつ ",
          math(String.raw`U=S'\cup\{j\}`),
          "」は、",
          math(String.raw`i\in S`),
          " のもとで ",
          math(String.raw`\mathrm{D}_1`),
          " と同値である。",
          math(String.raw`\mathrm{D}_1`),
          " が成り立つなら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\bigl(c_j^{\mathsf T}\bigr)_{S',U}
&&\left(\because\ A:=c_j^{\mathsf T}\text{、}i\in S\text{。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}(c_j)_{U,S'}
&&\left(\because\ c_j^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))
&&\left(\because\ \text{条件が成り立つので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{D}_1`),
        " が成り立たないなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\bigl(c_j^{\mathsf T}\bigr)_{S',U}
&&\left(\because\ A:=c_j^{\mathsf T}\text{、}i\in S\text{。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}(c_j)_{U,S'}
&&\left(\because\ c_j^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\varsigma(N_i(S'))\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "準備。左辺の二つ目の項の成分について、条件 ",
        math(String.raw`\mathrm{D}_2`),
        " を「",
        math(String.raw`i\notin U`),
        " かつ ",
        math(String.raw`j\notin S`),
        " かつ ",
        math(String.raw`U\cup\{i\}=S\cup\{j\}`),
        "」と置き、次の等式（",
        math(String.raw`\star_2`),
        "）を示す。",
      ]),
      displayMath(String.raw`\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}=
\begin{cases}
  \varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U)) & (\mathrm{D}_2\ \text{が成り立つ}),\\
  0_{\mathbb{C}} & (\text{成り立たない}).
\end{cases}
\qquad(\star_2)`),
      list([
        [
          math(String.raw`i\in U`),
          " のとき。",
          math(String.raw`\mathrm{D}_2`),
          " は成り立たず、右から生成作用素の行列を掛けた行列の成分の主張（",
          ref("claim_entry_of_matrix_times_creation_operator_matrix"),
          "）を ",
          math(String.raw`A:=c_j^{\mathsf T}`),
          "、主張の ",
          math(String.raw`j`),
          " に ",
          math(String.raw`i`),
          " を当てると、",
          math(String.raw`(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i)_{S,U}=0_{\mathbb{C}}`),
          " である。",
        ],
        [
          math(String.raw`i\notin U`),
          " のとき。",
          math(String.raw`U\cup\{i\}\in\mathcal{P}_M`),
          " である。",
          math(String.raw`c_j`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）で行の添字を ",
          math(String.raw`U\cup\{i\}`),
          "、列の添字を ",
          math(String.raw`S`),
          " としたときの条件「",
          math(String.raw`j\notin S`),
          " かつ ",
          math(String.raw`U\cup\{i\}=S\cup\{j\}`),
          "」は、",
          math(String.raw`i\notin U`),
          " のもとで ",
          math(String.raw`\mathrm{D}_2`),
          " と同値である。",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つなら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=\bigl(c_j^{\mathsf T}\bigr)_{S,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ A:=c_j^{\mathsf T}\text{、主張の}\ j\ \text{に}\ i\ \text{を当て、}i\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=(c_j)_{U\cup\{i\},S}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ c_j^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立つので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{D}_2`),
        " が成り立たないなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=\bigl(c_j^{\mathsf T}\bigr)_{S,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ A:=c_j^{\mathsf T}\text{、主張の}\ j\ \text{に}\ i\ \text{を当て、}i\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=(c_j)_{U\cup\{i\},S}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ c_j^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立たないので}\ c_j\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "本題。",
        math(String.raw`i=j`),
        " か ",
        math(String.raw`i\neq j`),
        " かで二つの場合に分ける。",
      ]),
      list([
        [
          math(String.raw`i=j`),
          " のとき。",
          math(String.raw`\delta_{i,j}=1_{\mathbb{C}}`),
          "（",
          ref("def_kronecker_delta"),
          "）である。まず、",
          math(String.raw`\mathrm{D}_1`),
          " は「",
          math(String.raw`i\in S`),
          " かつ ",
          math(String.raw`U=S`),
          "」と同値である。実際、",
          math(String.raw`j=i\notin S'`),
          " はつねに成り立ち、",
          math(String.raw`i\in S`),
          " なら（",
          math(String.raw`\sharp`),
          "）により ",
          math(String.raw`S'\cup\{j\}=S'\cup\{i\}=S`),
          " である。",
        ],
        [
          "次に、",
          math(String.raw`\mathrm{D}_2`),
          " は「",
          math(String.raw`i\notin S`),
          " かつ ",
          math(String.raw`U=S`),
          "」と同値である。",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つとする。",
          math(String.raw`j=i`),
          " なので ",
          math(String.raw`i\notin S`),
          " である。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t=i`),
          " なら ",
          math(String.raw`t\notin U`),
          " かつ ",
          math(String.raw`t\notin S`),
          " であり、",
          math(String.raw`t\neq i`),
          " なら ",
          math(String.raw`t\in U`),
          "・",
          math(String.raw`t\in U\cup\{i\}`),
          "・",
          math(String.raw`t\in S\cup\{i\}`),
          "・",
          math(String.raw`t\in S`),
          " は順に同値である。したがって ",
          math(String.raw`U=S`),
          " である。逆に「",
          math(String.raw`i\notin S`),
          " かつ ",
          math(String.raw`U=S`),
          "」なら、",
          math(String.raw`i\notin U`),
          "、",
          math(String.raw`j=i\notin S`),
          "、",
          math(String.raw`U\cup\{i\}=S\cup\{i\}=S\cup\{j\}`),
          " であり、",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つ。",
        ],
        [
          math(String.raw`U=S`),
          " かつ ",
          math(String.raw`i\in S`),
          " なら、",
          math(String.raw`\mathrm{D}_1`),
          " は成り立ち、",
          math(String.raw`\mathrm{D}_2`),
          " は成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \mathrm{D}_1\ \text{が成り立つので}\ (\star_1)\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathrm{D}_2\ \text{が成り立たないので}\ (\star_2)\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_i(S'))+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ j=i\right)\\
&\quad=1_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ n:=N_i(S')\ \text{を当てる。}\blkref{claim_sign_of_nonnegative_integer_squares_to_one}\right)\\
&\quad=1_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ i=j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ S=U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      list([
        [
          math(String.raw`U=S`),
          " かつ ",
          math(String.raw`i\notin S`),
          " なら、",
          math(String.raw`\mathrm{D}_1`),
          " は成り立たず、",
          math(String.raw`\mathrm{D}_2`),
          " は成り立つ。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \mathrm{D}_1\ \text{が成り立たないので}\ (\star_1)\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \mathrm{D}_2\ \text{が成り立つので}\ (\star_2)\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\varsigma(N_i(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ j=i\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\varsigma(N_i(S))\cdot_{\mathbb{C}}\varsigma(N_i(S))
&&\left(\because\ U=S\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ n:=N_i(S)\ \text{を当てる。}\blkref{claim_sign_of_nonnegative_integer_squares_to_one}\right)\\
&\quad=1_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ i=j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ S=U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      list([
        [
          math(String.raw`U\neq S`),
          " なら、上の二つの同値により ",
          math(String.raw`\mathrm{D}_1`),
          " も ",
          math(String.raw`\mathrm{D}_2`),
          " も成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_1)\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_2)\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ i=j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ S\neq U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      list([
        [
          math(String.raw`i\neq j`),
          " のとき。",
          math(String.raw`\delta_{i,j}=0_{\mathbb{C}}`),
          "（",
          ref("def_kronecker_delta"),
          "）である。条件 ",
          math(String.raw`\mathrm{D}`),
          " を「",
          math(String.raw`i\in S`),
          " かつ ",
          math(String.raw`j\notin S`),
          " かつ ",
          math(String.raw`U=S'\cup\{j\}`),
          "」と置く。",
          math(String.raw`j\neq i`),
          " なので、",
          math(String.raw`S'`),
          " の置き方により ",
          math(String.raw`j\notin S'`),
          " と ",
          math(String.raw`j\notin S`),
          " は同値であり、",
          math(String.raw`\mathrm{D}_1`),
          " は ",
          math(String.raw`\mathrm{D}`),
          " と同値である。",
        ],
        [
          math(String.raw`\mathrm{D}_2`),
          " も ",
          math(String.raw`\mathrm{D}`),
          " と同値である。",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つとする。",
          math(String.raw`i\in U\cup\{i\}=S\cup\{j\}`),
          " と ",
          math(String.raw`i\neq j`),
          " から ",
          math(String.raw`i\in S`),
          " である。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t=i`),
          " なら ",
          math(String.raw`t\notin U`),
          " かつ ",
          math(String.raw`t\notin S'\cup\{j\}`),
          "（",
          math(String.raw`i\notin S'`),
          " と ",
          math(String.raw`i\neq j`),
          "）であり、",
          math(String.raw`t\neq i`),
          " なら ",
          math(String.raw`t\in U`),
          "・",
          math(String.raw`t\in U\cup\{i\}`),
          "・",
          math(String.raw`t\in S\cup\{j\}`),
          "・「（",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\neq i`),
          "）または ",
          math(String.raw`t=j`),
          "」・",
          math(String.raw`t\in S'\cup\{j\}`),
          " は順に同値である。したがって ",
          math(String.raw`U=S'\cup\{j\}`),
          " であり、",
          math(String.raw`\mathrm{D}`),
          " が成り立つ。逆に ",
          math(String.raw`\mathrm{D}`),
          " が成り立つとする。",
          math(String.raw`i\notin S'`),
          " と ",
          math(String.raw`i\neq j`),
          " から ",
          math(String.raw`i\notin S'\cup\{j\}=U`),
          " である。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in U\cup\{i\}`),
          " は「",
          math(String.raw`t\in S'\cup\{i\}`),
          " または ",
          math(String.raw`t=j`),
          "」と同値であり、（",
          math(String.raw`\sharp`),
          "）によりこれは ",
          math(String.raw`t\in S\cup\{j\}`),
          " と同値である。したがって ",
          math(String.raw`U\cup\{i\}=S\cup\{j\}`),
          " であり、",
          math(String.raw`\mathrm{D}_2`),
          " が成り立つ。",
        ],
        [
          math(String.raw`\mathrm{D}`),
          " が成り立たないなら、",
          math(String.raw`\mathrm{D}_1`),
          " も ",
          math(String.raw`\mathrm{D}_2`),
          " も成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_1)\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_2)\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i\neq j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      list([
        [
          math(String.raw`\mathrm{D}`),
          " が成り立つなら、",
          math(String.raw`\mathrm{D}_1`),
          " も ",
          math(String.raw`\mathrm{D}_2`),
          " も成り立つ。",
          math(String.raw`i\in S`),
          " なので（",
          math(String.raw`\sharp`),
          "）により ",
          math(String.raw`S=S'\cup\{i\}`),
          "、また ",
          math(String.raw`U=S'\cup\{j\}`),
          " であり、",
          math(String.raw`i\notin S'`),
          "、",
          math(String.raw`j\notin S'`),
          " である。部分集合に一つの元を足したときの個数の値の主張（",
          ref("claim_count_below_index_after_adding_one_element"),
          "）を ",
          math(String.raw`T:=S'`),
          " に当てる。",
          math(String.raw`\alpha:=\varsigma(N_i(S'))\in\mathbb{C}`),
          "、",
          math(String.raw`\beta:=\varsigma(N_j(S'))\in\mathbb{C}`),
          " と置く。",
          math(String.raw`i,j`),
          " は整数なので ",
          math(String.raw`j<i`),
          " か ",
          math(String.raw`i<j`),
          " のどちらか一方である。",
          math(String.raw`j<i`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \text{条件が成り立つので}\ (\star_1)\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立つので}\ (\star_2)\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ S=S'\cup\{i\}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ U=S'\cup\{j\}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S'))\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ \text{足す元}\ i\text{、番号}\ j\text{、}i\ge j\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S'))\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S')+1\bigr)
&&\left(\because\ \text{足す元}\ j\text{、番号}\ i\text{、}j<i\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S'))\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_i(S'))\bigr)
&&\left(\because\ n:=N_i(S')+1\in\mathbb{Z}_{\ge 1}\text{、}n-1=N_i(S')\ \text{で}\ \varsigma\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\beta\cdot_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\alpha\bigr)
&&\left(\because\ \alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\alpha\bigr)\cdot_{\mathbb{C}}\beta
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i\neq j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i<j`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}+_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}\\
&\quad=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_j^{\mathsf T}\bigr)_{S,U}+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ +_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\bigl(c_j^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&&\left(\because\ \text{条件が成り立つので}\ (\star_1)\right)\\
&\quad=\varsigma(N_i(S'))\cdot_{\mathbb{C}}\varsigma(N_j(S'))+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立つので}\ (\star_2)\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ S=S'\cup\{i\}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ U=S'\cup\{j\}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S')+1\bigr)\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ \text{足す元}\ i\text{、番号}\ j\text{、}i<j\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S')+1\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ \text{足す元}\ j\text{、番号}\ i\text{、}j\ge i\text{。}\blkref{claim_count_below_index_after_adding_one_element}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_j(S'))\bigr)\cdot_{\mathbb{C}}\varsigma(N_i(S'))
&&\left(\because\ n:=N_j(S')+1\in\mathbb{Z}_{\ge 1}\text{、}n-1=N_j(S')\ \text{で}\ \varsigma\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\beta\bigr)\cdot_{\mathbb{C}}\alpha
&&\left(\because\ \alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\beta\cdot_{\mathbb{C}}\alpha)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)+_{\mathbb{C}}(-1_{\mathbb{C}})\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}\beta)
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i\neq j\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&\quad=\bigl(\delta_{i,j}\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ (\flat)\right).
\end{aligned}`),
      paragraph([
        "場合分けはすべての ",
        math(String.raw`i,j\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を尽くすので、両辺の成分はすべて等しく、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_count_below_index_vanishes_without_smaller_elements",
    kind: "claim",
    title: { text: "番号より小さい元を持たない部分集合の、番号より小さい元を数える個数は 0 であること" },
    labels: ["claim_count_below_index_vanishes_without_smaller_elements"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`T\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について、",
        math(String.raw`T`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge i`),
        " を満たすなら、部分集合のうち番号より小さい元を数える個数（",
        ref("def_count_of_subset_elements_below_index"),
        "）は次を満たす。",
      ]),
      displayMath(String.raw`N_i(T)=0.`),
    ],
    proof: [
      paragraph([
        math(String.raw`T`),
        " を固定し、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " についての帰納法で、命題「",
        math(String.raw`T`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge i`),
        " を満たすなら ",
        math(String.raw`N_i(T)=0`),
        "」を示す。",
        math(String.raw`M=0`),
        " なら ",
        math(String.raw`\{1,\dots,M\}`),
        " は空集合なので、示すことは無い。",
      ]),
      paragraph([
        math(String.raw`i=1`),
        " のとき。",
        math(String.raw`T`),
        " の元についての仮定を使わずに次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_1(T)
&=0
&&\left(\because\ N_1\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in\{2,\dots,M\}`),
        " とし、",
        math(String.raw`i-1`),
        " について命題が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`T`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge i`),
        " を満たすとする。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`T`),
        " の各元 ",
        math(String.raw`t`),
        " について ",
        math(String.raw`t\ge i>i-1`),
        " なので、",
        math(String.raw`T`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge i-1`),
        " を満たす。したがって帰納法の仮定から ",
        math(String.raw`N_{i-1}(T)=0`),
        " である（",
        math(String.raw`\star`),
        "）。また ",
        math(String.raw`i-1\in T`),
        " なら仮定から ",
        math(String.raw`i-1\ge i`),
        " となり ",
        math(String.raw`i-1<i`),
        " に反するので、",
        math(String.raw`i-1\notin T`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_i(T)
&=N_{i-1}(T)
&&\left(\because\ i-1\notin T\ \text{なので}\ N_i\ \text{の定義。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=0
&&\left(\because\ (\star)\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について命題が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit",
    kind: "claim",
    title: { text: "消滅作用素の行列と生成作用素の行列の積を番号順に掛けると、空集合の位置の行列単位になること" },
    labels: ["claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）、",
        math(String.raw`c_i^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"),
        "）とし、",
      ]),
      displayMath(String.raw`x_i:=c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
      paragraph([
        "と置く（",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        " は行列の積。",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " は ℂ-代数である（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "。",
        math(String.raw`\mathcal{P}_M`),
        " が有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）。その中の ",
        math(String.raw`x_1,\dots,x_M`),
        " の番号順の積（",
        ref("def_ordered_product_in_algebra"),
        "）と、",
        math(String.raw`\emptyset\in\mathcal{P}_M`),
        " の位置の行列単位 ",
        math(String.raw`E_{\emptyset,\emptyset}`),
        "（",
        ref("def_matrix_unit"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,i=1}^{M}x_i=E_{\emptyset,\emptyset}.`),
    ],
    proof: [
      paragraph([
        "以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        "、",
        math(String.raw`X:=\mathcal{P}_M`),
        " に当てる。",
        math(String.raw`\delta`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）である。",
      ]),
      paragraph([
        "記号の準備。",
        math(String.raw`i\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`U\in\mathcal{P}_M`),
        " について、",
        math(String.raw`\eta_i(U)\in\mathbb{C}`),
        " を、",
        math(String.raw`i\notin U`),
        " なら ",
        math(String.raw`\eta_i(U):=1_{\mathbb{C}}`),
        "、",
        math(String.raw`i\in U`),
        " なら ",
        math(String.raw`\eta_i(U):=0_{\mathbb{C}}`),
        " と定める（",
        math(String.raw`i\in U`),
        " の真偽は ",
        ref("def_power_set_of_first_m_positive_integers"),
        " により一つに決まる）。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、条件 ",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " を「",
        math(String.raw`S=U`),
        " かつ、",
        math(String.raw`t\in S`),
        " を満たす ",
        math(String.raw`t\in\{1,\dots,m\}`),
        " が無い」と定め、",
        math(String.raw`\chi_m(S,U)\in\mathbb{C}`),
        " を、",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立つなら ",
        math(String.raw`1_{\mathbb{C}}`),
        "、成り立たないなら ",
        math(String.raw`0_{\mathbb{C}}`),
        " と定める。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について、",
        math(String.raw`\Pi_m\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、番号順の積の定義（",
        ref("def_ordered_product_in_algebra"),
        "）の ",
        math(String.raw`\Pi_m`),
        " に ",
        math(String.raw`A:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "、",
        math(String.raw`n:=M`),
        "、族 ",
        math(String.raw`x_1,\dots,x_M`),
        " を当てたものとする。すなわち ",
        math(String.raw`\Pi_0=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "、",
        math(String.raw`\Pi_m=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}x_m`),
        "（",
        math(String.raw`1\le m\le M`),
        "）であり、",
        math(String.raw`\Pi_M=\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,i=1}^{M}x_i`),
        " である。",
      ]),
      paragraph([
        "準備の一つ目。すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`T,U\in\mathcal{P}_M`),
        " について、次を示す。",
      ]),
      displayMath(String.raw`(x_i)_{T,U}=\delta_{U,T}\cdot_{\mathbb{C}}\eta_i(U)\qquad(\star_1).`),
      paragraph([
        "右から生成作用素の行列を掛けた行列の成分の主張（",
        ref("claim_entry_of_matrix_times_creation_operator_matrix"),
        "）を ",
        math(String.raw`A:=c_i^{\mathsf T}`),
        "、",
        math(String.raw`j:=i`),
        "、主張の ",
        math(String.raw`S`),
        " に ",
        math(String.raw`T`),
        " を当てて使う。",
        math(String.raw`i\in U`),
        " か ",
        math(String.raw`i\notin U`),
        " かで分ける。",
      ]),
      list([
        [
          math(String.raw`i\in U`),
          " のとき。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
(x_i)_{T,U}
&=\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{T,U}
&&\left(\because\ x_i\ \text{の置き方}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ i\in U\ \text{なので右から掛けた成分の主張。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}\eta_i(U)
&&\left(\because\ i\in U\ \text{なので}\ \eta_i\ \text{の置き方}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`i\notin U`),
          " のとき。まず、",
          math(String.raw`c_i`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）の ",
          math(String.raw`(U\cup\{i\},T)`),
          " 成分の条件「",
          math(String.raw`i\notin T`),
          " かつ ",
          math(String.raw`U\cup\{i\}=T\cup\{i\}`),
          "」が ",
          math(String.raw`T=U`),
          " と同値であることを示す。",
          math(String.raw`T=U`),
          " なら、",
          math(String.raw`i\notin U`),
          " から ",
          math(String.raw`i\notin T`),
          " であり、",
          math(String.raw`U\cup\{i\}=T\cup\{i\}`),
          " である。逆に条件が成り立つとする。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " が ",
          math(String.raw`t\neq i`),
          " なら、",
          math(String.raw`t\in T`),
          " と ",
          math(String.raw`t\in T\cup\{i\}`),
          " と ",
          math(String.raw`t\in U\cup\{i\}`),
          " と ",
          math(String.raw`t\in U`),
          " は同値である。",
          math(String.raw`t=i`),
          " なら、",
          math(String.raw`i\notin T`),
          " と ",
          math(String.raw`i\notin U`),
          " から、",
          math(String.raw`t\in T`),
          " と ",
          math(String.raw`t\in U`),
          " はどちらも成り立たない。したがってすべての ",
          math(String.raw`t\in\{1,\dots,M\}`),
          " で ",
          math(String.raw`t\in T`),
          " と ",
          math(String.raw`t\in U`),
          " は同値であり、",
          math(String.raw`T=U`),
          " である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
          math(String.raw`T=U`),
          " なら次のとおりである。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
(x_i)_{T,U}
&=\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{T,U}
&&\left(\because\ x_i\ \text{の置き方}\right)\\
&=(c_i^{\mathsf T})_{T,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ i\notin U\ \text{なので右から掛けた成分の主張。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=(c_i)_{U\cup\{i\},T}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ c_i^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\varsigma(N_i(T))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ T=U\ \text{なので条件が成り立ち、}c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=\varsigma(N_i(U))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ T=U\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \text{符号の自分自身との積。}\blkref{claim_sign_of_nonnegative_integer_squares_to_one}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ U=T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}\eta_i(U)
&&\left(\because\ i\notin U\ \text{なので}\ \eta_i\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`T\neq U`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(x_i)_{T,U}
&=\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{T,U}
&&\left(\because\ x_i\ \text{の置き方}\right)\\
&=(c_i^{\mathsf T})_{T,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ i\notin U\ \text{なので右から掛けた成分の主張。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=(c_i)_{U\cup\{i\},T}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ c_i^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ T\neq U\ \text{なので条件が成り立たず、}c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\eta_i(U)
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}\eta_i(U)
&&\left(\because\ U\neq T\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        "準備の二つ目。すべての ",
        math(String.raw`m\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、次を示す。",
      ]),
      displayMath(String.raw`\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)=\chi_m(S,U)\qquad(\star_2).`),
      paragraph([
        "まず、",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が「",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " かつ ",
        math(String.raw`m\notin U`),
        "」と同値であることを示す。",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立つなら、",
        math(String.raw`\{1,\dots,m-1\}\subseteq\{1,\dots,m\}`),
        " なので ",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " が成り立ち、",
        math(String.raw`m\in\{1,\dots,m\}`),
        " なので ",
        math(String.raw`m\notin S`),
        "、",
        math(String.raw`S=U`),
        " から ",
        math(String.raw`m\notin U`),
        " である。逆に「",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " かつ ",
        math(String.raw`m\notin U`),
        "」が成り立つなら、",
        math(String.raw`S=U`),
        " であり、",
        math(String.raw`t\in\{1,\dots,m\}`),
        " は ",
        math(String.raw`t\le m-1`),
        " なら ",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " から、",
        math(String.raw`t=m`),
        " なら ",
        math(String.raw`m\notin U=S`),
        " から ",
        math(String.raw`t\notin S`),
        " を満たすので、",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立つ。",
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立つなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \mathrm{C}_{m-1}(S,U)\ \text{が成り立つので}\ \chi_{m-1}\ \text{の置き方}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ m\notin U\ \text{なので}\ \eta_m\ \text{の置き方}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\chi_m(S,U)
&&\left(\because\ \mathrm{C}_m(S,U)\ \text{が成り立つので}\ \chi_m\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立たず、",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " も成り立たないなら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \mathrm{C}_{m-1}(S,U)\ \text{が成り立たないので}\ \chi_{m-1}\ \text{の置き方}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\chi_m(S,U)
&&\left(\because\ \mathrm{C}_m(S,U)\ \text{が成り立たないので}\ \chi_m\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{C}_m(S,U)`),
        " が成り立たず、",
        math(String.raw`\mathrm{C}_{m-1}(S,U)`),
        " が成り立つなら、上の同値から ",
        math(String.raw`m\in U`),
        " であり、次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)
&=\chi_{m-1}(S,U)\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ m\in U\ \text{なので}\ \eta_m\ \text{の置き方}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\chi_m(S,U)
&&\left(\because\ \mathrm{C}_m(S,U)\ \text{が成り立たないので}\ \chi_m\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        "本題の前半。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " についての帰納法で、命題「すべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について ",
        math(String.raw`(\Pi_m)_{S,U}=\chi_m(S,U)`),
        "」を示す。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき。",
        math(String.raw`\{1,\dots,0\}`),
        " は空集合なので、",
        math(String.raw`\mathrm{C}_0(S,U)`),
        " は ",
        math(String.raw`S=U`),
        " と同値である。",
        math(String.raw`S=U`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_0)_{S,U}
&=(1_{\mathrm{Mat}_{\mathcal{P}_M}})_{S,U}
&&\left(\because\ \Pi_0\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\delta_{S,U}
&&\left(\because\ \text{単位行列の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ S=U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\chi_0(S,U)
&&\left(\because\ \mathrm{C}_0(S,U)\ \text{が成り立つので}\ \chi_0\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S\neq U`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_0)_{S,U}
&=(1_{\mathrm{Mat}_{\mathcal{P}_M}})_{S,U}
&&\left(\because\ \Pi_0\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\delta_{S,U}
&&\left(\because\ \text{単位行列の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ S\neq U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\chi_0(S,U)
&&\left(\because\ \mathrm{C}_0(S,U)\ \text{が成り立たないので}\ \chi_0\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`m-1`),
        " について命題が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定する。",
        math(String.raw`T\in\mathcal{P}_M`),
        " について ",
        math(String.raw`r_T:=(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}\eta_m(U)\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`T\in\mathcal{P}_M`),
        " について、和の項のデルタを係数の位置へ移した次の等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(x_m)_{T,U}
&=(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}(x_m)_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}\bigl(\delta_{U,T}\cdot_{\mathbb{C}}\eta_m(U)\bigr)
&&\left(\because\ (\star_1)\ \text{を}\ i:=m\ \text{に当てる}\right)\\
&=\bigl((\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}\delta_{U,T}\bigr)\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\bigl(\delta_{U,T}\cdot_{\mathbb{C}}(\Pi_{m-1})_{S,T}\bigr)\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}\bigl((\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}}\eta_m(U)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}}r_T
&&\left(\because\ r_T\ \text{の置き方}\right)\\
&=\delta_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(S,U)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_m)_{S,U}
&=\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}x_m\bigr)_{S,U}
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\sum_{T\in\mathcal{P}_M}(\Pi_{m-1})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(x_m)_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}\delta_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_T
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_U
&&\left(\because\ \text{主張の}\ x\ \text{に}\ U\text{、和の変数に}\ T\text{、}v_T:=r_T\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=(\Pi_{m-1})_{S,U}\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ r_T\ \text{の置き方で}\ T:=U\right)\\
&=\chi_{m-1}(S,U)\cdot_{\mathbb{C}}\eta_m(U)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\chi_m(S,U)
&&\left(\because\ (\star_2)\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について命題が示された。",
      ]),
      paragraph([
        "本題の後半。",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " について、",
        math(String.raw`\mathrm{C}_M(S,U)`),
        " が「",
        math(String.raw`S=\emptyset`),
        " かつ ",
        math(String.raw`U=\emptyset`),
        "」と同値であることを示す。",
        math(String.raw`\mathrm{C}_M(S,U)`),
        " が成り立つなら、すべての ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " で ",
        math(String.raw`t\notin S`),
        " かつ ",
        math(String.raw`t\notin\emptyset`),
        " なので ",
        math(String.raw`S=\emptyset`),
        " であり（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）、",
        math(String.raw`U=S=\emptyset`),
        " である。逆に ",
        math(String.raw`S=U=\emptyset`),
        " なら、",
        math(String.raw`S=U`),
        " であり、",
        math(String.raw`t\in S`),
        " を満たす ",
        math(String.raw`t`),
        " は無いので、",
        math(String.raw`\mathrm{C}_M(S,U)`),
        " が成り立つ。",
        math(String.raw`S=\emptyset`),
        " かつ ",
        math(String.raw`U=\emptyset`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_M)_{S,U}
&=\chi_M(S,U)
&&\left(\because\ \text{前半の命題で}\ m:=M\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathrm{C}_M(S,U)\ \text{が成り立つので}\ \chi_M\ \text{の置き方}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{\emptyset,S}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \emptyset=S\ \text{と}\ \emptyset=U\ \text{なので}\ \delta\ \text{の定義（二回）。}\blkref{def_kronecker_delta}\right)\\
&=(E_{\emptyset,\emptyset})_{S,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S\neq\emptyset`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_M)_{S,U}
&=\chi_M(S,U)
&&\left(\because\ \text{前半の命題で}\ m:=M\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathrm{C}_M(S,U)\ \text{が成り立たないので}\ \chi_M\ \text{の置き方}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{\emptyset,S}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \emptyset\neq S\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=(E_{\emptyset,\emptyset})_{S,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S=\emptyset`),
        " かつ ",
        math(String.raw`U\neq\emptyset`),
        " なら次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Pi_M)_{S,U}
&=\chi_M(S,U)
&&\left(\because\ \text{前半の命題で}\ m:=M\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathrm{C}_M(S,U)\ \text{が成り立たないので}\ \chi_M\ \text{の置き方}\right)\\
&=\delta_{\emptyset,S}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{\emptyset,S}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \emptyset\neq U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=(E_{\emptyset,\emptyset})_{S,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        "三つの場合はすべての ",
        math(String.raw`S,U\in\mathcal{P}_M`),
        " を尽くすので、",
        math(String.raw`\Pi_M`),
        " と ",
        math(String.raw`E_{\emptyset,\emptyset}`),
        " の成分はすべて等しく、行列として等しい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`\Pi_M=\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,i=1}^{M}x_i`),
        " なので、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit",
    kind: "claim",
    title: { text: "部分集合の元の番号の生成作用素の行列を番号順に掛けた積を、空集合の位置の行列単位に左から掛けると、その部分集合の行の行列単位になること" },
    labels: ["claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`S\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_t\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（",
        ref("def_creation_operator_matrix"),
        "）とし、",
        math(String.raw`y_t\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、",
        math(String.raw`t\in S`),
        " なら ",
        math(String.raw`y_t:=c_t`),
        "、",
        math(String.raw`t\notin S`),
        " なら ",
        math(String.raw`y_t:=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（単位行列。",
        ref("def_matrices_indexed_by_finite_set"),
        "）と定める。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " は ℂ-代数である（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "。",
        math(String.raw`\mathcal{P}_M`),
        " が有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）。その中の ",
        math(String.raw`y_1,\dots,y_M`),
        " の番号順の積（",
        ref("def_ordered_product_in_algebra"),
        "）と、行列単位 ",
        math(String.raw`E_{\emptyset,\emptyset},\ E_{S,\emptyset}`),
        "（",
        ref("def_matrix_unit"),
        "）について、行列の積 ",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\Bigl(\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,t=1}^{M}y_t\Bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{\emptyset,\emptyset}=E_{S,\emptyset}.`),
    ],
    proof: [
      paragraph([
        "記号の準備。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について、",
        math(String.raw`\Pi_m\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、番号順の積の定義（",
        ref("def_ordered_product_in_algebra"),
        "）の ",
        math(String.raw`\Pi_m`),
        " に ",
        math(String.raw`A:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "、",
        math(String.raw`n:=M`),
        "、族 ",
        math(String.raw`y_1,\dots,y_M`),
        " を当てたものとする。すなわち ",
        math(String.raw`\Pi_0=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "、",
        math(String.raw`\Pi_m=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}y_m`),
        "（",
        math(String.raw`1\le m\le M`),
        "）であり、",
        math(String.raw`\Pi_M=\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,t=1}^{M}y_t`),
        " である。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " と ",
        math(String.raw`R\in\mathcal{P}_M`),
        " について、次の集合を置く。",
      ]),
      displayMath(String.raw`R^{\langle m\rangle}:=\{\,t\in\{1,\dots,M\}\ :\ t\in R\ \text{であるか、または}\ t\in S\ \text{かつ}\ t\le m\,\}.`),
      paragraph([
        math(String.raw`R^{\langle m\rangle}\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`R^{\langle m\rangle}\in\mathcal{P}_M`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。記号 ",
        math(String.raw`R^{\langle m\rangle}`),
        " は ",
        math(String.raw`S`),
        " を書かないが、",
        math(String.raw`S`),
        " ごとに別の集合である。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`m\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`R\in\mathcal{P}_M`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge m+1`),
        " を満たすとする。このとき ",
        math(String.raw`m\notin R`),
        " であり、",
        math(String.raw`R\cup\{m\}\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`R\cup\{m\}\in\mathcal{P}_M`),
        " である。次を示す。",
      ]),
      displayMath(String.raw`c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}=E_{R\cup\{m\},\emptyset}\qquad(\star).`),
      paragraph([
        math(String.raw`X,U\in\mathcal{P}_M`),
        " を固定し、",
        math(String.raw`(X,U)`),
        " 成分を比べる。左から生成作用素の行列を掛けた行列の成分の主張（",
        ref("claim_entry_of_creation_operator_matrix_times_matrix"),
        "）を ",
        math(String.raw`i:=m`),
        "、",
        math(String.raw`A:=E_{R,\emptyset}`),
        "、主張の ",
        math(String.raw`S`),
        " に ",
        math(String.raw`X`),
        " を当てて使う。",
        math(String.raw`m\in X`),
        " のときは、その主張の ",
        math(String.raw`S'`),
        " に当たる集合を ",
        math(String.raw`X':=\{\,t\in\{1,\dots,M\}: t\in X\ \text{かつ}\ t\neq m\,\}`),
        " と書く。",
      ]),
      list([
        [
          math(String.raw`m\notin X`),
          " のとき。",
          math(String.raw`m\in R\cup\{m\}`),
          " と ",
          math(String.raw`m\notin X`),
          " から ",
          math(String.raw`R\cup\{m\}\neq X`),
          " である。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)_{X,U}
&=0_{\mathbb{C}}
&&\left(\because\ m\notin X\ \text{なので左から掛けた成分の主張。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{R\cup\{m\},X}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ R\cup\{m\}\neq X\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{R\cup\{m\},\emptyset}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`m\in X`),
          " かつ ",
          math(String.raw`X'=R`),
          " のとき。まず ",
          math(String.raw`X=R\cup\{m\}`),
          " を示す。",
          math(String.raw`t\in\{1,\dots,M\}`),
          " が ",
          math(String.raw`t\neq m`),
          " なら、",
          math(String.raw`t\in X`),
          " と ",
          math(String.raw`t\in X'`),
          " と ",
          math(String.raw`t\in R`),
          " と ",
          math(String.raw`t\in R\cup\{m\}`),
          " は同値である。",
          math(String.raw`t=m`),
          " なら、",
          math(String.raw`m\in X`),
          " かつ ",
          math(String.raw`m\in R\cup\{m\}`),
          " である。したがって ",
          math(String.raw`X=R\cup\{m\}`),
          " である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。また ",
          math(String.raw`R`),
          " のすべての元 ",
          math(String.raw`t`),
          " は ",
          math(String.raw`t\ge m+1>m`),
          " を満たすので、",
          math(String.raw`N_m(R)=0`),
          " である（",
          ref("claim_count_below_index_vanishes_without_smaller_elements"),
          " を ",
          math(String.raw`i:=m`),
          "、",
          math(String.raw`T:=R`),
          " に当てる）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)_{X,U}
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{X',U}
&&\left(\because\ m\in X\ \text{なので左から掛けた成分の主張。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=\varsigma(N_m(R))\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{R,U}
&&\left(\because\ X'=R\right)\\
&=\varsigma(0)\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{R,U}
&&\left(\because\ N_m(R)=0\text{。}\blkref{claim_count_below_index_vanishes_without_smaller_elements}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{R,U}
&&\left(\because\ \varsigma(0)\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=\bigl(E_{R,\emptyset}\bigr)_{R,U}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{R,R}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{R\cup\{m\},X}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ R\cup\{m\}=X\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{R\cup\{m\},\emptyset}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`m\in X`),
          " かつ ",
          math(String.raw`X'\neq R`),
          " のとき。まず ",
          math(String.raw`X\neq R\cup\{m\}`),
          " を示す。",
          math(String.raw`X=R\cup\{m\}`),
          " と仮定すると、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in X'`),
          " は「",
          math(String.raw`t\in R\cup\{m\}`),
          " かつ ",
          math(String.raw`t\neq m`),
          "」と同値であり、それは「",
          math(String.raw`t\in R`),
          " かつ ",
          math(String.raw`t\neq m`),
          "」と同値であり、",
          math(String.raw`m\notin R`),
          " なのでそれは ",
          math(String.raw`t\in R`),
          " と同値である。すると ",
          math(String.raw`X'=R`),
          " となり（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）、",
          math(String.raw`X'\neq R`),
          " に反する。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)_{X,U}
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}\bigl(E_{R,\emptyset}\bigr)_{X',U}
&&\left(\because\ m\in X\ \text{なので左から掛けた成分の主張。}\blkref{claim_entry_of_creation_operator_matrix_times_matrix}\right)\\
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}\bigl(\delta_{R,X'}\cdot_{\mathbb{C}}\delta_{\emptyset,U}\bigr)
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}\bigr)
&&\left(\because\ R\neq X'\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\varsigma(N_m(X'))\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\delta_{R\cup\{m\},X}\cdot_{\mathbb{C}}\delta_{\emptyset,U}
&&\left(\because\ R\cup\{m\}\neq X\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{R\cup\{m\},\emptyset}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        "三つの場合はすべての ",
        math(String.raw`X,U\in\mathcal{P}_M`),
        " を尽くすので、両辺の成分はすべて等しく、行列として等しい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。これで（",
        math(String.raw`\star`),
        "）が示された。",
      ]),
      paragraph([
        "本題の前半。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " についての帰納法で、命題「",
        math(String.raw`R\in\mathcal{P}_M`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge m+1`),
        " を満たすなら ",
        math(String.raw`\Pi_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}=E_{R^{\langle m\rangle},\emptyset}`),
        "」を示す。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき。",
        math(String.raw`t\le 0`),
        " を満たす ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " は無いので、",
        math(String.raw`t\in R^{\langle 0\rangle}`),
        " は ",
        math(String.raw`t\in R`),
        " と同値であり、",
        math(String.raw`R^{\langle 0\rangle}=R`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Pi_0\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&=1_{\mathrm{Mat}_{\mathcal{P}_M}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&&\left(\because\ \Pi_0\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=E_{R,\emptyset}
&&\left(\because\ \text{単位行列を左から掛けても変わらない。}\blkref{claim_identity_matrix_is_left_unit_of_matrix_product}\right)\\
&=E_{R^{\langle 0\rangle},\emptyset}
&&\left(\because\ R=R^{\langle 0\rangle}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`m-1`),
        " について命題が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`R\in\mathcal{P}_M`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge m+1`),
        " を満たすとする。",
        math(String.raw`m\in S`),
        " か ",
        math(String.raw`m\notin S`),
        " かで分ける。",
      ]),
      list([
        [
          math(String.raw`m\in S`),
          " のとき。",
          math(String.raw`R\cup\{m\}`),
          " のすべての元 ",
          math(String.raw`t`),
          " は ",
          math(String.raw`t\ge m=(m-1)+1`),
          " を満たすので、帰納法の仮定を ",
          math(String.raw`R\cup\{m\}`),
          " に当てられる。また ",
          math(String.raw`(R\cup\{m\})^{\langle m-1\rangle}=R^{\langle m\rangle}`),
          " である。実際、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in(R\cup\{m\})^{\langle m-1\rangle}`),
          " は「",
          math(String.raw`t\in R`),
          "、または ",
          math(String.raw`t=m`),
          "、または ",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m-1`),
          "」と同値であり、",
          math(String.raw`m\in S`),
          " なので「",
          math(String.raw`t=m`),
          "、または ",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m-1`),
          "」は「",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m`),
          "」と同値である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\Pi_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&=\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}y_m\bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(y_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)
&&\left(\because\ \text{行列の積の結合法則。}\blkref{claim_matrix_product_is_associative}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(c_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)
&&\left(\because\ m\in S\ \text{なので}\ y_m\ \text{の定め方}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R\cup\{m\},\emptyset}
&&\left(\because\ (\star)\right)\\
&=E_{(R\cup\{m\})^{\langle m-1\rangle},\emptyset}
&&\left(\because\ \text{帰納法の仮定を}\ R\cup\{m\}\ \text{に当てる}\right)\\
&=E_{R^{\langle m\rangle},\emptyset}
&&\left(\because\ (R\cup\{m\})^{\langle m-1\rangle}=R^{\langle m\rangle}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`m\notin S`),
          " のとき。",
          math(String.raw`R`),
          " のすべての元 ",
          math(String.raw`t`),
          " は ",
          math(String.raw`t\ge m+1>m=(m-1)+1`),
          " を満たすので、帰納法の仮定を ",
          math(String.raw`R`),
          " に当てられる。また ",
          math(String.raw`R^{\langle m-1\rangle}=R^{\langle m\rangle}`),
          " である。実際、",
          math(String.raw`m\notin S`),
          " なので、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について「",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m`),
          "」は「",
          math(String.raw`t\in S`),
          " かつ ",
          math(String.raw`t\le m-1`),
          "」と同値である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\Pi_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&=\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}y_m\bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(y_m\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)
&&\left(\because\ \text{行列の積の結合法則。}\blkref{claim_matrix_product_is_associative}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(1_{\mathrm{Mat}_{\mathcal{P}_M}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}\bigr)
&&\left(\because\ m\notin S\ \text{なので}\ y_m\ \text{の定め方}\right)\\
&=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{R,\emptyset}
&&\left(\because\ \text{単位行列を左から掛けても変わらない。}\blkref{claim_identity_matrix_is_left_unit_of_matrix_product}\right)\\
&=E_{R^{\langle m-1\rangle},\emptyset}
&&\left(\because\ \text{帰納法の仮定を}\ R\ \text{に当てる}\right)\\
&=E_{R^{\langle m\rangle},\emptyset}
&&\left(\because\ R^{\langle m-1\rangle}=R^{\langle m\rangle}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について命題が示された。",
      ]),
      paragraph([
        "本題の後半。",
        math(String.raw`\emptyset\in\mathcal{P}_M`),
        " は元を持たないので、",
        math(String.raw`m:=M`),
        "、",
        math(String.raw`R:=\emptyset`),
        " に前半の命題を当てられる。また ",
        math(String.raw`\emptyset^{\langle M\rangle}=S`),
        " である。実際、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\in\emptyset`),
        " は成り立たず ",
        math(String.raw`t\le M`),
        " は成り立つので、",
        math(String.raw`t\in\emptyset^{\langle M\rangle}`),
        " は ",
        math(String.raw`t\in S`),
        " と同値である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,t=1}^{M}y_t\Bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{\emptyset,\emptyset}
&=\Pi_M\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}E_{\emptyset,\emptyset}
&&\left(\because\ \Pi_M\ \text{の置き方}\right)\\
&=E_{\emptyset^{\langle M\rangle},\emptyset}
&&\left(\because\ \text{前半の命題で}\ m:=M\text{、}R:=\emptyset\right)\\
&=E_{S,\emptyset}
&&\left(\because\ \emptyset^{\langle M\rangle}=S\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices",
    kind: "claim",
    title: { text: "空集合の位置の行列単位に、部分集合の元の番号の消滅作用素の行列を番号の逆順に右から掛けると、その部分集合の列の行列単位になること" },
    labels: ["claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`T\in\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）とする。",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`c_t^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"),
        "）とし、",
        math(String.raw`z_t\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、",
        math(String.raw`t\in T`),
        " なら ",
        math(String.raw`z_t:=c_t^{\mathsf T}`),
        "、",
        math(String.raw`t\notin T`),
        " なら ",
        math(String.raw`z_t:=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（単位行列。",
        ref("def_matrices_indexed_by_finite_set"),
        "）と定める。",
        math(String.raw`k\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`M+1-k\in\{1,\dots,M\}`),
        " なので、番号を逆順に並べ直した族 ",
        math(String.raw`\check{z}_k:=z_{M+1-k}`),
        " が定まる。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " は ℂ-代数である（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "。",
        math(String.raw`\mathcal{P}_M`),
        " が有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）。その中の ",
        math(String.raw`\check{z}_1,\dots,\check{z}_M`),
        " の番号順の積（",
        ref("def_ordered_product_in_algebra"),
        "。",
        math(String.raw`z_M,\dots,z_1`),
        " をこの順に掛けた積である）と、行列単位 ",
        math(String.raw`E_{\emptyset,\emptyset},\ E_{\emptyset,T}`),
        "（",
        ref("def_matrix_unit"),
        "）について、行列の積 ",
        math(String.raw`\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）で次が成り立つ。",
      ]),
      displayMath(String.raw`E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Bigl(\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,k=1}^{M}\check{z}_k\Bigr)=E_{\emptyset,T}.`),
    ],
    proof: [
      paragraph([
        "記号の準備。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について、",
        math(String.raw`\Pi_m\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を、番号順の積の定義（",
        ref("def_ordered_product_in_algebra"),
        "）の ",
        math(String.raw`\Pi_m`),
        " に ",
        math(String.raw`A:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "、",
        math(String.raw`n:=M`),
        "、族 ",
        math(String.raw`\check{z}_1,\dots,\check{z}_M`),
        " を当てたものとする。すなわち ",
        math(String.raw`\Pi_0=1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "、",
        math(String.raw`\Pi_m=\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\check{z}_m`),
        "（",
        math(String.raw`1\le m\le M`),
        "）であり、",
        math(String.raw`\Pi_M=\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,k=1}^{M}\check{z}_k`),
        " である。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について、次の集合を置く。",
      ]),
      displayMath(String.raw`T^{\langle m\rangle}:=\{\,t\in\{1,\dots,M\}\ :\ t\in T\ \text{かつ}\ t\ge M+1-m\,\}.`),
      paragraph([
        math(String.raw`T^{\langle m\rangle}\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`T^{\langle m\rangle}\in\mathcal{P}_M`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      paragraph([
        "準備。和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）である。",
        math(String.raw`s\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`R\in\mathcal{P}_M`),
        " のすべての元 ",
        math(String.raw`t`),
        " が ",
        math(String.raw`t\ge s+1`),
        " を満たすとする。このとき ",
        math(String.raw`s\notin R`),
        " であり、",
        math(String.raw`R\cup\{s\}\subseteq\{1,\dots,M\}`),
        " なので ",
        math(String.raw`R\cup\{s\}\in\mathcal{P}_M`),
        " である。また ",
        math(String.raw`R`),
        " のすべての元 ",
        math(String.raw`t`),
        " は ",
        math(String.raw`t\ge s+1>s`),
        " を満たすので、",
        math(String.raw`N_s(R)=0`),
        " である（",
        ref("claim_count_below_index_vanishes_without_smaller_elements"),
        " を ",
        math(String.raw`i:=s`),
        "、",
        math(String.raw`T:=R`),
        " に当てる）。次を示す。",
      ]),
      displayMath(String.raw`E_{\emptyset,R}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}=E_{\emptyset,R\cup\{s\}}\qquad(\star).`),
      paragraph([
        math(String.raw`X,U\in\mathcal{P}_M`),
        " を固定し、",
        math(String.raw`(X,U)`),
        " 成分を比べる。",
        math(String.raw`Y\in\mathcal{P}_M`),
        " について ",
        math(String.raw`r_Y:=\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,Y}\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`Y\in\mathcal{P}_M`),
        " について、和の項を次のように書き直す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(E_{\emptyset,R})_{X,Y}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_s^{\mathsf T})_{Y,U}
&=(E_{\emptyset,R})_{X,Y}\cdot_{\mathbb{C}}(c_s^{\mathsf T})_{Y,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\bigl(\delta_{\emptyset,X}\cdot_{\mathbb{C}}\delta_{R,Y}\bigr)\cdot_{\mathbb{C}}(c_s^{\mathsf T})_{Y,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=\bigl(\delta_{\emptyset,X}\cdot_{\mathbb{C}}\delta_{R,Y}\bigr)\cdot_{\mathbb{C}}(c_s)_{U,Y}
&&\left(\because\ c_s^{\mathsf T}\ \text{の定義。}\blkref{def_annihilation_operator_matrix}\right)\\
&=\bigl(\delta_{R,Y}\cdot_{\mathbb{C}}\delta_{\emptyset,X}\bigr)\cdot_{\mathbb{C}}(c_s)_{U,Y}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{R,Y}\cdot_{\mathbb{C}}\bigl(\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,Y}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{R,Y}\cdot_{\mathbb{C}}r_Y
&&\left(\because\ r_Y\ \text{の置き方}\right)\\
&=\delta_{R,Y}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_Y
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(X,U)`),
        " 成分を開く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(E_{\emptyset,R}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}\bigr)_{X,U}
&=\sum_{Y\in\mathcal{P}_M}(E_{\emptyset,R})_{X,Y}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_s^{\mathsf T})_{Y,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{Y\in\mathcal{P}_M}\delta_{R,Y}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_Y
&&\left(\because\ \text{各}\ Y\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_R
&&\left(\because\ \text{主張の}\ x\ \text{に}\ R\text{、和の変数に}\ Y\text{、}v_Y:=r_Y\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,R}
&&\left(\because\ r_Y\ \text{の置き方で}\ Y:=R\right).
\end{aligned}\qquad(\dagger)`),
      paragraph([
        math(String.raw`U=R\cup\{s\}`),
        " か ",
        math(String.raw`U\neq R\cup\{s\}`),
        " かで分ける。",
      ]),
      list([
        [
          math(String.raw`U=R\cup\{s\}`),
          " のとき。",
          math(String.raw`s\notin R`),
          " なので、",
          math(String.raw`c_s`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）の条件「",
          math(String.raw`s\notin R`),
          " かつ ",
          math(String.raw`U=R\cup\{s\}`),
          "」が成り立つ。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(E_{\emptyset,R}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}\bigr)_{X,U}
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,R}
&&\left(\because\ (\dagger)\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}\varsigma(N_s(R))
&&\left(\because\ \text{条件が成り立つので}\ c_s\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}\varsigma(0)
&&\left(\because\ N_s(R)=0\text{。}\blkref{claim_count_below_index_vanishes_without_smaller_elements}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \varsigma(0)\ \text{の定義。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}\delta_{R\cup\{s\},U}
&&\left(\because\ R\cup\{s\}=U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{\emptyset,R\cup\{s\}}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`U\neq R\cup\{s\}`),
          " のとき。",
          math(String.raw`c_s`),
          " の定義（",
          ref("def_creation_operator_matrix"),
          "）の条件「",
          math(String.raw`s\notin R`),
          " かつ ",
          math(String.raw`U=R\cup\{s\}`),
          "」は成り立たない。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(E_{\emptyset,R}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}\bigr)_{X,U}
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}(c_s)_{U,R}
&&\left(\because\ (\dagger)\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ c_s\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=\delta_{\emptyset,X}\cdot_{\mathbb{C}}\delta_{R\cup\{s\},U}
&&\left(\because\ R\cup\{s\}\neq U\ \text{なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right)\\
&=\bigl(E_{\emptyset,R\cup\{s\}}\bigr)_{X,U}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([
        "二つの場合はすべての ",
        math(String.raw`X,U\in\mathcal{P}_M`),
        " を尽くすので、両辺の成分はすべて等しく、行列として等しい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。これで（",
        math(String.raw`\star`),
        "）が示された。",
      ]),
      paragraph([
        "本題の前半。",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " についての帰納法で、",
        math(String.raw`E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_m=E_{\emptyset,T^{\langle m\rangle}}`),
        " を示す。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき。",
        math(String.raw`t\ge M+1`),
        " を満たす ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " は無いので、",
        math(String.raw`T^{\langle 0\rangle}`),
        " は元を持たず、",
        math(String.raw`T^{\langle 0\rangle}=\emptyset`),
        " である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_0
&=E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}
&&\left(\because\ \Pi_0\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=E_{\emptyset,\emptyset}
&&\left(\because\ \text{単位行列を右から掛けても変わらない。}\blkref{claim_identity_matrix_is_right_unit_of_matrix_product}\right)\\
&=E_{\emptyset,T^{\langle 0\rangle}}
&&\left(\because\ \emptyset=T^{\langle 0\rangle}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\in\{1,\dots,M\}`),
        " とし、",
        math(String.raw`E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_{m-1}=E_{\emptyset,T^{\langle m-1\rangle}}`),
        " を仮定する（帰納法の仮定）。",
        math(String.raw`s:=M+1-m\in\{1,\dots,M\}`),
        " と置く。",
        math(String.raw`\check{z}_m=z_s`),
        " である（",
        math(String.raw`\check{z}_m`),
        " の定め方）。",
        math(String.raw`T^{\langle m-1\rangle}`),
        " のすべての元 ",
        math(String.raw`t`),
        " は ",
        math(String.raw`t\ge M+1-(m-1)=s+1`),
        " を満たす。",
        math(String.raw`s\in T`),
        " か ",
        math(String.raw`s\notin T`),
        " かで分ける。",
      ]),
      list([
        [
          math(String.raw`s\in T`),
          " のとき。",
          math(String.raw`T^{\langle m-1\rangle}\cup\{s\}=T^{\langle m\rangle}`),
          " である。実際、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について、",
          math(String.raw`t\in T^{\langle m\rangle}`),
          " は「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\ge s`),
          "」と同値であり、それは「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\ge s+1`),
          "、または ",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t=s`),
          "」と同値であり、",
          math(String.raw`s\in T`),
          " なのでそれは「",
          math(String.raw`t\in T^{\langle m-1\rangle}`),
          "、または ",
          math(String.raw`t=s`),
          "」と同値である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_m
&=E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\check{z}_m\bigr)
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\bigl(E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_{m-1}\bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\check{z}_m
&&\left(\because\ \text{行列の積の結合法則。}\blkref{claim_matrix_product_is_associative}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\check{z}_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_s^{\mathsf T}
&&\left(\because\ \check{z}_m=z_s\ \text{で、}s\in T\ \text{なので}\ z_s\ \text{の定め方}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}\cup\{s\}}
&&\left(\because\ R:=T^{\langle m-1\rangle}\ \text{で}\ (\star)\right)\\
&=E_{\emptyset,T^{\langle m\rangle}}
&&\left(\because\ T^{\langle m-1\rangle}\cup\{s\}=T^{\langle m\rangle}\right).
\end{aligned}`),
      list([
        [
          math(String.raw`s\notin T`),
          " のとき。",
          math(String.raw`T^{\langle m-1\rangle}=T^{\langle m\rangle}`),
          " である。実際、",
          math(String.raw`s\notin T`),
          " なので、",
          math(String.raw`t\in\{1,\dots,M\}`),
          " について「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\ge s`),
          "」は「",
          math(String.raw`t\in T`),
          " かつ ",
          math(String.raw`t\ge s+1`),
          "」と同値である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_m
&=E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\bigl(\Pi_{m-1}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\check{z}_m\bigr)
&&\left(\because\ \Pi_m\ \text{の定義。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\bigl(E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_{m-1}\bigr)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\check{z}_m
&&\left(\because\ \text{行列の積の結合法則。}\blkref{claim_matrix_product_is_associative}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\check{z}_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}
&&\left(\because\ \check{z}_m=z_s\ \text{で、}s\notin T\ \text{なので}\ z_s\ \text{の定め方}\right)\\
&=E_{\emptyset,T^{\langle m-1\rangle}}
&&\left(\because\ \text{単位行列を右から掛けても変わらない。}\blkref{claim_identity_matrix_is_right_unit_of_matrix_product}\right)\\
&=E_{\emptyset,T^{\langle m\rangle}}
&&\left(\because\ T^{\langle m-1\rangle}=T^{\langle m\rangle}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,M\}`),
        " について ",
        math(String.raw`E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_m=E_{\emptyset,T^{\langle m\rangle}}`),
        " が示された。",
      ]),
      paragraph([
        "本題の後半。",
        math(String.raw`T^{\langle M\rangle}=T`),
        " である。実際、",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\ge 1=M+1-M`),
        " は成り立つので、",
        math(String.raw`t\in T^{\langle M\rangle}`),
        " は ",
        math(String.raw`t\in T`),
        " と同値である（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Bigl(\prod_{\mathrm{Mat}_{\mathcal{P}_M},\,k=1}^{M}\check{z}_k\Bigr)
&=E_{\emptyset,\emptyset}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\Pi_M
&&\left(\because\ \Pi_M\ \text{の置き方}\right)\\
&=E_{\emptyset,T^{\langle M\rangle}}
&&\left(\because\ \text{前半の命題で}\ m:=M\right)\\
&=E_{\emptyset,T}
&&\left(\because\ T^{\langle M\rangle}=T\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_homomorphism_to_matrix_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "クリフォード代数から行列環への準同型" },
    labels: [],
  },
  {
    id: "isomorphism_claim_square_of_creation_operator_matrix_is_zero",
    kind: "claim",
    title: { text: "生成作用素の行列の自分自身との積は零行列である" },
    labels: ["claim_square_of_creation_operator_matrix_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`i\in\{1,\dots,M\}`), " について ", math(String.raw`c_i\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を生成作用素の行列（", ref("def_creation_operator_matrix"), "）とする。", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の中で次が成り立つ（演算と零行列は ", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
      displayMath(String.raw`c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i=0_{\mathrm{Mat}_{\mathcal{P}_M}}`),
    ],
    proof: [
      paragraph([
        "行列の等しさの定義（", ref("def_matrices_indexed_by_finite_set"), "）により、すべての ", math(String.raw`S,U\in\mathcal{P}_M`),
        " について両辺の ", math(String.raw`(S,U)`), " 成分が等しいことを示せばよい。", math(String.raw`S,U\in\mathcal{P}_M`), " を固定し、",
        math(String.raw`i\in U`), " か ", math(String.raw`i\notin U`), " かで場合を分ける。", math(String.raw`i\in U`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=0_{\mathbb{C}}
&&\left(\because\ A:=c_i\text{、主張の}\ j\ \text{に}\ i\ \text{を当て、}i\in U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\notin U`), " のとき。", math(String.raw`i\in U\cup\{i\}`), " なので、", math(String.raw`c_i`), " の定義（",
        ref("def_creation_operator_matrix"), "）で列の添字を ", math(String.raw`U\cup\{i\}`), " としたときの条件「", math(String.raw`i\notin U\cup\{i\}`),
        " かつ ", math(String.raw`S=(U\cup\{i\})\cup\{i\}`), "」は成り立たない。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{S,U}
&=(c_i)_{S,U\cup\{i\}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ A:=c_i\text{、主張の}\ j\ \text{に}\ i\ \text{を当て、}i\notin U\text{。}\blkref{claim_entry_of_matrix_times_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立たないので}\ c_i\ \text{の定義。}\blkref{def_creation_operator_matrix}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "二つの場合は ", math(String.raw`i\in U`), " と ", math(String.raw`i\notin U`), " を尽くすので、両辺の成分はすべて等しく、主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_square_of_annihilation_operator_matrix_is_zero",
    kind: "claim",
    title: { text: "消滅作用素の行列の自分自身との積は零行列である" },
    labels: ["claim_square_of_annihilation_operator_matrix_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`i\in\{1,\dots,M\}`), " について ",
        math(String.raw`c_i^{\mathsf T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"),
        "）とする。", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " の中で次が成り立つ（演算と零行列は ",
        ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
      displayMath(String.raw`c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}=0_{\mathrm{Mat}_{\mathcal{P}_M}}`),
    ],
    proof: [
      paragraph([
        "和はすべて ℂ-線型空間 ", math(String.raw`\mathbb{C}^{\mathrm{vec}}`), "（", ref("def_complex_numbers_as_complex_vector_space"), "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"), "）の中の有限集合 ", math(String.raw`\mathcal{P}_M`), "（有限集合であることは ",
        ref("claim_binary_numbering_is_numbering_of_power_set"), "）の上の和（", ref("def_sum_over_finite_set"), "）である。", math(String.raw`S,U\in\mathcal{P}_M`),
        " を固定する。準備として、各 ", math(String.raw`T\in\mathcal{P}_M`), " について和の項を書き直す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i^{\mathsf T})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_i^{\mathsf T})_{T,U}
&=(c_i^{\mathsf T})_{S,T}\cdot_{\mathbb{C}}(c_i^{\mathsf T})_{T,U}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(c_i)_{T,S}\cdot_{\mathbb{C}}(c_i)_{U,T}
&&\left(\because\ c_i^{\mathsf T}\ \text{の定義を二か所に適用。}\blkref{def_annihilation_operator_matrix}\right)\\
&=(c_i)_{U,T}\cdot_{\mathbb{C}}(c_i)_{T,S}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(c_i)_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_i)_{T,S}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["これを使って ", math(String.raw`(S,U)`), " 成分を計算する。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(c_i^{\mathsf T}\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i^{\mathsf T}\bigr)_{S,U}
&=\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_i^{\mathsf T})_{T,U}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{T\in\mathcal{P}_M}(c_i)_{U,T}\cdot_{\mathbb{C}^{\mathrm{vec}}}(c_i)_{T,S}
&&\left(\because\ \text{各}\ T\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\bigl(c_i\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}c_i\bigr)_{U,S}
&&\left(\because\ \cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{U,S}
&&\left(\because\ \text{生成作用素の行列の自分自身との積。}\blkref{claim_square_of_creation_operator_matrix_is_zero}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl(0_{\mathrm{Mat}_{\mathcal{P}_M}}\bigr)_{S,U}
&&\left(\because\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`S,U\in\mathcal{P}_M`), " は任意なので、行列の等しさの定義（", ref("def_matrices_indexed_by_finite_set"), "）により主張が示された。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_matrix_valued_map_on_split_quadratic_space",
    kind: "definition",
    title: { text: "分裂した二次空間から行列環への写像" },
    labels: ["def_matrix_valued_map_on_split_quadratic_space"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`W`), "、", math(String.raw`w`), "、", math(String.raw`w_k`), "、", math(String.raw`V=W\oplus W^{*}`),
        " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとする。", math(String.raw`k\in\{1,\dots,M\}`), " について、",
        math(String.raw`\beta^{w}_k:W\to\mathbb{C}`), " を基底 ", math(String.raw`w`), " についての第 ", math(String.raw`k`), " 座標の写像（",
        ref("claim_coordinate_map_is_linear_form"), "）、", math(String.raw`c_k`), " を生成作用素の行列（", ref("def_creation_operator_matrix"), "）、",
        math(String.raw`c_k^{\mathsf T}`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"), "）とする。",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " は ℂ-代数であり（", ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）、",
        "以下の二つの和は ℂ-線型空間 ", math(String.raw`U_{\mathrm{vec}}(\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C}))`), "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の線型結合（", ref("def_linear_combination"), "）である。",
      ]),
      paragraph([
        math(String.raw`V`), " の各元は、", math(String.raw`x\in W`), " と ", math(String.raw`g\in W^{*}`), " の順序対 ", math(String.raw`(x,g)`),
        " としてただ一通りに書ける（", ref("def_direct_sum_of_two_vector_spaces"), "）。写像 ", math(String.raw`\varphi:V\to\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " を次で定める。",
      ]),
      displayMath(String.raw`\varphi\bigl((x,g)\bigr):=\left(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_{\mathrm{Mat}_{\mathcal{P}_M}}c_k\right)+_{\mathrm{Mat}_{\mathcal{P}_M}}\left(\sum_{k=1}^{M}g(w_k)\ast_{\mathrm{Mat}_{\mathcal{P}_M}}c_k^{\mathsf T}\right)`),
      paragraph([
        math(String.raw`\beta^{w}_k(x)\in\mathbb{C}`), " であり、", math(String.raw`g`), " は ", math(String.raw`W`), " 上の線型形式なので ",
        math(String.raw`g(w_k)\in\mathbb{C}`), " である（", ref("def_dual_space"), "）。したがって右辺は ", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元を一つ定める。双対基底 ", math(String.raw`f`), " との区別のため、", math(String.raw`W^{*}`), " の元には文字 ", math(String.raw`g`), " を使う。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_matrix_valued_map_on_split_quadratic_space_is_linear_map",
    kind: "claim",
    title: { text: "分裂した二次空間から行列環への写像は線型写像である" },
    labels: ["claim_matrix_valued_map_on_split_quadratic_space_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`V`), " と ", math(String.raw`\varphi`), " を ", ref("def_matrix_valued_map_on_split_quadratic_space"), " のものとする。",
        math(String.raw`\varphi`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C}))`), "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"), "）への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "式を短くするため ", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置き、その演算を ", math(String.raw`+_B,\ \ast_B,\ 0_B`),
        " と書く（", ref("def_matrices_indexed_by_finite_set"), "）。証明の中だけで、", math(String.raw`y\in W`), " と ", math(String.raw`h\in W^{*}`),
        " について ", math(String.raw`C(y):=\sum_{k=1}^{M}\beta^{w}_k(y)\ast_B c_k`), "、", math(String.raw`D(h):=\sum_{k=1}^{M}h(w_k)\ast_B c_k^{\mathsf T}`),
        " と置く。", math(String.raw`\varphi((y,h))=C(y)+_B D(h)`), " である（", ref("def_matrix_valued_map_on_split_quadratic_space"), "）。",
        math(String.raw`(x,g),(x',g')\in V`), " と ", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。",
      ]),
      paragraph([
        "準備。", math(String.raw`\beta^{w}_k`), " は線型形式なので（", ref("claim_coordinate_map_is_linear_form"), "、", ref("def_linear_form"), "）、各 ",
        math(String.raw`k`), " で ", math(String.raw`\beta^{w}_k(x+_W x')\ast_B c_k=(\beta^{w}_k(x)+_{\mathbb{C}}\beta^{w}_k(x'))\ast_B c_k`), " と ",
        math(String.raw`\beta^{w}_k(\lambda\cdot_W x)\ast_B c_k=(\lambda\cdot_{\mathbb{C}}\beta^{w}_k(x))\ast_B c_k`), " が成り立つ。",
        math(String.raw`W^{*}`), " の演算の定義（", ref("def_dual_space"), "、", ref("claim_pointwise_sum_of_linear_forms_is_linear_form"), "、",
        ref("claim_pointwise_scalar_multiple_of_linear_form_is_linear_form"), "）により、各 ", math(String.raw`k`), " で ",
        math(String.raw`(g+_{W^{*}}g')(w_k)=g(w_k)+_{\mathbb{C}}g'(w_k)`), " と ", math(String.raw`(\lambda\cdot_{W^{*}}g)(w_k)=\lambda\cdot_{\mathbb{C}}g(w_k)`),
        " が成り立つ。これらを使って四つの等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
C(x+_W x')
&=\sum_{k=1}^{M}\bigl(\beta^{w}_k(x)+_{\mathbb{C}}\beta^{w}_k(x')\bigr)\ast_B c_k
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=C(x)+_B C(x')
&&\left(\because\ \blkref{claim_sum_of_linear_combinations_of_same_family}\right),\\[4pt]
D(g+_{W^{*}}g')
&=\sum_{k=1}^{M}\bigl(g(w_k)+_{\mathbb{C}}g'(w_k)\bigr)\ast_B c_k^{\mathsf T}
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=D(g)+_B D(g')
&&\left(\because\ \blkref{claim_sum_of_linear_combinations_of_same_family}\right),\\[4pt]
C(\lambda\cdot_W x)
&=\sum_{k=1}^{M}\bigl(\lambda\cdot_{\mathbb{C}}\beta^{w}_k(x)\bigr)\ast_B c_k
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\lambda\ast_B C(x)
&&\left(\because\ \blkref{claim_scalar_multiple_of_linear_combination}\right),\\[4pt]
D(\lambda\cdot_{W^{*}}g)
&=\sum_{k=1}^{M}\bigl(\lambda\cdot_{\mathbb{C}}g(w_k)\bigr)\ast_B c_k^{\mathsf T}
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\lambda\ast_B D(g)
&&\left(\because\ \blkref{claim_scalar_multiple_of_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "加法を保つこと。以下の加法の結合法則・交換法則は ", math(String.raw`U_{\mathrm{vec}}(B)`), " のもの（", ref("def_complex_vector_space"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\varphi\bigl((x,g)+_V(x',g')\bigr)\\
&\quad=\varphi\bigl((x+_W x',\ g+_{W^{*}}g')\bigr)
&&\left(\because\ \text{直和の加法の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&\quad=C(x+_W x')+_B D(g+_{W^{*}}g')
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&\quad=\bigl(C(x)+_B C(x')\bigr)+_B D(g+_{W^{*}}g')
&&\left(\because\ \text{準備の一つ目の等式}\right)\\
&\quad=\bigl(C(x)+_B C(x')\bigr)+_B\bigl(D(g)+_B D(g')\bigr)
&&\left(\because\ \text{準備の二つ目の等式}\right)\\
&\quad=C(x)+_B\Bigl(C(x')+_B\bigl(D(g)+_B D(g')\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&\quad=C(x)+_B\Bigl(\bigl(C(x')+_B D(g)\bigr)+_B D(g')\Bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&\quad=C(x)+_B\Bigl(\bigl(D(g)+_B C(x')\bigr)+_B D(g')\Bigr)
&&\left(\because\ \text{加法の交換法則}\right)\\
&\quad=C(x)+_B\Bigl(D(g)+_B\bigl(C(x')+_B D(g')\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&\quad=\bigl(C(x)+_B D(g)\bigr)+_B\bigl(C(x')+_B D(g')\bigr)
&&\left(\because\ \text{加法の結合法則}\right)\\
&\quad=\varphi\bigl((x,g)\bigr)+_B\varphi\bigl((x',g')\bigr)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\ \text{を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\varphi\bigl(\lambda\cdot_V(x,g)\bigr)
&=\varphi\bigl((\lambda\cdot_W x,\ \lambda\cdot_{W^{*}}g)\bigr)
&&\left(\because\ \text{直和のスカラー倍の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=C(\lambda\cdot_W x)+_B D(\lambda\cdot_{W^{*}}g)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&=\bigl(\lambda\ast_B C(x)\bigr)+_B D(\lambda\cdot_{W^{*}}g)
&&\left(\because\ \text{準備の三つ目の等式}\right)\\
&=\bigl(\lambda\ast_B C(x)\bigr)+_B\bigl(\lambda\ast_B D(g)\bigr)
&&\left(\because\ \text{準備の四つ目の等式}\right)\\
&=\lambda\ast_B\bigl(C(x)+_B D(g)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\ast_B\varphi\bigl((x,g)\bigr)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right).
\end{aligned}`),
      paragraph(["二つの条件が満たされたので、", math(String.raw`\varphi`), " は線型写像である（", ref("def_linear_map"), "）。"]),
    ],
  },
  {
    id: "isomorphism_claim_square_of_matrix_valued_map_on_split_quadratic_space",
    kind: "claim",
    title: { text: "分裂した二次空間から行列環への写像の値の自分自身との積は、二次形式の値の単位行列倍である" },
    labels: ["claim_square_of_matrix_valued_map_on_split_quadratic_space"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`q`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`\varphi`), " を ",
        ref("def_matrix_valued_map_on_split_quadratic_space"), " のものとする。すべての ", math(String.raw`v\in V`), " について、",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " の中で次が成り立つ（演算と単位行列は ", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
      displayMath(String.raw`\varphi(v)\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}\varphi(v)=q(v)\ast_{\mathrm{Mat}_{\mathcal{P}_M}}1_{\mathrm{Mat}_{\mathcal{P}_M}}`),
    ],
    proof: [
      paragraph([
        "式を短くするため ", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置き、その演算と単位元を ",
        math(String.raw`+_B,\ \cdot_B,\ \ast_B,\ 0_B,\ 1_B`), " と書く。", math(String.raw`B`), " は ℂ-代数である（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）。", math(String.raw`v=(x,g)`), "（", math(String.raw`x\in W`), "、",
        math(String.raw`g\in W^{*}`), "）と書き、", math(String.raw`k\in\{1,\dots,M\}`), " について ", math(String.raw`\lambda_k:=\beta^{w}_k(x)\in\mathbb{C}`), "、",
        math(String.raw`\mu_k:=g(w_k)\in\mathbb{C}`), "、", math(String.raw`C:=\sum_{k=1}^{M}\lambda_k\ast_B c_k`), "、", math(String.raw`D:=\sum_{k=1}^{M}\mu_k\ast_B c_k^{\mathsf T}`),
        " と置く。", math(String.raw`\varphi(v)=C+_B D`), " である（", ref("def_matrix_valued_map_on_split_quadratic_space"), "）。",
        math(String.raw`\delta_{k,l}\in\mathbb{C}`), " は ", math(String.raw`\{1,\dots,M\}`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
      ]),
      paragraph([
        "準備の一つ目。", math(String.raw`C\cdot_B C=0_B`), " である。", ref("claim_square_of_linear_combination_of_anticommuting_square_zero_elements_is_zero"),
        " を ", math(String.raw`A:=B`), "、", math(String.raw`n:=M`), "、", math(String.raw`p_k:=c_k`), " に当てる。一つ目の仮定は ",
        ref("claim_square_of_creation_operator_matrix_is_zero"), "、二つ目の仮定は ", ref("claim_creation_operator_matrices_anticommute"), " である。",
      ]),
      paragraph([
        "準備の二つ目。", math(String.raw`D\cdot_B D=0_B`), " である。同じ主張を ", math(String.raw`p_k:=c_k^{\mathsf T}`), "、係数 ", math(String.raw`\mu_k`),
        " に当てる。一つ目の仮定は ", ref("claim_square_of_annihilation_operator_matrix_is_zero"), "、二つ目の仮定は ",
        ref("claim_annihilation_operator_matrices_anticommute"), " である。",
      ]),
      paragraph([
        "準備の三つ目。各 ", math(String.raw`k\in\{1,\dots,M\}`), " について ", math(String.raw`c_k\cdot_B D+_B D\cdot_B c_k=\mu_k\ast_B 1_B`), " である。",
        "まず、各 ", math(String.raw`l\in\{1,\dots,M\}`), " について項の二つの等式を示す。以下のスカラー倍の結合法則は ", math(String.raw`U_{\mathrm{vec}}(B)`),
        " のもの（", ref("def_complex_vector_space"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
c_l^{\mathsf T}\cdot_B c_k+_B c_k\cdot_B c_l^{\mathsf T}
&=c_k\cdot_B c_l^{\mathsf T}+_B c_l^{\mathsf T}\cdot_B c_k
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{k,l}\ast_B 1_B
&&\left(\because\ i:=k\text{、}j:=l\text{。}\blkref{claim_creation_and_annihilation_operator_matrices_anticommute}\right),\\[4pt]
\mu_l\ast_B(\delta_{k,l}\ast_B 1_B)
&=(\mu_l\cdot_{\mathbb{C}}\delta_{k,l})\ast_B 1_B
&&\left(\because\ \text{スカラー倍の結合法則}\right)\\
&=(\delta_{k,l}\cdot_{\mathbb{C}}\mu_l)\ast_B 1_B
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{k,l}\ast_B(\mu_l\ast_B 1_B)
&&\left(\because\ \text{スカラー倍の結合法則}\right)\\
&=\delta_{l,k}\ast_B(\mu_l\ast_B 1_B)
&&\left(\because\ k=l\ \text{と}\ l=k\ \text{は同値なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
c_k\cdot_B D+_B D\cdot_B c_k
&=D\cdot_B c_k+_B c_k\cdot_B D
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=\sum_{l=1}^{M}\mu_l\ast_B\bigl(c_l^{\mathsf T}\cdot_B c_k+_B c_k\cdot_B c_l^{\mathsf T}\bigr)
&&\left(\because\ A:=B\text{、}n:=M\text{、}r_l:=c_l^{\mathsf T}\text{、反交換子をとる元に}\ c_k\ \text{を当てる。}\blkref{claim_anticommutator_with_linear_combination_in_algebra}\right)\\
&=\sum_{l=1}^{M}\mu_l\ast_B\bigl(\delta_{k,l}\ast_B 1_B\bigr)
&&\left(\because\ \text{各項で項の一つ目の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{l=1}^{M}\delta_{l,k}\ast_B\bigl(\mu_l\ast_B 1_B\bigr)
&&\left(\because\ \text{各項で項の二つ目の等式。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\mu_k\ast_B 1_B
&&\left(\because\ b_l:=\mu_l\ast_B 1_B\text{、}j:=k\text{。}\blkref{claim_family_member_is_kronecker_delta_linear_combination}\right).
\end{aligned}`),
      paragraph(["準備の四つ目。", math(String.raw`C\cdot_B D+_B D\cdot_B C=\sum_{k=1}^{M}\lambda_k\ast_B(\mu_k\ast_B 1_B)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
C\cdot_B D+_B D\cdot_B C
&=\sum_{k=1}^{M}\lambda_k\ast_B\bigl(c_k\cdot_B D+_B D\cdot_B c_k\bigr)
&&\left(\because\ A:=B\text{、}n:=M\text{、}r_k:=c_k\text{、}\mu:=\lambda\text{、反交換子をとる元に}\ D\ \text{を当てる。}\blkref{claim_anticommutator_with_linear_combination_in_algebra}\right)\\
&=\sum_{k=1}^{M}\lambda_k\ast_B\bigl(\mu_k\ast_B 1_B\bigr)
&&\left(\because\ \text{各項で準備の三つ目。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right).
\end{aligned}`),
      paragraph([
        "準備の五つ目。", math(String.raw`g(x)\ast_B 1_B=\sum_{k=1}^{M}\lambda_k\ast_B(\mu_k\ast_B 1_B)`), " である。写像 ", math(String.raw`h:W\to B`), " を ",
        math(String.raw`h(y):=g(y)\ast_B 1_B`), " で定める。", math(String.raw`h`), " は ", math(String.raw`W`), " から ", math(String.raw`U_{\mathrm{vec}}(B)`),
        " への線型写像である。実際、", math(String.raw`y,y'\in W`), "、", math(String.raw`\rho\in\mathbb{C}`), " について次が成り立つ（", math(String.raw`g`),
        " は線型形式。", ref("def_dual_space"), "、", ref("def_linear_form"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
h(y+_W y')
&=g(y+_W y')\ast_B 1_B
&&\left(\because\ h\ \text{の定義}\right)\\
&=\bigl(g(y)+_{\mathbb{C}}g(y')\bigr)\ast_B 1_B
&&\left(\because\ g\ \text{は加法を保つ。}\blkref{def_linear_form}\right)\\
&=g(y)\ast_B 1_B+_B g(y')\ast_B 1_B
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=h(y)+_B h(y')
&&\left(\because\ h\ \text{の定義を二か所に適用}\right),\\[4pt]
h(\rho\cdot_W y)
&=g(\rho\cdot_W y)\ast_B 1_B
&&\left(\because\ h\ \text{の定義}\right)\\
&=\bigl(\rho\cdot_{\mathbb{C}}g(y)\bigr)\ast_B 1_B
&&\left(\because\ g\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=\rho\ast_B\bigl(g(y)\ast_B 1_B\bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\rho\ast_B h(y)
&&\left(\because\ h\ \text{の定義}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
g(x)\ast_B 1_B
&=h(x)
&&\left(\because\ h\ \text{の定義}\right)\\
&=h\left(\sum_{k=1}^{M}\beta^{w}_k(x)\cdot_W w_k\right)
&&\left(\because\ \text{座標の写像の定め方。}\blkref{claim_coordinate_map_is_linear_form}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_B h(w_k)
&&\left(\because\ \text{線型写像に}\ h\ \text{を当てる。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{k=1}^{M}\lambda_k\ast_B\bigl(\mu_k\ast_B 1_B\bigr)
&&\left(\because\ \lambda_k\text{、}\mu_k\text{、}h\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "本題。以下の分配法則・加法の結合法則・交換法則・単位元は ", math(String.raw`U_{\mathrm{ring}}(B)`), " のもの（", ref("def_unital_ring"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(v)\cdot_B\varphi(v)
&=(C+_B D)\cdot_B(C+_B D)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&=C\cdot_B(C+_B D)+_B D\cdot_B(C+_B D)
&&\left(\because\ \text{分配法則（左の因子の和）}\right)\\
&=\bigl(C\cdot_B C+_B C\cdot_B D\bigr)+_B\bigl(D\cdot_B C+_B D\cdot_B D\bigr)
&&\left(\because\ \text{分配法則（右の因子の和）を二か所に適用}\right)\\
&=\bigl(0_B+_B C\cdot_B D\bigr)+_B\bigl(D\cdot_B C+_B D\cdot_B D\bigr)
&&\left(\because\ \text{準備の一つ目}\right)\\
&=\bigl(0_B+_B C\cdot_B D\bigr)+_B\bigl(D\cdot_B C+_B 0_B\bigr)
&&\left(\because\ \text{準備の二つ目}\right)\\
&=\bigl(C\cdot_B D+_B 0_B\bigr)+_B\bigl(D\cdot_B C+_B 0_B\bigr)
&&\left(\because\ \text{加法の交換法則}\right)\\
&=C\cdot_B D+_B D\cdot_B C
&&\left(\because\ \text{加法の単位元を二か所に適用}\right)\\
&=\sum_{k=1}^{M}\lambda_k\ast_B\bigl(\mu_k\ast_B 1_B\bigr)
&&\left(\because\ \text{準備の四つ目}\right)\\
&=g(x)\ast_B 1_B
&&\left(\because\ \text{準備の五つ目}\right)\\
&=q_W\bigl((x,g)\bigr)\ast_B 1_B
&&\left(\because\ \blkref{def_split_quadratic_form}\right)\\
&=q(v)\ast_B 1_B
&&\left(\because\ q:=q_W\text{、}v=(x,g)\text{。}\blkref{def_clifford_algebra_of_split_quadratic_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra",
    kind: "claim",
    title: { text: "クリフォード代数から行列環への準同型の存在と一意性" },
    labels: ["claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`), " を ",
        ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`\varphi`), " を ", ref("def_matrix_valued_map_on_split_quadratic_space"),
        " のものとする。", math(String.raw`\mathrm{Cl}(V,q)`), " から ℂ-代数 ", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), "（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）で、",
        math(String.raw`V`), " から ", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " への写像として ", math(String.raw`\Phi\circ\gamma=\varphi`),
        " を満たすもの ", math(String.raw`\Phi`), " が、ただ一つ存在する。",
      ]),
    ],
    proof: [
      paragraph([
        "クリフォード代数の普遍性（", ref("claim_universal_property_of_clifford_algebra"), "）の代数に ", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        "、線型写像に ", math(String.raw`\varphi`), " を当てる。", math(String.raw`A:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。", math(String.raw`A`), " は ℂ-代数であり（", ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "）、", math(String.raw`\varphi`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像であり（",
        ref("claim_matrix_valued_map_on_split_quadratic_space_is_linear_map"), "）、すべての ", math(String.raw`v\in V`), " について ",
        math(String.raw`\varphi(v)\cdot_A\varphi(v)=q(v)\ast_A 1_A`), " が成り立つ（", ref("claim_square_of_matrix_valued_map_on_split_quadratic_space"),
        "）。普遍性の仮定がすべて満たされたので、", math(String.raw`\Phi\circ\gamma=\varphi`), " を満たす ℂ-代数の準同型 ", math(String.raw`\Phi`),
        " がただ一つ存在する。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_from_clifford_algebra_to_matrix_algebra",
    kind: "definition",
    title: { text: "クリフォード代数から行列環への準同型" },
    labels: ["def_homomorphism_from_clifford_algebra_to_matrix_algebra"],
    statement: [
      paragraph([
        ref("claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra"), " のただ一つの ℂ-代数の準同型を ",
        math(String.raw`\Phi:\mathrm{Cl}(V,q)\to\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と書く。", math(String.raw`\Phi`), " は ",
        math(String.raw`\Phi\circ\gamma=\varphi`), " を満たす。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix",
    kind: "claim",
    title: { text: "行列環への準同型は、生成作用素にあたる元を生成作用素の行列へ移す" },
    labels: ["claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), " の準同型、", math(String.raw`a^{\dagger}_i`), " を ",
        ref("def_creation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`c_i`), " を生成作用素の行列（", ref("def_creation_operator_matrix"),
        "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi\bigl(a^{\dagger}_i\bigr)=c_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。準備として、各 ", math(String.raw`k\in\{1,\dots,M\}`), " について項の二つの等式を示す。",
        math(String.raw`z_W`), " は ", ref("claim_zero_map_is_linear_form"), " の零写像である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\beta^{w}_k(w_i)\ast_B c_k
&=\delta_{k,i}\ast_B c_k
&&\left(\because\ \text{座標の写像の族は双対基底。}\blkref{claim_coordinate_maps_form_dual_basis}\right),\\[4pt]
0_{W^{*}}(w_k)\ast_B c_k^{\mathsf T}
&=z_W(w_k)\ast_B c_k^{\mathsf T}
&&\left(\because\ 0_{W^{*}}:=z_W\text{。}\blkref{def_dual_space}\right)\\
&=0_{\mathbb{C}}\ast_B c_k^{\mathsf T}
&&\left(\because\ z_W\ \text{の定義。}\blkref{claim_zero_map_is_linear_form}\right)\\
&=0_B
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Phi\bigl(a^{\dagger}_i\bigr)
&=\Phi\Bigl(\gamma\bigl(\mathrm{in}_1(w_i)\bigr)\Bigr)
&&\left(\because\ \blkref{def_creation_generator_of_split_clifford_algebra}\right)\\
&=\varphi\bigl(\mathrm{in}_1(w_i)\bigr)
&&\left(\because\ \Phi\circ\gamma=\varphi\text{。}\blkref{def_homomorphism_from_clifford_algebra_to_matrix_algebra}\right)\\
&=\varphi\bigl((w_i,\ 0_{W^{*}})\bigr)
&&\left(\because\ \blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&=\left(\sum_{k=1}^{M}\beta^{w}_k(w_i)\ast_B c_k\right)+_B\left(\sum_{k=1}^{M}0_{W^{*}}(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&=\left(\sum_{k=1}^{M}\delta_{k,i}\ast_B c_k\right)+_B\left(\sum_{k=1}^{M}0_{W^{*}}(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \text{各項で準備の一つ目。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=c_i+_B\left(\sum_{k=1}^{M}0_{W^{*}}(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ b_k:=c_k\text{、}j:=i\text{。}\blkref{claim_family_member_is_kronecker_delta_linear_combination}\right)\\
&=c_i+_B 0_B
&&\left(\because\ \text{各項で準備の二つ目。}\blkref{claim_linear_combination_of_zero_terms_is_zero}\right)\\
&=c_i
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix",
    kind: "claim",
    title: { text: "行列環への準同型は、消滅作用素にあたる元を消滅作用素の行列へ移す" },
    labels: ["claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), " の準同型、", math(String.raw`a_i`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`c_i^{\mathsf T}`), " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi(a_i)=c_i^{\mathsf T}`),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。準備として、各 ", math(String.raw`k\in\{1,\dots,M\}`), " について項の二つの等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\beta^{w}_k(0_W)\ast_B c_k
&=0_{\mathbb{C}}\ast_B c_k
&&\left(\because\ \beta^{w}_k\ \text{は線型形式。}\blkref{claim_coordinate_map_is_linear_form}\text{、}\blkref{claim_linear_form_sends_zero_vector_to_zero}\right)\\
&=0_B
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right),\\[4pt]
f_i(w_k)\ast_B c_k^{\mathsf T}
&=\delta_{i,k}\ast_B c_k^{\mathsf T}
&&\left(\because\ f\ \text{は}\ w\ \text{の双対基底。}\blkref{def_dual_basis}\right)\\
&=\delta_{k,i}\ast_B c_k^{\mathsf T}
&&\left(\because\ i=k\ \text{と}\ k=i\ \text{は同値なので}\ \delta\ \text{の定義。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Phi(a_i)
&=\Phi\Bigl(\gamma\bigl(\mathrm{in}_2(f_i)\bigr)\Bigr)
&&\left(\because\ \blkref{def_annihilation_generator_of_split_clifford_algebra}\right)\\
&=\varphi\bigl(\mathrm{in}_2(f_i)\bigr)
&&\left(\because\ \Phi\circ\gamma=\varphi\text{。}\blkref{def_homomorphism_from_clifford_algebra_to_matrix_algebra}\right)\\
&=\varphi\bigl((0_W,\ f_i)\bigr)
&&\left(\because\ \blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&=\left(\sum_{k=1}^{M}\beta^{w}_k(0_W)\ast_B c_k\right)+_B\left(\sum_{k=1}^{M}f_i(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \blkref{def_matrix_valued_map_on_split_quadratic_space}\right)\\
&=0_B+_B\left(\sum_{k=1}^{M}f_i(w_k)\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \text{各項で準備の一つ目。}\blkref{claim_linear_combination_of_zero_terms_is_zero}\right)\\
&=0_B+_B\left(\sum_{k=1}^{M}\delta_{k,i}\ast_B c_k^{\mathsf T}\right)
&&\left(\because\ \text{各項で準備の二つ目。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=0_B+_B c_i^{\mathsf T}
&&\left(\because\ b_k:=c_k^{\mathsf T}\text{、}j:=i\text{。}\blkref{claim_family_member_is_kronecker_delta_linear_combination}\right)\\
&=c_i^{\mathsf T}+_B 0_B
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=c_i^{\mathsf T}
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_local_identities_in_clifford_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "クリフォード代数の中の局所的な等式" },
    labels: [],
  },
  {
    id: "isomorphism_definition_selected_creation_factor",
    kind: "definition",
    title: { text: "部分集合に入る番号では生成作用素にあたる元、入らない番号では単位元をとる因子" },
    labels: ["def_selected_creation_factor"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_t`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`S\in\mathcal{P}_M`), "（",
        ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`t\in\{1,\dots,M\}`), " について、", math(String.raw`\mathrm{Cl}(V,q)`),
        " の元 ", math(String.raw`y^{S}_t`), " を次で定める（", math(String.raw`t\in S`), " の真偽は ", ref("def_power_set_of_first_m_positive_integers"),
        " により一つに決まる）。",
      ]),
      displayMath(String.raw`y^{S}_t:=\begin{cases}a^{\dagger}_t & (t\in S),\\ 1_{\mathrm{Cl}(V,q)} & (t\notin S).\end{cases}`),
    ],
  },
  {
    id: "isomorphism_definition_ordered_product_of_selected_creation_generators",
    kind: "definition",
    title: { text: "部分集合の元の番号の生成作用素にあたる元の番号順の積" },
    labels: ["def_ordered_product_of_selected_creation_generators"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`S\in\mathcal{P}_M`), "（",
        ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`y^{S}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ",
        ref("def_selected_creation_factor"), " のものとする。", math(String.raw`\mathrm{Cl}(V,q)`), " の元 ", math(String.raw`a^{\dagger}_S`), " を、ℂ-代数 ", math(String.raw`\mathrm{Cl}(V,q)`),
        "（", ref("def_clifford_algebra"), "）の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。",
      ]),
      displayMath(String.raw`a^{\dagger}_S:=\prod_{\mathrm{Cl}(V,q),\,t=1}^{M}y^{S}_t`),
      paragraph([
        "記号 ", math(String.raw`a^{\dagger}_S`), " の下付きは ", math(String.raw`\mathcal{P}_M`), " の元であり、", math(String.raw`\{1,\dots,M\}`),
        " の元を下付きにした ", math(String.raw`a^{\dagger}_i`), " とは別の記号である。", math(String.raw`a^{\dagger}_S`), " は、",
        math(String.raw`S`), " の元 ", math(String.raw`t`), " の ", math(String.raw`a^{\dagger}_t`), " を、", math(String.raw`t`),
        " の小さい順に左から右へ掛けた積である。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_selected_annihilation_factor",
    kind: "definition",
    title: { text: "部分集合に入る番号では消滅作用素にあたる元、入らない番号では単位元をとる因子" },
    labels: ["def_selected_annihilation_factor"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_t`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`T\in\mathcal{P}_M`), "（",
        ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`t\in\{1,\dots,M\}`), " について、", math(String.raw`\mathrm{Cl}(V,q)`),
        " の元 ", math(String.raw`z^{T}_t`), " を次で定める（", math(String.raw`t\in T`), " の真偽は ", ref("def_power_set_of_first_m_positive_integers"),
        " により一つに決まる）。",
      ]),
      displayMath(String.raw`z^{T}_t:=\begin{cases}a_t & (t\in T),\\ 1_{\mathrm{Cl}(V,q)} & (t\notin T).\end{cases}`),
    ],
  },
  {
    id: "isomorphism_definition_reverse_numbered_selected_annihilation_factor",
    kind: "definition",
    title: { text: "消滅の因子を番号の逆順に並べ直した族" },
    labels: ["def_reverse_numbered_selected_annihilation_factor"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`T\in\mathcal{P}_M`), "（",
        ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`z^{T}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ",
        ref("def_selected_annihilation_factor"), " のものとする。", math(String.raw`k\in\{1,\dots,M\}`), " について ", math(String.raw`M+1-k\in\{1,\dots,M\}`),
        " なので、", math(String.raw`\mathrm{Cl}(V,q)`), " の元 ", math(String.raw`\check{z}^{T}_k`), " を次で定める。",
      ]),
      displayMath(String.raw`\check{z}^{T}_k:=z^{T}_{M+1-k}`),
    ],
  },
  {
    id: "isomorphism_definition_reverse_ordered_product_of_selected_annihilation_generators",
    kind: "definition",
    title: { text: "部分集合の元の番号の消滅作用素にあたる元の、番号の逆順の積" },
    labels: ["def_reverse_ordered_product_of_selected_annihilation_generators"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`T\in\mathcal{P}_M`), "（",
        ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`\check{z}^{T}_k`), "（", math(String.raw`k\in\{1,\dots,M\}`), "）を ",
        ref("def_reverse_numbered_selected_annihilation_factor"), " のものとする。", math(String.raw`\mathrm{Cl}(V,q)`), " の元 ", math(String.raw`a_T`), " を、ℂ-代数 ",
        math(String.raw`\mathrm{Cl}(V,q)`), "（", ref("def_clifford_algebra"), "）の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。",
      ]),
      displayMath(String.raw`a_T:=\prod_{\mathrm{Cl}(V,q),\,k=1}^{M}\check{z}^{T}_k`),
      paragraph([
        math(String.raw`a_T`), " は ", math(String.raw`z^{T}_M,\dots,z^{T}_1`), "（", ref("def_selected_annihilation_factor"), "）をこの順に左から右へ掛けた積、すなわち ", math(String.raw`T`),
        " の元 ", math(String.raw`t`), " の ", math(String.raw`a_t`), " を ", math(String.raw`t`), " の大きい順に左から右へ掛けた積である。記号 ",
        math(String.raw`a_T`), " の下付きは ", math(String.raw`\mathcal{P}_M`), " の元であり、", math(String.raw`a_i`), "（", math(String.raw`i\in\{1,\dots,M\}`),
        "）とは別の記号である。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_vacuum_factor_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "番号ごとの真空の因子" },
    labels: ["def_vacuum_factor_of_split_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とする。", math(String.raw`i\in\{1,\dots,M\}`), " について、", math(String.raw`\mathrm{Cl}(V,q)`),
        " の元 ", math(String.raw`x_i`), " を次で定める。",
      ]),
      displayMath(String.raw`x_i:=a_i\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_i`),
    ],
  },
  {
    id: "isomorphism_definition_vacuum_element_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "真空への射影にあたる元" },
    labels: ["def_vacuum_element_of_split_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`x_i`), "（",
        math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。", math(String.raw`\mathrm{Cl}(V,q)`), " の元 ",
        math(String.raw`P`), " を、ℂ-代数 ", math(String.raw`\mathrm{Cl}(V,q)`), "（", ref("def_clifford_algebra"), "）の中の番号順の積（",
        ref("def_ordered_product_in_algebra"), "）で次のように定める。",
      ]),
      displayMath(String.raw`P:=\prod_{\mathrm{Cl}(V,q),\,i=1}^{M}x_i`),
      paragraph([math(String.raw`P`), " を真空への射影にあたる元と呼ぶ。"]),
    ],
  },
  {
    id: "isomorphism_claim_annihilation_generator_commutes_with_other_number_pair",
    kind: "claim",
    title: { text: "消滅作用素にあたる元は、番号の違う消滅と生成の積と交換する" },
    labels: ["claim_annihilation_generator_commutes_with_other_number_pair"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_j`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とする。", math(String.raw`i\neq j`), " であるすべての ",
        math(String.raw`i,j\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a_i\cdot_{\mathrm{Cl}(V,q)}\bigl(a_j\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_j\bigr)=\bigl(a_j\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_j\bigr)\cdot_{\mathrm{Cl}(V,q)}a_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置く。", math(String.raw`-1_{\mathbb{C}}`), " は ", ref("claim_anticommuting_elements_swap_with_sign"),
        " のものである。準備として、", math(String.raw`i\neq j`), " なので ", math(String.raw`\delta_{i,j}=0_{\mathbb{C}}`), "（", ref("def_kronecker_delta"), "）であり、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A a^{\dagger}_j+_A a^{\dagger}_j\cdot_A a_i
&=\delta_{i,j}\ast_A 1_A
&&\left(\because\ \blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ i\neq j\text{。}\blkref{def_kronecker_delta}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A\bigl(a_j\cdot_A a^{\dagger}_j\bigr)
&=\bigl(a_i\cdot_A a_j\bigr)\cdot_A a^{\dagger}_j
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(a_j\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_j
&&\left(\because\ \text{二元に}\ a_i\text{、}a_j\ \text{をこの順に当てる。}\blkref{claim_annihilation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((a_j\cdot_A a_i)\cdot_A a^{\dagger}_j\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(a_j\cdot_A(a_i\cdot_A a^{\dagger}_j)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(a_j\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_j\cdot_A a_i)\bigr)\Bigr)
&&\left(\because\ \text{二元に}\ a_i\text{、}a^{\dagger}_j\ \text{をこの順に当てる。準備。}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a_i)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a_i)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の計算}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=a_j\cdot_A(a^{\dagger}_j\cdot_A a_i)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(a_j\cdot_A a^{\dagger}_j\bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_commutes_with_other_number_pair",
    kind: "claim",
    title: { text: "生成作用素にあたる元は、番号の違う消滅と生成の積と交換する" },
    labels: ["claim_creation_generator_commutes_with_other_number_pair"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_j`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とする。", math(String.raw`i\neq j`), " であるすべての ",
        math(String.raw`i,j\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a^{\dagger}_i\cdot_{\mathrm{Cl}(V,q)}\bigl(a_j\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_j\bigr)=\bigl(a_j\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_j\bigr)\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置く。", math(String.raw`-1_{\mathbb{C}}`), " は ", ref("claim_anticommuting_elements_swap_with_sign"),
        " のものである。準備として、", math(String.raw`j\neq i`), " なので ", math(String.raw`\delta_{j,i}=0_{\mathbb{C}}`), "（", ref("def_kronecker_delta"), "）であり、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A a_j+_A a_j\cdot_A a^{\dagger}_i
&=a_j\cdot_A a^{\dagger}_i+_A a^{\dagger}_i\cdot_A a_j
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\delta_{j,i}\ast_A 1_A
&&\left(\because\ \blkref{claim_annihilation_and_creation_generators_anticommute}\ \text{の}\ i,j\ \text{に}\ j,i\ \text{を当てる}\right)\\
&=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ j\neq i\text{。}\blkref{def_kronecker_delta}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\bigl(a_j\cdot_A a^{\dagger}_j\bigr)
&=\bigl(a^{\dagger}_i\cdot_A a_j\bigr)\cdot_A a^{\dagger}_j
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(a_j\cdot_A a^{\dagger}_i)\bigr)\cdot_A a^{\dagger}_j
&&\left(\because\ \text{二元に}\ a^{\dagger}_i\text{、}a_j\ \text{をこの順に当てる。準備。}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((a_j\cdot_A a^{\dagger}_i)\cdot_A a^{\dagger}_j\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(a_j\cdot_A(a^{\dagger}_i\cdot_A a^{\dagger}_j)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(a_j\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)\bigr)\Bigr)
&&\left(\because\ \text{二元に}\ a^{\dagger}_i\text{、}a^{\dagger}_j\ \text{をこの順に当てる。}\blkref{claim_creation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(a_j\cdot_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の計算}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=a_j\cdot_A(a^{\dagger}_j\cdot_A a^{\dagger}_i)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(a_j\cdot_A a^{\dagger}_j\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_annihilation_generator_times_vacuum_element_is_zero",
    kind: "claim",
    title: { text: "消滅作用素にあたる元を真空への射影にあたる元に左から掛けると零になる" },
    labels: ["claim_annihilation_generator_times_vacuum_element_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`P`), " を真空への射影にあたる元（",
        ref("def_vacuum_element_of_split_clifford_algebra"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a_i\cdot_{\mathrm{Cl}(V,q)}P=0_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`x_j`), "（", math(String.raw`j\in\{1,\dots,M\}`), "）を ",
        ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。", math(String.raw`L:=\prod_{A,\,j=1}^{i-1}x_j`), "、",
        math(String.raw`R:=\prod_{A,\,r=1}^{M-i}x_{i+r}`), " と置く（", ref("def_ordered_product_in_algebra"), "）。",
      ]),
      paragraph([
        "準備。", math(String.raw`j\in\{1,\dots,i-1\}`), " なら ", math(String.raw`j\neq i`), " なので ", math(String.raw`a_i\cdot_A x_j=x_j\cdot_A a_i`), " である（",
        ref("claim_annihilation_generator_commutes_with_other_number_pair"), "）。したがって ", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"),
        " を ", math(String.raw`u:=a_i`), "、", math(String.raw`n:=i-1`), "、族 ", math(String.raw`x_1,\dots,x_{i-1}`), " に当てて、",
        math(String.raw`a_i\cdot_A L=L\cdot_A a_i`), " が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A P
&=a_i\cdot_A\Bigl(L\cdot_A\bigl(x_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ n:=M\text{、}p:=i\text{。}\blkref{def_vacuum_element_of_split_clifford_algebra}\text{、}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\bigl(a_i\cdot_A L\bigr)\cdot_A\bigl(x_i\cdot_A R\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(L\cdot_A a_i\bigr)\cdot_A\bigl(x_i\cdot_A R\bigr)
&&\left(\because\ \text{準備}\right)\\
&=L\cdot_A\Bigl(a_i\cdot_A\bigl(x_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A x_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A(a_i\cdot_A a^{\dagger}_i)\bigr)\cdot_A R\Bigr)
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=L\cdot_A\Bigl(\bigl((a_i\cdot_A a_i)\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl(0_A\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=L\cdot_A\bigl(0_A\cdot_A R\bigr)
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=L\cdot_A 0_A
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_element_times_creation_generator_is_zero",
    kind: "claim",
    title: { text: "真空への射影にあたる元に生成作用素にあたる元を右から掛けると零になる" },
    labels: ["claim_vacuum_element_times_creation_generator_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`P`), " を真空への射影にあたる元（",
        ref("def_vacuum_element_of_split_clifford_algebra"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`P\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_i=0_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`x_j`), "（", math(String.raw`j\in\{1,\dots,M\}`), "）を ",
        ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。", math(String.raw`L:=\prod_{A,\,j=1}^{i-1}x_j`), "、",
        math(String.raw`R:=\prod_{A,\,r=1}^{M-i}x_{i+r}`), " と置く（", ref("def_ordered_product_in_algebra"), "）。",
      ]),
      paragraph([
        "準備。", math(String.raw`r\in\{1,\dots,M-i\}`), " なら ", math(String.raw`i+r\neq i`), " なので ", math(String.raw`a^{\dagger}_i\cdot_A x_{i+r}=x_{i+r}\cdot_A a^{\dagger}_i`),
        " である（", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`j`), " に ", math(String.raw`i+r`), " を当てる）。したがって ",
        ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=a^{\dagger}_i`), "、", math(String.raw`n:=M-i`),
        "、族 ", math(String.raw`r\mapsto x_{i+r}`), " に当てて、", math(String.raw`a^{\dagger}_i\cdot_A R=R\cdot_A a^{\dagger}_i`), " が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
P\cdot_A a^{\dagger}_i
&=\Bigl(L\cdot_A\bigl(x_i\cdot_A R\bigr)\Bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ n:=M\text{、}p:=i\text{。}\blkref{def_vacuum_element_of_split_clifford_algebra}\text{、}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=L\cdot_A\Bigl(\bigl(x_i\cdot_A R\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(x_i\cdot_A\bigl(R\cdot_A a^{\dagger}_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(x_i\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ \text{準備}\right)\\
&=L\cdot_A\Bigl(\bigl(x_i\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl((a_i\cdot_A a^{\dagger}_i)\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A(a^{\dagger}_i\cdot_A a^{\dagger}_i)\bigr)\cdot_A R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A 0_A\bigr)\cdot_A R\Bigr)
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=L\cdot_A\bigl(0_A\cdot_A R\bigr)
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=L\cdot_A 0_A
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_passes_initial_creation_factors_with_sign",
    kind: "claim",
    title: { text: "生成作用素にあたる元を、番号の小さい側の生成の因子の積の右へ移すと、番号より小さい元の個数の符号が付く" },
    labels: ["claim_creation_generator_passes_initial_creation_factors_with_sign"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`T\in\mathcal{P}_M`), "、",
        math(String.raw`i\in\{1,\dots,M\}`), " とする。", math(String.raw`y^{T}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ",
        ref("def_selected_creation_factor"), " のもの、", math(String.raw`N_{m}(T)`), " を ", ref("def_count_of_subset_elements_below_index"),
        "、", math(String.raw`\varsigma`), " を ", ref("def_sign_of_nonnegative_integer"), " のものとする。このとき、すべての ", math(String.raw`m\in\{0,1,\dots,i-1\}`),
        " について、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した番号順の積（", ref("def_ordered_product_in_algebra"), "）について次が成り立つ（",
        math(String.raw`m+1\le i\le M`), " なので ", math(String.raw`N_{m+1}(T)`), " は定まる）。",
      ]),
      displayMath(String.raw`a^{\dagger}_i\cdot_{\mathrm{Cl}(V,q)}\prod_{\mathrm{Cl}(V,q),\,t=1}^{m}y^{T}_t=\varsigma\bigl(N_{m+1}(T)\bigr)\ast_{\mathrm{Cl}(V,q)}\left(\Bigl(\prod_{\mathrm{Cl}(V,q),\,t=1}^{m}y^{T}_t\Bigr)\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_i\right)`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`y_t:=y^{T}_t`), "、", math(String.raw`N_m:=N_m(T)`), " と置き、", math(String.raw`\Pi_m`), "（",
        math(String.raw`m\in\{0,1,\dots,M\}`), "）を、族 ", math(String.raw`y_1,\dots,y_M`), " について ", ref("def_ordered_product_in_algebra"), " で帰納的に定めた元とする（", math(String.raw`\Pi_0=1_A`), "、",
        math(String.raw`\Pi_m=\Pi_{m-1}\cdot_A y_m`), "）。", ref("claim_partial_product_is_ordered_product_of_restricted_family"), "（", math(String.raw`n:=M`), "）により、", math(String.raw`\Pi_m`),
        " は族を ", math(String.raw`\{1,\dots,m\}`), " に制限した番号順の積 ", math(String.raw`\prod_{A,\,t=1}^{m}y_t`), " に等しい。", math(String.raw`-1_{\mathbb{C}}`), " は ",
        ref("claim_anticommuting_elements_swap_with_sign"), " のものである。主張を ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\Pi_0
&=a^{\dagger}_i\cdot_A 1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_{\mathbb{C}}\ast_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(1_A\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(0)\ast_A\bigl(1_A\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma(N_1)\ast_A\bigl(1_A\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_1)\ast_A\bigl(\Pi_0\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le i-1`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`m\le i-1\le M-1`),
        " なので ", math(String.raw`m+1\in\{2,\dots,M\}`), " であり、", math(String.raw`N_{m+1}`), " は ", ref("def_count_of_subset_elements_below_index"),
        " の二つ目の式で定まる。また ", math(String.raw`m\neq i`), " である。", math(String.raw`m\in T`), " のとき、", math(String.raw`y_m=a^{\dagger}_m`),
        " であり（", ref("def_selected_creation_factor"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\Pi_m
&=a^{\dagger}_i\cdot_A\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}y_m=a^{\dagger}_m\right)\\
&=\bigl(a^{\dagger}_i\cdot_A\Pi_{m-1}\bigr)\cdot_A a^{\dagger}_m
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\varsigma(N_m)\ast_A\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_i\bigr)\Bigr)\cdot_A a^{\dagger}_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_i\bigr)\cdot_A a^{\dagger}_m\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\Pi_{m-1}\cdot_A\bigl(a^{\dagger}_i\cdot_A a^{\dagger}_m\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\Pi_{m-1}\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)\Bigr)
&&\left(\because\ \text{二元に}\ a^{\dagger}_i\text{、}a^{\dagger}_m\ \text{をこの順に当てる。}\blkref{claim_creation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=\varsigma(N_m)\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(\varsigma(N_m)\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_m)\bigr)\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\varsigma(N_m+1)\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(\Pi_{m-1}\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ m\in T\text{。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl((\Pi_{m-1}\cdot_A a^{\dagger}_m)\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(\Pi_m\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}y_m=a^{\dagger}_m\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\notin T`), " のとき、", math(String.raw`y_m=1_A`), " であり（", ref("def_selected_creation_factor"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\Pi_m
&=a^{\dagger}_i\cdot_A\bigl(\Pi_{m-1}\cdot_A 1_A\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}y_m=1_A\right)\\
&=a^{\dagger}_i\cdot_A\Pi_{m-1}
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_m)\ast_A\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(\Pi_{m-1}\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ m\notin T\text{。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl((\Pi_{m-1}\cdot_A 1_A)\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(\Pi_m\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\text{、}y_m=1_A\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_times_ordered_creation_product_without_index",
    kind: "claim",
    title: { text: "番号を含まない部分集合の生成の積に、その番号の生成作用素にあたる元を左から掛けると、番号を足した部分集合の生成の積の符号倍になる" },
    labels: ["claim_creation_generator_times_ordered_creation_product_without_index"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`a^{\dagger}_T`), " を ",
        ref("def_ordered_product_of_selected_creation_generators"), " の元、", math(String.raw`N_i(T)`), " を ", ref("def_count_of_subset_elements_below_index"), "、",
        math(String.raw`\varsigma`), " を ", ref("def_sign_of_nonnegative_integer"), " のものとする。", math(String.raw`T\in\mathcal{P}_M`), "、",
        math(String.raw`i\in\{1,\dots,M\}`), " が ", math(String.raw`i\notin T`), " を満たすとき、", math(String.raw`T\cup\{i\}\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a^{\dagger}_i\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_T=\varsigma\bigl(N_i(T)\bigr)\ast_{\mathrm{Cl}(V,q)}a^{\dagger}_{T\cup\{i\}}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`S:=T\cup\{i\}`), " と置く。", math(String.raw`t\in\{1,\dots,M\}`), " が ", math(String.raw`t\neq i`),
        " なら ", math(String.raw`t\in S`), " と ", math(String.raw`t\in T`), " は同値なので、", math(String.raw`y^{S}_t=y^{T}_t`), " である（",
        ref("def_selected_creation_factor"), "）。また ", math(String.raw`i\notin T`), " なので ", math(String.raw`y^{T}_i=1_A`), "、",
        math(String.raw`i\in S`), " なので ", math(String.raw`y^{S}_i=a^{\dagger}_i`), " である。", math(String.raw`L:=\prod_{A,\,t=1}^{i-1}y^{T}_t`), "、",
        math(String.raw`R:=\prod_{A,\,r=1}^{M-i}y^{T}_{i+r}`), " と置く。", math(String.raw`t\le i-1`), " と ", math(String.raw`i+r\ge i+1`),
        " の番号では二つの族の値が等しいので、族 ", math(String.raw`y^{S}`), " で同じ式を作っても同じ族の番号順の積であり、", math(String.raw`L=\prod_{A,\,t=1}^{i-1}y^{S}_t`),
        "、", math(String.raw`R=\prod_{A,\,r=1}^{M-i}y^{S}_{i+r}`), " である（", ref("def_ordered_product_in_algebra"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A a^{\dagger}_T
&=a^{\dagger}_i\cdot_A\Bigl(L\cdot_A\bigl(y^{T}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ n:=M\text{、}p:=i\text{。}\blkref{def_ordered_product_of_selected_creation_generators}\text{、}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=a^{\dagger}_i\cdot_A\Bigl(L\cdot_A\bigl(1_A\cdot_A R\bigr)\Bigr)
&&\left(\because\ y^{T}_i=1_A\right)\\
&=a^{\dagger}_i\cdot_A\bigl(L\cdot_A R\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\bigl(a^{\dagger}_i\cdot_A L\bigr)\cdot_A R
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(L\cdot_A a^{\dagger}_i\bigr)\Bigr)\cdot_A R
&&\left(\because\ m:=i-1\text{。}\blkref{claim_creation_generator_passes_initial_creation_factors_with_sign}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(\bigl(L\cdot_A a^{\dagger}_i\bigr)\cdot_A R\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(y^{S}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ y^{S}_i=a^{\dagger}_i\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\prod_{A,\,t=1}^{M}y^{S}_t
&&\left(\because\ \text{族}\ y^{S}\ \text{に}\ n:=M\text{、}p:=i\ \text{で当てる。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A a^{\dagger}_{T\cup\{i\}}
&&\left(\because\ S=T\cup\{i\}\text{。}\blkref{def_ordered_product_of_selected_creation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_times_ordered_creation_product_with_index_is_zero",
    kind: "claim",
    title: { text: "番号を含む部分集合の生成の積に、その番号の生成作用素にあたる元を左から掛けると零になる" },
    labels: ["claim_creation_generator_times_ordered_creation_product_with_index_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`a^{\dagger}_T`), " を ",
        ref("def_ordered_product_of_selected_creation_generators"), " の元とする。", math(String.raw`T\in\mathcal{P}_M`), "、", math(String.raw`i\in\{1,\dots,M\}`),
        " が ", math(String.raw`i\in T`), " を満たすとき、次が成り立つ。",
      ]),
      displayMath(String.raw`a^{\dagger}_i\cdot_{\mathrm{Cl}(V,q)}a^{\dagger}_T=0_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`L:=\prod_{A,\,t=1}^{i-1}y^{T}_t`), "、", math(String.raw`R:=\prod_{A,\,r=1}^{M-i}y^{T}_{i+r}`),
        " と置く（", ref("def_selected_creation_factor"), "）。", math(String.raw`i\in T`), " なので ", math(String.raw`y^{T}_i=a^{\dagger}_i`),
        " である。", math(String.raw`\varsigma`), " と ", math(String.raw`N_i(T)`), " は ", ref("claim_creation_generator_passes_initial_creation_factors_with_sign"),
        " のものである。",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A a^{\dagger}_T
&=a^{\dagger}_i\cdot_A\Bigl(L\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ n:=M\text{、}p:=i\text{、}y^{T}_i=a^{\dagger}_i\text{。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\bigl(a^{\dagger}_i\cdot_A L\bigr)\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(L\cdot_A a^{\dagger}_i\bigr)\Bigr)\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)
&&\left(\because\ m:=i-1\text{。}\blkref{claim_creation_generator_passes_initial_creation_factors_with_sign}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(\bigl(L\cdot_A a^{\dagger}_i\bigr)\cdot_A\bigl(a^{\dagger}_i\cdot_A R\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(a^{\dagger}_i\cdot_A(a^{\dagger}_i\cdot_A R)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl((a^{\dagger}_i\cdot_A a^{\dagger}_i)\cdot_A R\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(0_A\cdot_A R\bigr)\Bigr)
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(L\cdot_A 0_A\bigr)
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A 0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_initial_reverse_ordered_product_of_selected_annihilation_generators",
    kind: "definition",
    title: { text: "部分集合の元のうち番号が m 以下のものの、消滅作用素にあたる元の番号の逆順の積" },
    labels: ["def_initial_reverse_ordered_product_of_selected_annihilation_generators"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）とし、", math(String.raw`z^{T}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ", ref("def_selected_annihilation_factor"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " と ", math(String.raw`k\in\{1,\dots,m\}`), " について ", math(String.raw`m+1-k\in\{1,\dots,m\}`), " なので、", math(String.raw`k`), " に ", math(String.raw`z^{T}_{m+1-k}`), " を与える族が定まる。", math(String.raw`A`), " の元 ", math(String.raw`a_{T,\le m}`), " を、その族の ", math(String.raw`A`), " の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。"]),
      displayMath(String.raw`a_{T,\le m}:=\prod_{A,\,k=1}^{m}z^{T}_{m+1-k}`),
      paragraph([math(String.raw`a_{T,\le m}`), " は ", math(String.raw`z^{T}_m,\dots,z^{T}_1`), " をこの順に左から右へ掛けた積である。"]),
    ],
  },
  {
    id: "isomorphism_claim_initial_reverse_ordered_annihilation_product_splits_off_last_number",
    kind: "claim",
    title: { text: "番号が m 以下の消滅の逆順の積は、番号 m の因子と、番号が m-1 以下の消滅の逆順の積との積である" },
    labels: ["claim_initial_reverse_ordered_annihilation_product_splits_off_last_number"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T\in\mathcal{P}_M`), " とし、", math(String.raw`z^{T}_t`), " を ", ref("def_selected_annihilation_factor"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), " のものとする。すべての ", math(String.raw`m\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a_{T,\le m}=z^{T}_m\cdot_A a_{T,\le m-1}`),
    ],
    proof: [
      paragraph([math(String.raw`s\in\{1,\dots,m\}`), " について ", math(String.raw`\eta_s:=z^{T}_{m+1-s}`), " と置く。", math(String.raw`\eta_1=z^{T}_m`), " であり、", math(String.raw`r\in\{1,\dots,m-1\}`), " について整数の計算 ", math(String.raw`m+1-(1+r)=(m-1)+1-r`), " により ", math(String.raw`\eta_{1+r}=z^{T}_{(m-1)+1-r}`), " なので、族 ", math(String.raw`r\mapsto \eta_{1+r}`), " は ", math(String.raw`a_{T,\le m-1}`), " を定める族と同じ族である。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}
&=\prod_{A,\,s=1}^{m}\eta_s
&&\left(\because\ \blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\right)\\
&=\left(\prod_{A,\,s=1}^{1}\eta_s\right)\cdot_A\left(\prod_{A,\,r=1}^{m-1}\eta_{1+r}\right)
&&\left(\because\ k:=1\text{、}l:=m-1\text{。}\blkref{claim_ordered_product_in_algebra_splits_into_first_and_last_factors}\right)\\
&=\bigl(1_A\cdot_A \eta_1\bigr)\cdot_A\left(\prod_{A,\,r=1}^{m-1}\eta_{1+r}\right)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\eta_1\cdot_A\left(\prod_{A,\,r=1}^{m-1}\eta_{1+r}\right)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=z^{T}_m\cdot_A\left(\prod_{A,\,r=1}^{m-1}z^{T}_{(m-1)+1-r}\right)
&&\left(\because\ \eta_1=z^{T}_m\text{、}\eta_{1+r}=z^{T}_{(m-1)+1-r}\text{。}\blkref{claim_ordered_products_with_equal_factors_are_equal}\right)\\
&=z^{T}_m\cdot_A a_{T,\le m-1}
&&\left(\because\ \blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product",
    kind: "claim",
    title: { text: "番号が M 以下の消滅の逆順の積は、消滅の逆順の積そのものである" },
    labels: ["claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T\in\mathcal{P}_M`), " とし、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a_T`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " のものとする。次が成り立つ。"]),
      displayMath(String.raw`a_{T,\le M}=a_T`),
    ],
    proof: [
      paragraph([math(String.raw`z^{T}_t`), " を ", ref("def_selected_annihilation_factor"), "、", math(String.raw`\check{z}^{T}_k`), " を ", ref("def_reverse_numbered_selected_annihilation_factor"), " のものとする。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le M}
&=\prod_{A,\,k=1}^{M}z^{T}_{M+1-k}
&&\left(\because\ m:=M\text{。}\blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\right)\\
&=\prod_{A,\,k=1}^{M}\check{z}^{T}_k
&&\left(\because\ \text{各}\ k\ \text{で}\ \blkref{def_reverse_numbered_selected_annihilation_factor}\text{。}\blkref{claim_ordered_products_with_equal_factors_are_equal}\right)\\
&=a_T
&&\left(\because\ \blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_initial_annihilation_factors_pass_annihilation_generator_with_sign",
    kind: "claim",
    title: { text: "番号の小さい側の消滅の因子の逆順の積の右から消滅作用素にあたる元を左へ移すと、番号より小さい元の個数の符号が付く" },
    labels: ["claim_initial_annihilation_factors_pass_annihilation_generator_with_sign"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`T\in\mathcal{P}_M`), "、",
        math(String.raw`i\in\{1,\dots,M\}`), " とする。", math(String.raw`a_{T,\le m}`), "（", math(String.raw`m\in\{0,1,\dots,M\}`), "）を ",
        ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), " のもの、", math(String.raw`N_{m}(T)`), " を ", ref("def_count_of_subset_elements_below_index"),
        "、", math(String.raw`\varsigma`), " を ", ref("def_sign_of_nonnegative_integer"), " のものとする。このとき、すべての ", math(String.raw`m\in\{0,1,\dots,i-1\}`), " について次が成り立つ（",
        math(String.raw`m+1\le i\le M`), " なので ", math(String.raw`N_{m+1}(T)`), " は定まる）。",
      ]),
      displayMath(String.raw`a_{T,\le m}\cdot_{\mathrm{Cl}(V,q)}a_i=\varsigma\bigl(N_{m+1}(T)\bigr)\ast_{\mathrm{Cl}(V,q)}\bigl(a_i\cdot_{\mathrm{Cl}(V,q)}a_{T,\le m}\bigr)`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`z_t:=z^{T}_t`), "（", ref("def_selected_annihilation_factor"), "）、", math(String.raw`N_m:=N_m(T)`), " と置く。", math(String.raw`-1_{\mathbb{C}}`),
        " は ", ref("claim_anticommuting_elements_swap_with_sign"), " のものである。",
      ]),
      paragraph(["主張を ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき：", ]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le 0}\cdot_A a_i
&=1_A\cdot_A a_i
&&\left(\because\ m:=0\text{。}\blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\text{、}\blkref{def_ordered_product_in_algebra}\right)\\
&=a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_{\mathbb{C}}\ast_A a_i
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(a_i\cdot_A 1_A\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(0)\ast_A\bigl(a_i\cdot_A 1_A\bigr)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma(N_1)\ast_A\bigl(a_i\cdot_A 1_A\bigr)
&&\left(\because\ \blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_1)\ast_A\bigl(a_i\cdot_A a_{T,\le 0}\bigr)
&&\left(\because\ m:=0\text{。}\blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\text{、}\blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le i-1`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`m+1\in\{2,\dots,M\}`),
        " なので ", math(String.raw`N_{m+1}`), " は ", ref("def_count_of_subset_elements_below_index"), " の二つ目の式で定まる。", math(String.raw`m\in T`),
        " のとき、", math(String.raw`z_m=a_m`), " であり（", ref("def_selected_annihilation_factor"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a_i
&=\bigl(a_m\cdot_A a_{T,\le m-1}\bigr)\cdot_A a_i
&&\left(\because\ z_m=a_m\text{。}\blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=a_m\cdot_A\bigl(a_{T,\le m-1}\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl(\varsigma(N_m)\ast_A\bigl(a_i\cdot_A a_{T,\le m-1}\bigr)\Bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(a_m\cdot_A\bigl(a_i\cdot_A a_{T,\le m-1}\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\bigl(a_m\cdot_A a_i\bigr)\cdot_A a_{T,\le m-1}\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_m)\ast_A\Bigl(\bigl((-1_{\mathbb{C}})\ast_A(a_i\cdot_A a_m)\bigr)\cdot_A a_{T,\le m-1}\Bigr)
&&\left(\because\ \text{二元に}\ a_m\text{、}a_i\ \text{をこの順に当てる。}\blkref{claim_annihilation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=\varsigma(N_m)\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl((a_i\cdot_A a_m)\cdot_A a_{T,\le m-1}\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(\varsigma(N_m)\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl((a_i\cdot_A a_m)\cdot_A a_{T,\le m-1}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma(N_m)\bigr)\ast_A\bigl((a_i\cdot_A a_m)\cdot_A a_{T,\le m-1}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\varsigma(N_m+1)\ast_A\bigl((a_i\cdot_A a_m)\cdot_A a_{T,\le m-1}\bigr)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl((a_i\cdot_A a_m)\cdot_A a_{T,\le m-1}\bigr)
&&\left(\because\ m\in T\text{。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A(a_m\cdot_A a_{T,\le m-1})\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A a_{T,\le m}\bigr)
&&\left(\because\ z_m=a_m\text{。}\blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\notin T`), " のとき、", math(String.raw`z_m=1_A`), " であり（", ref("def_selected_annihilation_factor"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a_i
&=\bigl(1_A\cdot_A a_{T,\le m-1}\bigr)\cdot_A a_i
&&\left(\because\ z_m=1_A\text{。}\blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=a_{T,\le m-1}\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_m)\ast_A\bigl(a_i\cdot_A a_{T,\le m-1}\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A a_{T,\le m-1}\bigr)
&&\left(\because\ m\notin T\text{。}\blkref{def_count_of_subset_elements_below_index}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A(1_A\cdot_A a_{T,\le m-1})\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\varsigma(N_{m+1})\ast_A\bigl(a_i\cdot_A a_{T,\le m}\bigr)
&&\left(\because\ z_m=1_A\text{。}\blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index",
    kind: "claim",
    title: { text: "番号を含まない部分集合の消滅の逆順の積に、その番号の消滅作用素にあたる元を右から掛けると、番号を足した部分集合の消滅の逆順の積の符号倍になる" },
    labels: ["claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`a_T`), " を ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " の元、", math(String.raw`N_i(T)`), " を ", ref("def_count_of_subset_elements_below_index"), "、",
        math(String.raw`\varsigma`), " を ", ref("def_sign_of_nonnegative_integer"), " のものとする。", math(String.raw`T\in\mathcal{P}_M`), "、",
        math(String.raw`i\in\{1,\dots,M\}`), " が ", math(String.raw`i\notin T`), " を満たすとき、", math(String.raw`T\cup\{i\}\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`a_T\cdot_{\mathrm{Cl}(V,q)}a_i=\varsigma\bigl(N_i(T)\bigr)\ast_{\mathrm{Cl}(V,q)}a_{T\cup\{i\}}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`S:=T\cup\{i\}`), "、", math(String.raw`p:=M+1-i\in\{1,\dots,M\}`), " と置く。", math(String.raw`p-1=M-i`),
        "、", math(String.raw`M-p=i-1`), " である。", math(String.raw`z^{T}_t`), "・", math(String.raw`z^{S}_t`), " を ", ref("def_selected_annihilation_factor"), "、",
        math(String.raw`\check{z}^{T}_k`), "・", math(String.raw`\check{z}^{S}_k`), " を ", ref("def_reverse_numbered_selected_annihilation_factor"), " のものとする。",
        math(String.raw`t\neq i`), " なら ", math(String.raw`t\in S`), " と ", math(String.raw`t\in T`), " は同値なので ", math(String.raw`z^{S}_t=z^{T}_t`), " であり、",
        math(String.raw`i\notin T`), " なので ", math(String.raw`z^{T}_i=1_A`), "、", math(String.raw`i\in S`), " なので ", math(String.raw`z^{S}_i=a_i`), " である（",
        ref("def_selected_annihilation_factor"), "）。整数の計算 ", math(String.raw`M+1-p=i`), " により ", math(String.raw`\check{z}^{T}_p=z^{T}_i`), " であり、", math(String.raw`r\in\{1,\dots,i-1\}`),
        " について整数の計算 ", math(String.raw`M+1-(p+r)=(i-1)+1-r`), " により ", math(String.raw`\check{z}^{T}_{p+r}=z^{T}_{(i-1)+1-r}`), " である（", ref("def_reverse_numbered_selected_annihilation_factor"),
        "）。", math(String.raw`\check{z}^{S}`), " についても同じである。", math(String.raw`L:=\prod_{A,\,k=1}^{M-i}\check{z}^{T}_k`), "、", math(String.raw`\alpha:=a_{T,\le i-1}`),
        "（", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "）と置く。", math(String.raw`k\le M-i`), " なら ", math(String.raw`M+1-k\ge i+1`),
        " なので ", math(String.raw`\check{z}^{S}_k=\check{z}^{T}_k`), "、", math(String.raw`r\ge 1`), " なら ", math(String.raw`i-r\le i-1`), " なので ",
        math(String.raw`\check{z}^{S}_{p+r}=\check{z}^{T}_{p+r}`), " である。", math(String.raw`\alpha`), " を定める族 ", math(String.raw`r\mapsto z^{T}_{(i-1)+1-r}`),
        " は各番号で族 ", math(String.raw`r\mapsto\check{z}^{T}_{p+r}`), " に等しい。したがって ", ref("claim_ordered_products_with_equal_factors_are_equal"),
        " を三つの組の族に当てて、", math(String.raw`L=\prod_{A,\,k=1}^{M-i}\check{z}^{S}_k`), "、", math(String.raw`\alpha=\prod_{A,\,r=1}^{i-1}\check{z}^{T}_{p+r}`), "、",
        math(String.raw`\prod_{A,\,r=1}^{i-1}\check{z}^{T}_{p+r}=\prod_{A,\,r=1}^{i-1}\check{z}^{S}_{p+r}`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_T\cdot_A a_i
&=\Bigl(L\cdot_A\bigl(\check{z}^{T}_p\cdot_A \alpha\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ n:=M\text{。}\blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\text{、}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\Bigl(L\cdot_A\bigl(z^{T}_i\cdot_A \alpha\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ M+1-p=i\text{。}\blkref{def_reverse_numbered_selected_annihilation_factor}\right)\\
&=\Bigl(L\cdot_A\bigl(1_A\cdot_A \alpha\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ i\notin T\text{。}\blkref{def_selected_annihilation_factor}\right)\\
&=\bigl(L\cdot_A \alpha\bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\bigl(\alpha\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(a_i\cdot_A \alpha\bigr)\Bigr)
&&\left(\because\ m:=i-1\text{。}\blkref{claim_initial_annihilation_factors_pass_annihilation_generator_with_sign}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(a_i\cdot_A \alpha\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(z^{S}_i\cdot_A \alpha\bigr)\Bigr)
&&\left(\because\ i\in S\text{。}\blkref{def_selected_annihilation_factor}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(\check{z}^{S}_p\cdot_A \alpha\bigr)\Bigr)
&&\left(\because\ M+1-p=i\text{。}\blkref{def_reverse_numbered_selected_annihilation_factor}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\prod_{A,\,k=1}^{M}\check{z}^{S}_k
&&\left(\because\ \text{族}\ \check{z}^{S}\ \text{に}\ n:=M\ \text{で当てる。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A a_{T\cup\{i\}}
&&\left(\because\ S=T\cup\{i\}\text{。}\blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero",
    kind: "claim",
    title: { text: "番号を含む部分集合の消滅の逆順の積に、その番号の消滅作用素にあたる元を右から掛けると零になる" },
    labels: ["claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元、", math(String.raw`a_T`), " を ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), " の元とする。", math(String.raw`T\in\mathcal{P}_M`), "、", math(String.raw`i\in\{1,\dots,M\}`),
        " が ", math(String.raw`i\in T`), " を満たすとき、次が成り立つ。",
      ]),
      displayMath(String.raw`a_T\cdot_{\mathrm{Cl}(V,q)}a_i=0_{\mathrm{Cl}(V,q)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`p:=M+1-i`), " と置き、", math(String.raw`\check{z}^{T}_k`), " を ", ref("def_reverse_numbered_selected_annihilation_factor"),
        " のものとし、", math(String.raw`L:=\prod_{A,\,k=1}^{M-i}\check{z}^{T}_k`), "、", math(String.raw`\alpha:=a_{T,\le i-1}`), "（",
        ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "）と置く。",
        ref("claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index"), " の証明と同じく ", math(String.raw`\alpha=\prod_{A,\,r=1}^{i-1}\check{z}^{T}_{p+r}`),
        " である。", math(String.raw`\varsigma`), " と ", math(String.raw`N_i(T)`), " は ", ref("claim_initial_annihilation_factors_pass_annihilation_generator_with_sign"),
        " のものである。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_T\cdot_A a_i
&=\Bigl(L\cdot_A\bigl(\check{z}^{T}_p\cdot_A \alpha\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ n:=M\text{。}\blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=\Bigl(L\cdot_A\bigl(z^{T}_i\cdot_A \alpha\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ M+1-p=i\text{。}\blkref{def_reverse_numbered_selected_annihilation_factor}\right)\\
&=\Bigl(L\cdot_A\bigl(a_i\cdot_A \alpha\bigr)\Bigr)\cdot_A a_i
&&\left(\because\ i\in T\text{。}\blkref{def_selected_annihilation_factor}\right)\\
&=L\cdot_A\Bigl(\bigl(a_i\cdot_A \alpha\bigr)\cdot_A a_i\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(a_i\cdot_A\bigl(\alpha\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(a_i\cdot_A\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(a_i\cdot_A \alpha\bigr)\Bigr)\Bigr)
&&\left(\because\ m:=i-1\text{。}\blkref{claim_initial_annihilation_factors_pass_annihilation_generator_with_sign}\right)\\
&=L\cdot_A\Bigl(\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(a_i\cdot_A(a_i\cdot_A \alpha)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(a_i\cdot_A(a_i\cdot_A \alpha)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl((a_i\cdot_A a_i)\cdot_A \alpha\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\Bigl(L\cdot_A\bigl(0_A\cdot_A \alpha\bigr)\Bigr)
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A\bigl(L\cdot_A 0_A\bigr)
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)\ast_A 0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_global_identities_in_clifford_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "クリフォード代数の中の大域的な等式" },
    labels: [],
  },
  {
    id: "isomorphism_claim_annihilation_generator_commutes_with_other_number_reversed_pair",
    kind: "claim",
    title: { text: "消滅作用素にあたる元は、番号の違う生成と消滅の積と交換する" },
    labels: ["claim_annihilation_generator_commutes_with_other_number_reversed_pair"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`i\neq j`), " であるすべての ", math(String.raw`i,j\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a_i\cdot_A\bigl(a^{\dagger}_j\cdot_A a_j\bigr)=\bigl(a^{\dagger}_j\cdot_A a_j\bigr)\cdot_A a_i`),
    ],
    proof: [
      paragraph([math(String.raw`-1_{\mathbb{C}}`), " は ", ref("claim_anticommuting_elements_swap_with_sign"), " のものである。準備として、", math(String.raw`i\neq j`), " なので ", math(String.raw`\delta_{i,j}=0_{\mathbb{C}}`), "（", ref("def_kronecker_delta"), "）であり、次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A a^{\dagger}_j+_A a^{\dagger}_j\cdot_A a_i
&=\delta_{i,j}\ast_A 1_A
&&\left(\because\ \blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ i\neq j\text{。}\blkref{def_kronecker_delta}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A\bigl(a^{\dagger}_j\cdot_A a_j\bigr)
&=\bigl(a_i\cdot_A a^{\dagger}_j\bigr)\cdot_A a_j
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_j\cdot_A a_i)\bigr)\cdot_A a_j
&&\left(\because\ \text{二元に}\ a_i\text{、}a^{\dagger}_j\ \text{をこの順に当てる。準備。}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((a^{\dagger}_j\cdot_A a_i)\cdot_A a_j\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_j\cdot_A(a_i\cdot_A a_j)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(a^{\dagger}_j\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a_j\cdot_A a_i)\bigr)\Bigr)
&&\left(\because\ \text{二元に}\ a_i\text{、}a_j\ \text{をこの順に当てる。}\blkref{claim_annihilation_generators_anticommute}\text{、}\blkref{claim_anticommuting_elements_swap_with_sign}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_j\cdot_A(a_j\cdot_A a_i)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(a^{\dagger}_j\cdot_A(a_j\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(a^{\dagger}_j\cdot_A(a_j\cdot_A a_i)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の計算}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=a^{\dagger}_j\cdot_A(a_j\cdot_A a_i)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(a^{\dagger}_j\cdot_A a_j\bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_factors_with_different_numbers_commute",
    kind: "claim",
    title: { text: "番号の違う消滅と生成の積どうしは交換する" },
    labels: ["claim_vacuum_factors_with_different_numbers_commute"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。", math(String.raw`i\neq j`), " であるすべての ", math(String.raw`i,j\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`x_i\cdot_A x_j=x_j\cdot_A x_i`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
x_i\cdot_A x_j
&=\bigl(a_i\cdot_A a^{\dagger}_i\bigr)\cdot_A x_j
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A x_j\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A\bigl(x_j\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ i\neq j\text{。}\blkref{claim_creation_generator_commutes_with_other_number_pair}\right)\\
&=\bigl(a_i\cdot_A x_j\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(x_j\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ i\neq j\text{。}\blkref{claim_annihilation_generator_commutes_with_other_number_pair}\right)\\
&=x_j\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=x_j\cdot_A x_i
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator",
    kind: "claim",
    title: { text: "消滅と生成の積に同じ番号の消滅作用素にあたる元を右から掛けると、その消滅作用素にあたる元になる" },
    labels: ["claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`x_i\cdot_A a_i=a_i`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
x_i\cdot_A a_i
&=\bigl(a_i\cdot_A a^{\dagger}_i\bigr)\cdot_A a_i
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)+_A 0_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=0_A+_A\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(0_A\cdot_A a^{\dagger}_i\bigr)+_A\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=\bigl((a_i\cdot_A a_i)\cdot_A a^{\dagger}_i\bigr)+_A\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=\Bigl(a_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i\bigr)\Bigr)+_A\Bigl(a_i\cdot_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A\Bigl(\bigl(a_i\cdot_A a^{\dagger}_i\bigr)+_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則（左の因子が共通）。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A\bigl(\delta_{i,i}\ast_A 1_A\bigr)
&&\left(\because\ j:=i\text{。}\blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=a_i\cdot_A\bigl(1_{\mathbb{C}}\ast_A 1_A\bigr)
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=a_i\cdot_A 1_A
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_times_vacuum_factor_is_creation_generator",
    kind: "claim",
    title: { text: "消滅と生成の積に同じ番号の生成作用素にあたる元を左から掛けると、その生成作用素にあたる元になる" },
    labels: ["claim_creation_generator_times_vacuum_factor_is_creation_generator"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a^{\dagger}_i\cdot_A x_i=a^{\dagger}_i`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A x_i
&=a^{\dagger}_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)+_A 0_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=0_A+_A\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(a_i\cdot_A 0_A\bigr)+_A\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=\bigl(a_i\cdot_A(a^{\dagger}_i\cdot_A a^{\dagger}_i)\bigr)+_A\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=\Bigl(\bigl(a_i\cdot_A a^{\dagger}_i\bigr)\cdot_A a^{\dagger}_i\Bigr)+_A\Bigl(\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a_i\cdot_A a^{\dagger}_i\bigr)+_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則（右の因子が共通）。}\blkref{def_unital_ring}\right)\\
&=\bigl(\delta_{i,i}\ast_A 1_A\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ j:=i\text{。}\blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=\bigl(1_{\mathbb{C}}\ast_A 1_A\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=1_A\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_factor_is_idempotent",
    kind: "claim",
    title: { text: "消滅と生成の積の自分自身との積は、もとの積である" },
    labels: ["claim_vacuum_factor_is_idempotent"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`x_i\cdot_A x_i=x_i`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
x_i\cdot_A x_i
&=x_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=\bigl(x_i\cdot_A a_i\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A a^{\dagger}_i
&&\left(\because\ \blkref{claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator}\right)\\
&=x_i
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_initial_ordered_product_of_selected_creation_generators",
    kind: "definition",
    title: { text: "部分集合の元のうち番号が m 以下のものの、生成作用素にあたる元の番号順の積" },
    labels: ["def_initial_ordered_product_of_selected_creation_generators"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`U\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）とし、", math(String.raw`y^{U}_t`), "（", math(String.raw`t\in\{1,\dots,M\}`), "）を ", ref("def_selected_creation_factor"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、", math(String.raw`A`), " の元 ", math(String.raw`a^{\dagger}_{U,\le m}`), " を、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した ", math(String.raw`A`), " の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。"]),
      displayMath(String.raw`a^{\dagger}_{U,\le m}:=\prod_{A,\,t=1}^{m}y^{U}_t`),
    ],
  },
  {
    id: "isomorphism_claim_initial_ordered_creation_product_splits_off_last_number",
    kind: "claim",
    title: { text: "番号が m 以下の生成の積は、番号が m-1 以下の生成の積と番号 m の因子との積である" },
    labels: ["claim_initial_ordered_creation_product_splits_off_last_number"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`U\in\mathcal{P}_M`), " とし、", math(String.raw`y^{U}_t`), " を ", ref("def_selected_creation_factor"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), " のものとする。すべての ", math(String.raw`m\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a^{\dagger}_{U,\le m}=a^{\dagger}_{U,\le m-1}\cdot_A y^{U}_m`),
    ],
    proof: [
      paragraph([math(String.raw`\Pi_j`), "（", math(String.raw`j\in\{0,1,\dots,M\}`), "）を、族 ", math(String.raw`y^{U}_1,\dots,y^{U}_M`), " について ", ref("def_ordered_product_in_algebra"), " で帰納的に定めた元とする。"]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_{U,\le m}
&=\prod_{A,\,t=1}^{m}y^{U}_t
&&\left(\because\ \blkref{def_initial_ordered_product_of_selected_creation_generators}\right)\\
&=\Pi_m
&&\left(\because\ n:=M\text{。}\blkref{claim_partial_product_is_ordered_product_of_restricted_family}\right)\\
&=\Pi_{m-1}\cdot_A y^{U}_m
&&\left(\because\ 1\le m\le M\text{。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\left(\prod_{A,\,t=1}^{m-1}y^{U}_t\right)\cdot_A y^{U}_m
&&\left(\because\ n:=M\text{、}m:=m-1\text{。}\blkref{claim_partial_product_is_ordered_product_of_restricted_family}\ \text{を右辺から左辺へ読む}\right)\\
&=a^{\dagger}_{U,\le m-1}\cdot_A y^{U}_m
&&\left(\because\ \blkref{def_initial_ordered_product_of_selected_creation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_initial_ordered_creation_product_up_to_last_number_is_whole_product",
    kind: "claim",
    title: { text: "番号が M 以下の生成の積は、生成の積そのものである" },
    labels: ["claim_initial_ordered_creation_product_up_to_last_number_is_whole_product"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`U\in\mathcal{P}_M`), " とし、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a^{\dagger}_U`), " を ", ref("def_ordered_product_of_selected_creation_generators"), " のものとする。次が成り立つ。"]),
      displayMath(String.raw`a^{\dagger}_{U,\le M}=a^{\dagger}_U`),
    ],
    proof: [
      paragraph([math(String.raw`y^{U}_t`), " を ", ref("def_selected_creation_factor"), " のものとする。"]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_{U,\le M}
&=\prod_{A,\,t=1}^{M}y^{U}_t
&&\left(\because\ m:=M\text{。}\blkref{def_initial_ordered_product_of_selected_creation_generators}\right)\\
&=a^{\dagger}_U
&&\left(\because\ \blkref{def_ordered_product_of_selected_creation_generators}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_initial_part_of_vacuum_element",
    kind: "definition",
    title: { text: "真空への射影にあたる元の、番号が m 以下の因子の積" },
    labels: ["def_initial_part_of_vacuum_element"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、", math(String.raw`A`), " の元 ", math(String.raw`P_{\le m}`), " を、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した ", math(String.raw`A`), " の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。"]),
      displayMath(String.raw`P_{\le m}:=\prod_{A,\,i=1}^{m}x_i`),
    ],
  },
  {
    id: "isomorphism_claim_initial_part_of_vacuum_element_splits_off_last_factor",
    kind: "claim",
    title: { text: "真空への射影にあたる元の番号が m 以下の因子の積は、番号が m-1 以下の因子の積と番号 m の因子との積である" },
    labels: ["claim_initial_part_of_vacuum_element_splits_off_last_factor"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), " のものとする。すべての ", math(String.raw`m\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`P_{\le m}=P_{\le m-1}\cdot_A x_m`),
    ],
    proof: [
      paragraph([math(String.raw`\Pi_j`), "（", math(String.raw`j\in\{0,1,\dots,M\}`), "）を、族 ", math(String.raw`x_1,\dots,x_M`), " について ", ref("def_ordered_product_in_algebra"), " で帰納的に定めた元とする。"]),
      displayMath(String.raw`\begin{aligned}
P_{\le m}
&=\prod_{A,\,i=1}^{m}x_i
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\right)\\
&=\Pi_m
&&\left(\because\ n:=M\text{。}\blkref{claim_partial_product_is_ordered_product_of_restricted_family}\right)\\
&=\Pi_{m-1}\cdot_A x_m
&&\left(\because\ 1\le m\le M\text{。}\blkref{def_ordered_product_in_algebra}\right)\\
&=\left(\prod_{A,\,i=1}^{m-1}x_i\right)\cdot_A x_m
&&\left(\because\ n:=M\text{、}m:=m-1\text{。}\blkref{claim_partial_product_is_ordered_product_of_restricted_family}\ \text{を右辺から左辺へ読む}\right)\\
&=P_{\le m-1}\cdot_A x_m
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element",
    kind: "claim",
    title: { text: "真空への射影にあたる元の番号が M 以下の因子の積は、真空への射影にあたる元そのものである" },
    labels: ["claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`P`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。次が成り立つ。"]),
      displayMath(String.raw`P_{\le M}=P`),
    ],
    proof: [
      paragraph([math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。"]),
      displayMath(String.raw`\begin{aligned}
P_{\le M}
&=\prod_{A,\,i=1}^{M}x_i
&&\left(\because\ m:=M\text{。}\blkref{def_initial_part_of_vacuum_element}\right)\\
&=P
&&\left(\because\ \blkref{def_vacuum_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_vacuum_sandwich_of_initial_parts",
    kind: "definition",
    title: { text: "番号が m 以下の部分の消滅と生成の積を、真空への射影にあたる元の番号が m 以下の因子の積で挟んだ元" },
    labels: ["def_vacuum_sandwich_of_initial_parts"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), "、", math(String.raw`m\in\{0,1,\dots,M\}`), " とし、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), " のものとする。", math(String.raw`A`), " の元 ", math(String.raw`Q^{T,U}_m`), " を次で定める。"]),
      displayMath(String.raw`Q^{T,U}_m:=\Bigl(P_{\le m}\cdot_A\bigl(a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}\bigr)\Bigr)\cdot_A P_{\le m}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich",
    kind: "claim",
    title: { text: "番号が M 以下の部分の消滅と生成の積を、真空への射影にあたる元の番号が M 以下の因子の積で挟んだ元は、消滅の逆順の積と生成の積の積を真空への射影にあたる元で挟んだ元である" },
    labels: ["claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), " とし、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), "、", math(String.raw`a_T`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_U`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_M=\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_M
&=\Bigl(P_{\le M}\cdot_A\bigl(a_{T,\le M}\cdot_A a^{\dagger}_{U,\le M}\bigr)\Bigr)\cdot_A P_{\le M}
&&\left(\because\ m:=M\text{。}\blkref{def_vacuum_sandwich_of_initial_parts}\right)\\
&=\Bigl(P_{\le M}\cdot_A\bigl(a_T\cdot_A a^{\dagger}_{U,\le M}\bigr)\Bigr)\cdot_A P_{\le M}
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product}\right)\\
&=\Bigl(P_{\le M}\cdot_A\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\Bigr)\cdot_A P_{\le M}
&&\left(\because\ \blkref{claim_initial_ordered_creation_product_up_to_last_number_is_whole_product}\right)\\
&=\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P
&&\left(\because\ \text{二か所に}\ \blkref{claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_factor_commutes_with_lower_initial_parts",
    kind: "claim",
    title: { text: "番号 m の消滅と生成の積は、番号が m-1 以下の部分の消滅と生成の積と交換する" },
    labels: ["claim_vacuum_factor_commutes_with_lower_initial_parts"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。すべての ", math(String.raw`m\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`x_m\cdot_A\bigl(a_{T,\le m-1}\cdot_A a^{\dagger}_{U,\le m-1}\bigr)=\bigl(a_{T,\le m-1}\cdot_A a^{\dagger}_{U,\le m-1}\bigr)\cdot_A x_m`),
    ],
    proof: [
      paragraph([math(String.raw`\alpha:=a_{T,\le m-1}`), "、", math(String.raw`\kappa:=a^{\dagger}_{U,\le m-1}`), " と置き、", math(String.raw`y^{U}_t`), " を ", ref("def_selected_creation_factor"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_selected_annihilation_factor"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`x_m\cdot_A 1_A=x_m`), " と ", math(String.raw`1_A\cdot_A x_m=x_m`), " により（", ref("def_unital_ring"), " の乗法の単位元）、", math(String.raw`1_A`), " は ", math(String.raw`x_m`), " と交換する。", math(String.raw`t\in\{1,\dots,m-1\}`), " とする。", math(String.raw`t\in T`), " なら ", math(String.raw`z^{T}_t=a_t`), " であり、", math(String.raw`t\neq m`), " なので ", math(String.raw`a_t\cdot_A x_m=x_m\cdot_A a_t`), " である（", ref("claim_annihilation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`t,m`), " を当てる）。", math(String.raw`t\notin T`), " なら ", math(String.raw`z^{T}_t=1_A`), " である。どちらでも ", math(String.raw`x_m\cdot_A z^{T}_t=z^{T}_t\cdot_A x_m`), " である。同じく ", math(String.raw`y^{U}_t`), " は ", math(String.raw`a^{\dagger}_t`), " か ", math(String.raw`1_A`), " であり、", math(String.raw`x_m\cdot_A y^{U}_t=y^{U}_t\cdot_A x_m`), " である（", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`t,m`), " を当てる）。", math(String.raw`\alpha`), " の因子は ", math(String.raw`z^{T}_{m-k}`), "（", math(String.raw`k\in\{1,\dots,m-1\}`), "、", math(String.raw`m-k\in\{1,\dots,m-1\}`), "）、", math(String.raw`\kappa`), " の因子は ", math(String.raw`y^{U}_t`), "（", math(String.raw`t\in\{1,\dots,m-1\}`), "）なので、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=x_m`), " と二つの族に当てて、", math(String.raw`x_m\cdot_A\alpha=\alpha\cdot_A x_m`), "、", math(String.raw`x_m\cdot_A\kappa=\kappa\cdot_A x_m`), " が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
x_m\cdot_A(\alpha\cdot_A\kappa)
&=(x_m\cdot_A\alpha)\cdot_A\kappa
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(\alpha\cdot_A x_m)\cdot_A\kappa
&&\left(\because\ x_m\cdot_A\alpha=\alpha\cdot_A x_m\right)\\
&=\alpha\cdot_A(x_m\cdot_A\kappa)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\alpha\cdot_A(\kappa\cdot_A x_m)
&&\left(\because\ x_m\cdot_A\kappa=\kappa\cdot_A x_m\right)\\
&=(\alpha\cdot_A\kappa)\cdot_A x_m
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset",
    kind: "claim",
    title: { text: "番号 m がちょうど一方の部分集合に入るとき、番号が m 以下の部分を真空の因子で挟んだ元は零である" },
    labels: ["claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), "、", math(String.raw`m\in\{1,\dots,M\}`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。「", math(String.raw`m\in T`), " かつ ", math(String.raw`m\notin U`), "」か「", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\in U`), "」が成り立つとき、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=0_A`),
    ],
    proof: [
      paragraph([math(String.raw`x:=x_m`), "、", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`\alpha:=a_{T,\le m-1}`), "、", math(String.raw`\kappa:=a^{\dagger}_{U,\le m-1}`), "、", math(String.raw`G:=\alpha\cdot_A\kappa`), " と置き、", math(String.raw`y^{U}_t`), " を ", ref("def_selected_creation_factor"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_selected_annihilation_factor"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`z:=z^{T}_m`), "、", math(String.raw`y:=y^{U}_m`), " と置く。準備として次の三つが成り立つ。（イ）", math(String.raw`P_{\le m}=P'\cdot_A x`), " であり（", ref("claim_initial_part_of_vacuum_element_splits_off_last_factor"), "）、", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`x\cdot_A x_j=x_j\cdot_A x`), " であるから（", ref("claim_vacuum_factors_with_different_numbers_commute"), "）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=x`), " と族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`x\cdot_A P'=P'\cdot_A x`), " である。（ロ）", math(String.raw`x\cdot_A G=G\cdot_A x`), " である（", ref("claim_vacuum_factor_commutes_with_lower_initial_parts"), "）。（ハ）次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A a^{\dagger}_{U,\le m}
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A\bigl(\kappa\cdot_A y\bigr)
&&\left(\because\ \blkref{claim_initial_ordered_creation_product_splits_off_last_number}\right)\\
&=z\cdot_A\bigl(\alpha\cdot_A(\kappa\cdot_A y)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A\bigl((\alpha\cdot_A\kappa)\cdot_A y\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ G\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([math(String.raw`m\in T`), " かつ ", math(String.raw`m\notin U`), " のとき、", math(String.raw`z=a_m`), "、", math(String.raw`y=1_A`), " である（", ref("def_selected_annihilation_factor"), "、", ref("def_selected_creation_factor"), "）。次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ \text{（ハ）}\right)\\
&=a_m\cdot_A(G\cdot_A 1_A)
&&\left(\because\ z=a_m\text{、}y=1_A\right)\\
&=a_m\cdot_A G
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph(["また次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_m\cdot_A x
&=a_m\cdot_A(a_m\cdot_A a^{\dagger}_m)
&&\left(\because\ x=x_m\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=(a_m\cdot_A a_m)\cdot_A a^{\dagger}_m
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=0_A\cdot_A a^{\dagger}_m
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=\bigl(P_{\le m}\cdot_A(a_m\cdot_A G)\bigr)\cdot_A P_{\le m}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、}a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=a_m\cdot_A G\right)\\
&=\bigl((P'\cdot_A x)\cdot_A(a_m\cdot_A G)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）の}\ P_{\le m}=P'\cdot_A x\ \text{を二か所に適用}\right)\\
&=\Bigl(P'\cdot_A\bigl(x\cdot_A(a_m\cdot_A G)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl((x\cdot_A a_m)\cdot_A G\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(P'\cdot_A(a_m\cdot_A G)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \blkref{claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator}\right)\\
&=P'\cdot_A\bigl((a_m\cdot_A G)\cdot_A(P'\cdot_A x)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\bigl((a_m\cdot_A G)\cdot_A(x\cdot_A P')\bigr)
&&\left(\because\ \text{（イ）}\right)\\
&=P'\cdot_A\Bigl(a_m\cdot_A\bigl(G\cdot_A(x\cdot_A P')\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\Bigl(a_m\cdot_A\bigl((G\cdot_A x)\cdot_A P'\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\Bigl(a_m\cdot_A\bigl((x\cdot_A G)\cdot_A P'\bigr)\Bigr)
&&\left(\because\ \text{（ロ）}\right)\\
&=P'\cdot_A\Bigl(a_m\cdot_A\bigl(x\cdot_A(G\cdot_A P')\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\bigl((a_m\cdot_A x)\cdot_A(G\cdot_A P')\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P'\cdot_A\bigl(0_A\cdot_A(G\cdot_A P')\bigr)
&&\left(\because\ a_m\cdot_A x=0_A\right)\\
&=P'\cdot_A 0_A
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right).
\end{aligned}`),
      paragraph([math(String.raw`m\notin T`), " かつ ", math(String.raw`m\in U`), " のとき、", math(String.raw`z=1_A`), "、", math(String.raw`y=a^{\dagger}_m`), " である。次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ \text{（ハ）}\right)\\
&=1_A\cdot_A(G\cdot_A a^{\dagger}_m)
&&\left(\because\ z=1_A\text{、}y=a^{\dagger}_m\right)\\
&=G\cdot_A a^{\dagger}_m
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph(["また次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
x\cdot_A a^{\dagger}_m
&=(a_m\cdot_A a^{\dagger}_m)\cdot_A a^{\dagger}_m
&&\left(\because\ x=x_m\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=a_m\cdot_A(a^{\dagger}_m\cdot_A a^{\dagger}_m)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A 0_A
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=\bigl(P_{\le m}\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A P_{\le m}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、}a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=G\cdot_A a^{\dagger}_m\right)\\
&=\bigl((P'\cdot_A x)\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）の}\ P_{\le m}=P'\cdot_A x\ \text{を二か所に適用}\right)\\
&=\Bigl(P'\cdot_A\bigl(x\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl((x\cdot_A G)\cdot_A a^{\dagger}_m\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl((G\cdot_A x)\cdot_A a^{\dagger}_m\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（ロ）}\right)\\
&=\Bigl(P'\cdot_A\bigl(G\cdot_A(x\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(P'\cdot_A(G\cdot_A 0_A)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ x\cdot_A a^{\dagger}_m=0_A\right)\\
&=\bigl(P'\cdot_A 0_A\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=0_A\cdot_A(P'\cdot_A x)
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_when_last_number_is_in_neither_subset",
    kind: "claim",
    title: { text: "番号 m がどちらの部分集合にも入らないとき、番号が m 以下の部分を真空の因子で挟んだ元は、m-1 以下の部分の元に番号 m の因子を右から掛けたものである" },
    labels: ["claim_vacuum_sandwich_when_last_number_is_in_neither_subset"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), "、", math(String.raw`m\in\{1,\dots,M\}`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\notin U`), " のとき、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=Q^{T,U}_{m-1}\cdot_A x_m`),
    ],
    proof: [
      paragraph([math(String.raw`x:=x_m`), "、", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`\alpha:=a_{T,\le m-1}`), "、", math(String.raw`\kappa:=a^{\dagger}_{U,\le m-1}`), "、", math(String.raw`G:=\alpha\cdot_A\kappa`), " と置き、", math(String.raw`y^{U}_t`), " を ", ref("def_selected_creation_factor"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_selected_annihilation_factor"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`z:=z^{T}_m`), "、", math(String.raw`y:=y^{U}_m`), " と置く。準備として次の三つが成り立つ。（イ）", math(String.raw`P_{\le m}=P'\cdot_A x`), " であり（", ref("claim_initial_part_of_vacuum_element_splits_off_last_factor"), "）、", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`x\cdot_A x_j=x_j\cdot_A x`), " であるから（", ref("claim_vacuum_factors_with_different_numbers_commute"), "）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=x`), " と族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`x\cdot_A P'=P'\cdot_A x`), " である。（ロ）", math(String.raw`x\cdot_A G=G\cdot_A x`), " である（", ref("claim_vacuum_factor_commutes_with_lower_initial_parts"), "）。（ハ）次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A a^{\dagger}_{U,\le m}
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A\bigl(\kappa\cdot_A y\bigr)
&&\left(\because\ \blkref{claim_initial_ordered_creation_product_splits_off_last_number}\right)\\
&=z\cdot_A\bigl(\alpha\cdot_A(\kappa\cdot_A y)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A\bigl((\alpha\cdot_A\kappa)\cdot_A y\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ G\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([math(String.raw`m\notin T`), "、", math(String.raw`m\notin U`), " なので ", math(String.raw`z=1_A`), "、", math(String.raw`y=1_A`), " である（", ref("def_selected_annihilation_factor"), "、", ref("def_selected_creation_factor"), "）。次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ \text{（ハ）}\right)\\
&=1_A\cdot_A(G\cdot_A 1_A)
&&\left(\because\ z=1_A\text{、}y=1_A\right)\\
&=G\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=G
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=\bigl(P_{\le m}\cdot_A G\bigr)\cdot_A P_{\le m}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、}a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=G\right)\\
&=\bigl((P'\cdot_A x)\cdot_A G\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）の}\ P_{\le m}=P'\cdot_A x\ \text{を二か所に適用}\right)\\
&=\bigl(P'\cdot_A(x\cdot_A G)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(P'\cdot_A(G\cdot_A x)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（ロ）}\right)\\
&=\bigl((P'\cdot_A G)\cdot_A x\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((P'\cdot_A G)\cdot_A x\bigr)\cdot_A(x\cdot_A P')
&&\left(\because\ \text{（イ）}\right)\\
&=(P'\cdot_A G)\cdot_A\bigl(x\cdot_A(x\cdot_A P')\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(P'\cdot_A G)\cdot_A\bigl((x\cdot_A x)\cdot_A P'\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(P'\cdot_A G)\cdot_A(x\cdot_A P')
&&\left(\because\ \blkref{claim_vacuum_factor_is_idempotent}\right)\\
&=(P'\cdot_A G)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）}\right)\\
&=\bigl((P'\cdot_A G)\cdot_A P'\bigr)\cdot_A x
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=Q^{T,U}_{m-1}\cdot_A x_m
&&\left(\because\ G=\alpha\cdot_A\kappa\text{、}x=x_m\text{。}\blkref{def_vacuum_sandwich_of_initial_parts}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_when_last_number_is_in_both_subsets",
    kind: "claim",
    title: { text: "番号 m が両方の部分集合に入るとき、番号が m 以下の部分を真空の因子で挟んだ元は、m-1 以下の部分の元を番号 m の消滅と生成で挟んだものである" },
    labels: ["claim_vacuum_sandwich_when_last_number_is_in_both_subsets"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), "、", math(String.raw`m\in\{1,\dots,M\}`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。", math(String.raw`m\in T`), " かつ ", math(String.raw`m\in U`), " のとき、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=a_m\cdot_A\bigl(Q^{T,U}_{m-1}\cdot_A a^{\dagger}_m\bigr)`),
    ],
    proof: [
      paragraph([math(String.raw`x:=x_m`), "、", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`\alpha:=a_{T,\le m-1}`), "、", math(String.raw`\kappa:=a^{\dagger}_{U,\le m-1}`), "、", math(String.raw`G:=\alpha\cdot_A\kappa`), " と置き、", math(String.raw`y^{U}_t`), " を ", ref("def_selected_creation_factor"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_selected_annihilation_factor"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`z:=z^{T}_m`), "、", math(String.raw`y:=y^{U}_m`), " と置く。準備として次の三つが成り立つ。（イ）", math(String.raw`P_{\le m}=P'\cdot_A x`), " であり（", ref("claim_initial_part_of_vacuum_element_splits_off_last_factor"), "）、", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`x\cdot_A x_j=x_j\cdot_A x`), " であるから（", ref("claim_vacuum_factors_with_different_numbers_commute"), "）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=x`), " と族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`x\cdot_A P'=P'\cdot_A x`), " である。（ロ）", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`a_m\cdot_A x_j=x_j\cdot_A a_m`), "、", math(String.raw`a^{\dagger}_m\cdot_A x_j=x_j\cdot_A a^{\dagger}_m`), " であるから（", ref("claim_annihilation_generator_commutes_with_other_number_pair"), "、", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`m,j`), " を当てる）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`a_m\cdot_A P'=P'\cdot_A a_m`), "、", math(String.raw`a^{\dagger}_m\cdot_A P'=P'\cdot_A a^{\dagger}_m`), " である。（ハ）次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A a^{\dagger}_{U,\le m}
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=\bigl(z\cdot_A\alpha\bigr)\cdot_A\bigl(\kappa\cdot_A y\bigr)
&&\left(\because\ \blkref{claim_initial_ordered_creation_product_splits_off_last_number}\right)\\
&=z\cdot_A\bigl(\alpha\cdot_A(\kappa\cdot_A y)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A\bigl((\alpha\cdot_A\kappa)\cdot_A y\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_A(G\cdot_A y)
&&\left(\because\ G\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([math(String.raw`m\in T`), "、", math(String.raw`m\in U`), " なので ", math(String.raw`z=a_m`), "、", math(String.raw`y=a^{\dagger}_m`), " である（", ref("def_selected_annihilation_factor"), "、", ref("def_selected_creation_factor"), "）。（ハ）により ", math(String.raw`a_{T,\le m}\cdot_A a^{\dagger}_{U,\le m}=a_m\cdot_A(G\cdot_A a^{\dagger}_m)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=\Bigl(P_{\le m}\cdot_A\bigl(a_m\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A P_{\le m}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\text{、（ハ）}\right)\\
&=\Bigl((P'\cdot_A x)\cdot_A\bigl(a_m\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（イ）の}\ P_{\le m}=P'\cdot_A x\ \text{を二か所に適用}\right)\\
&=\biggl(P'\cdot_A\Bigl(x\cdot_A\bigl(a_m\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\biggr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl((x\cdot_A a_m)\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(P'\cdot_A\bigl(a_m\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \blkref{claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator}\right)\\
&=\bigl((P'\cdot_A a_m)\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((a_m\cdot_A P')\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ \text{（ロ）}\right)\\
&=\Bigl(a_m\cdot_A\bigl(P'\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\Bigr)\cdot_A(P'\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl(\bigl(P'\cdot_A(G\cdot_A a^{\dagger}_m)\bigr)\cdot_A(P'\cdot_A x)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl(\bigl((P'\cdot_A G)\cdot_A a^{\dagger}_m\bigr)\cdot_A(P'\cdot_A x)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl(a^{\dagger}_m\cdot_A(P'\cdot_A x)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl((a^{\dagger}_m\cdot_A P')\cdot_A x\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl((P'\cdot_A a^{\dagger}_m)\cdot_A x\bigr)\Bigr)
&&\left(\because\ \text{（ロ）}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl(P'\cdot_A(a^{\dagger}_m\cdot_A x)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\Bigl((P'\cdot_A G)\cdot_A\bigl(P'\cdot_A a^{\dagger}_m\bigr)\Bigr)
&&\left(\because\ \blkref{claim_creation_generator_times_vacuum_factor_is_creation_generator}\right)\\
&=a_m\cdot_A\Bigl(\bigl((P'\cdot_A G)\cdot_A P'\bigr)\cdot_A a^{\dagger}_m\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_m\cdot_A\bigl(Q^{T,U}_{m-1}\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ G=\alpha\cdot_A\kappa\text{。}\blkref{def_vacuum_sandwich_of_initial_parts}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part",
    kind: "claim",
    title: { text: "番号が m 以下の元が同じ二つの部分集合では、番号が m 以下の部分を真空の因子で挟んだ元は、真空の因子の積である" },
    labels: ["claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、すべての ", math(String.raw`t\in\{1,\dots,m\}`), " について「", math(String.raw`t\in T`), " と ", math(String.raw`t\in U`), " が同値である」ならば、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=P_{\le m}`),
    ],
    proof: [
      paragraph([math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき、三つの元はどれも空の番号順の積である。"]),
      displayMath(String.raw`\begin{aligned}
a_{T,\le 0}
&=\prod_{A,\,k=1}^{0}z^{T}_{1-k}
&&\left(\because\ \blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\ \text{で}\ m:=0\right)\\
&=1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\ \text{の}\ \Pi_0\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_{U,\le 0}
&=\prod_{A,\,t=1}^{0}y^{U}_t
&&\left(\because\ \blkref{def_initial_ordered_product_of_selected_creation_generators}\ \text{で}\ m:=0\right)\\
&=1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\ \text{の}\ \Pi_0\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
P_{\le 0}
&=\prod_{A,\,i=1}^{0}x_i
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\ \text{で}\ m:=0\right)\\
&=1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\ \text{の}\ \Pi_0\right)
\end{aligned}`),
      paragraph(["これらを使って ", math(String.raw`Q^{T,U}_0`), " を開く。"]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_0
&=\bigl(P_{\le 0}\cdot_A(a_{T,\le 0}\cdot_A a^{\dagger}_{U,\le 0})\bigr)\cdot_A P_{\le 0}
&&\left(\because\ \blkref{def_vacuum_sandwich_of_initial_parts}\ \text{で}\ m:=0\right)\\
&=\bigl(1_A\cdot_A(1_A\cdot_A 1_A)\bigr)\cdot_A 1_A
&&\left(\because\ a_{T,\le 0}=1_A\text{、}a^{\dagger}_{U,\le 0}=1_A\text{、}P_{\le 0}=1_A\ \text{を代入}\right)\\
&=(1_A\cdot_A 1_A)\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=P_{\le 0}
&&\left(\because\ P_{\le 0}=1_A\right).
\end{aligned}`),
      paragraph([math(String.raw`1\le m\le M`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。すべての ", math(String.raw`t\in\{1,\dots,m\}`), " について「", math(String.raw`t\in T`), " と ", math(String.raw`t\in U`), " が同値である」とする。", math(String.raw`\{1,\dots,m-1\}\subseteq\{1,\dots,m\}`), " なので ", math(String.raw`m-1`), " でも同じ条件が成り立ち、帰納法の仮定により ", math(String.raw`Q^{T,U}_{m-1}=P_{\le m-1}`), " である。", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`x:=x_m`), " と置く。", math(String.raw`P_{\le m}=P'\cdot_A x`), " である（", ref("claim_initial_part_of_vacuum_element_splits_off_last_factor"), "）。", math(String.raw`t:=m`), " で条件を読むと、", math(String.raw`m\in T`), " と ", math(String.raw`m\in U`), " は同値なので、「", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\notin U`), "」か「", math(String.raw`m\in T`), " かつ ", math(String.raw`m\in U`), "」のどちらかである。前者のとき："]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=Q^{T,U}_{m-1}\cdot_A x
&&\left(\because\ \blkref{claim_vacuum_sandwich_when_last_number_is_in_neither_subset}\right)\\
&=P'\cdot_A x
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=P_{\le m}
&&\left(\because\ \blkref{claim_initial_part_of_vacuum_element_splits_off_last_factor}\ \text{を右辺から左辺へ読む}\right).
\end{aligned}`),
      paragraph(["後者のとき、", math(String.raw`j\in\{1,\dots,m-1\}`), " なら ", math(String.raw`j\neq m`), " なので ", math(String.raw`a^{\dagger}_m\cdot_A x_j=x_j\cdot_A a^{\dagger}_m`), "（", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`m,j`), " を当てる）と ", math(String.raw`x\cdot_A x_j=x_j\cdot_A x`), "（", ref("claim_vacuum_factors_with_different_numbers_commute"), "）が成り立つので、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて ", math(String.raw`a^{\dagger}_m\cdot_A P'=P'\cdot_A a^{\dagger}_m`), " と ", math(String.raw`x\cdot_A P'=P'\cdot_A x`), " が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=a_m\cdot_A\bigl(Q^{T,U}_{m-1}\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \blkref{claim_vacuum_sandwich_when_last_number_is_in_both_subsets}\right)\\
&=a_m\cdot_A\bigl(P'\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=a_m\cdot_A\bigl(a^{\dagger}_m\cdot_A P'\bigr)
&&\left(\because\ a^{\dagger}_m\cdot_A P'=P'\cdot_A a^{\dagger}_m\right)\\
&=\bigl(a_m\cdot_A a^{\dagger}_m\bigr)\cdot_A P'
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=x\cdot_A P'
&&\left(\because\ x=x_m\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=P'\cdot_A x
&&\left(\because\ x\cdot_A P'=P'\cdot_A x\right)\\
&=P_{\le m}
&&\left(\because\ \blkref{claim_initial_part_of_vacuum_element_splits_off_last_factor}\ \text{を右辺から左辺へ読む}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero",
    kind: "claim",
    title: { text: "番号が m 以下の元が異なる二つの部分集合では、番号が m 以下の部分を真空の因子で挟んだ元は零である" },
    labels: ["claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`T,U\in\mathcal{P}_M`), " とし、", math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"), "、", math(String.raw`a_{T,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_{U,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), " のものとする。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、「", math(String.raw`t\in T`), " かつ ", math(String.raw`t\notin U`), "」か「", math(String.raw`t\notin T`), " かつ ", math(String.raw`t\in U`), "」を満たす ", math(String.raw`t\in\{1,\dots,m\}`), " が存在するならば、次が成り立つ。"]),
      displayMath(String.raw`Q^{T,U}_m=0_A`),
    ],
    proof: [
      paragraph([math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき ", math(String.raw`\{1,\dots,0\}`), " は空集合なので、条件を満たす ", math(String.raw`t`), " は存在せず、主張は条件を満たす場合が無いので成り立つ。", math(String.raw`1\le m\le M`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。条件を満たす ", math(String.raw`t\in\{1,\dots,m\}`), " をとる。"]),
      paragraph([math(String.raw`t=m`), " のとき、「", math(String.raw`m\in T`), " かつ ", math(String.raw`m\notin U`), "」か「", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\in U`), "」が成り立つので、", math(String.raw`Q^{T,U}_m=0_A`), " である（", ref("claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset"), "）。"]),
      paragraph([math(String.raw`t\neq m`), " のとき、", math(String.raw`t\in\{1,\dots,m-1\}`), " なので ", math(String.raw`m-1`), " で条件が成り立ち、帰納法の仮定により ", math(String.raw`Q^{T,U}_{m-1}=0_A`), " である。番号 ", math(String.raw`m`), " については、「", math(String.raw`m`), " がちょうど一方に入る」「", math(String.raw`m\notin T`), " かつ ", math(String.raw`m\notin U`), "」「", math(String.raw`m\in T`), " かつ ", math(String.raw`m\in U`), "」のどれか一つが成り立つ。一つ目のときは ", ref("claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset"), " により ", math(String.raw`Q^{T,U}_m=0_A`), " である。二つ目のとき："]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=Q^{T,U}_{m-1}\cdot_A x_m
&&\left(\because\ \blkref{claim_vacuum_sandwich_when_last_number_is_in_neither_subset}\right)\\
&=0_A\cdot_A x_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right).
\end{aligned}`),
      paragraph(["三つ目のとき："]),
      displayMath(String.raw`\begin{aligned}
Q^{T,U}_m
&=a_m\cdot_A\bigl(Q^{T,U}_{m-1}\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \blkref{claim_vacuum_sandwich_when_last_number_is_in_both_subsets}\right)\\
&=a_m\cdot_A\bigl(0_A\cdot_A a^{\dagger}_m\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=a_m\cdot_A 0_A
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_vacuum_element_sandwich_of_annihilation_and_creation_products",
    kind: "claim",
    title: { text: "消滅の逆順の積と生成の積の積を真空への射影にあたる元で挟むと、二つの部分集合が等しいときだけ真空への射影にあたる元が残る" },
    labels: ["claim_vacuum_element_sandwich_of_annihilation_and_creation_products"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`a_T`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`a^{\dagger}_U`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のもの、", math(String.raw`\delta_{T,U}`), " を集合 ", math(String.raw`\mathcal{P}_M`), " の上のクロネッカーのデルタ（", ref("def_kronecker_delta"), "）とする。すべての ", math(String.raw`T,U\in\mathcal{P}_M`), " について次が成り立つ。"]),
      displayMath(String.raw`\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P=\delta_{T,U}\ast_A P`),
    ],
    proof: [
      paragraph([math(String.raw`Q^{T,U}_m`), " を ", ref("def_vacuum_sandwich_of_initial_parts"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), " のものとする。", math(String.raw`T=U`), " のとき、すべての ", math(String.raw`t\in\{1,\dots,M\}`), " について ", math(String.raw`t\in T`), " と ", math(String.raw`t\in U`), " は同値である。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P
&=Q^{T,U}_M
&&\left(\because\ \blkref{claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich}\ \text{を右辺から左辺へ読む}\right)\\
&=P_{\le M}
&&\left(\because\ m:=M\text{。}\blkref{claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part}\right)\\
&=P
&&\left(\because\ \blkref{claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element}\right)\\
&=1_{\mathbb{C}}\ast_A P
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{T,U}\ast_A P
&&\left(\because\ T=U\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([math(String.raw`T\neq U`), " のとき、集合の等しさ（", ref("def_power_set_of_first_m_positive_integers"), "）により、", math(String.raw`t\in T`), " と ", math(String.raw`t\in U`), " が同値でない ", math(String.raw`t\in\{1,\dots,M\}`), " が存在する。その ", math(String.raw`t`), " では「", math(String.raw`t\in T`), " かつ ", math(String.raw`t\notin U`), "」か「", math(String.raw`t\notin T`), " かつ ", math(String.raw`t\in U`), "」が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(P\cdot_A(a_T\cdot_A a^{\dagger}_U)\bigr)\cdot_A P
&=Q^{T,U}_M
&&\left(\because\ \blkref{claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich}\ \text{を右辺から左辺へ読む}\right)\\
&=0_A
&&\left(\because\ m:=M\text{。}\blkref{claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero}\right)\\
&=0_{\mathbb{C}}\ast_A P
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\delta_{T,U}\ast_A P
&&\left(\because\ T\neq U\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_selected_number_factor_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "部分集合に入るかどうかで選ぶ、番号ごとの生成と消滅の積" },
    labels: ["def_selected_number_factor_of_split_clifford_algebra"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`S\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）とする。", math(String.raw`i\in\{1,\dots,M\}`), " について、", math(String.raw`A`), " の元 ", math(String.raw`u^{S}_i`), " を次で定める（", math(String.raw`i\in S`), " の真偽は ", ref("def_power_set_of_first_m_positive_integers"), " により一つに決まる）。"]),
      displayMath(String.raw`u^{S}_i:=\begin{cases}a^{\dagger}_i\cdot_A a_i & (i\in S),\\ a_i\cdot_A a^{\dagger}_i & (i\notin S).\end{cases}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_vacuum_annihilation_factor_of_one_number",
    kind: "claim",
    title: { text: "一つの番号について、生成の因子と消滅と生成の積と消滅の因子をこの順に掛けると、部分集合で選んだ積になる" },
    labels: ["claim_creation_vacuum_annihilation_factor_of_one_number"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`x_i`), "（", math(String.raw`i\in\{1,\dots,M\}`), "）を ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のものとする。", math(String.raw`S\in\mathcal{P}_M`), " とし、", math(String.raw`y^{S}_t`), " を ", ref("def_selected_creation_factor"), "、", math(String.raw`z^{S}_t`), " を ", ref("def_selected_annihilation_factor"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`u^{S}_i`), " を ", ref("def_selected_number_factor_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\bigl(y^{S}_i\cdot_A x_i\bigr)\cdot_A z^{S}_i=u^{S}_i`),
    ],
    proof: [
      paragraph([math(String.raw`i\in S`), " のとき、", math(String.raw`y^{S}_i=a^{\dagger}_i`), "、", math(String.raw`z^{S}_i=a_i`), " である（", ref("def_selected_creation_factor"), "、", ref("def_selected_annihilation_factor"), "）。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(y^{S}_i\cdot_A x_i\bigr)\cdot_A z^{S}_i
&=\bigl(a^{\dagger}_i\cdot_A x_i\bigr)\cdot_A a_i
&&\left(\because\ y^{S}_i=a^{\dagger}_i\text{、}z^{S}_i=a_i\right)\\
&=a^{\dagger}_i\cdot_A a_i
&&\left(\because\ \blkref{claim_creation_generator_times_vacuum_factor_is_creation_generator}\right)\\
&=u^{S}_i
&&\left(\because\ i\in S\text{。}\blkref{def_selected_number_factor_of_split_clifford_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`i\notin S`), " のとき、", math(String.raw`y^{S}_i=1_A`), "、", math(String.raw`z^{S}_i=1_A`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(y^{S}_i\cdot_A x_i\bigr)\cdot_A z^{S}_i
&=\bigl(1_A\cdot_A x_i\bigr)\cdot_A 1_A
&&\left(\because\ y^{S}_i=z^{S}_i=1_A\right)\\
&=x_i\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=x_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A a^{\dagger}_i
&&\left(\because\ x_i\ \text{の置き方。}\blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=u^{S}_i
&&\left(\because\ i\notin S\text{。}\blkref{def_selected_number_factor_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors",
    kind: "claim",
    title: { text: "番号が m 以下の部分の生成の積と真空の因子の積と消滅の逆順の積の積は、部分集合で選んだ番号ごとの積の番号順の積である" },
    labels: ["claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`S\in\mathcal{P}_M`), " とし、", math(String.raw`a^{\dagger}_{S,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`a_{S,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`u^{S}_i`), " を ", ref("def_selected_number_factor_of_split_clifford_algebra"), " のものとする。すべての ", math(String.raw`m\in\{0,1,\dots,M\}`), " について、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した番号順の積（", ref("def_ordered_product_in_algebra"), "）について次が成り立つ。"]),
      displayMath(String.raw`\bigl(a^{\dagger}_{S,\le m}\cdot_A P_{\le m}\bigr)\cdot_A a_{S,\le m}=\prod_{A,\,i=1}^{m}u^{S}_i`),
    ],
    proof: [
      paragraph([math(String.raw`\Pi_m`), "（", math(String.raw`m\in\{0,1,\dots,M\}`), "）を、族 ", math(String.raw`u^{S}_1,\dots,u^{S}_M`), " について ", ref("def_ordered_product_in_algebra"), " で帰納的に定めた元とする（", math(String.raw`\Pi_0=1_A`), "、", math(String.raw`1\le m\le M`), " のとき ", math(String.raw`\Pi_m=\Pi_{m-1}\cdot_A u^{S}_m`), "）。", ref("claim_partial_product_is_ordered_product_of_restricted_family"), "（", math(String.raw`n:=M`), "）により、すべての ", math(String.raw`m`), " で ", math(String.raw`\prod_{A,\,i=1}^{m}u^{S}_i=\Pi_m`), " であるから、主張の右辺は ", math(String.raw`\Pi_m`), " である。", math(String.raw`y^{S}_t`), " を ", ref("def_selected_creation_factor"), "、", math(String.raw`z^{S}_t`), " を ", ref("def_selected_annihilation_factor"), " のもの（", math(String.raw`t\in\{1,\dots,M\}`), "）とする。", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき、三つの元はどれも空の番号順の積である。"]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_{S,\le 0}
&=\prod_{A,\,t=1}^{0}y^{S}_t
&&\left(\because\ \blkref{def_initial_ordered_product_of_selected_creation_generators}\ \text{で}\ m:=0\right)\\
&=1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\ \text{の}\ \Pi_0\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
P_{\le 0}
&=\prod_{A,\,i=1}^{0}x_i
&&\left(\because\ \blkref{def_initial_part_of_vacuum_element}\ \text{で}\ m:=0\right)\\
&=1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\ \text{の}\ \Pi_0\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a_{S,\le 0}
&=\prod_{A,\,k=1}^{0}z^{S}_{1-k}
&&\left(\because\ \blkref{def_initial_reverse_ordered_product_of_selected_annihilation_generators}\ \text{で}\ m:=0\right)\\
&=1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\ \text{の}\ \Pi_0\right)
\end{aligned}`),
      paragraph(["これらを使って主張の左辺を開く。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(a^{\dagger}_{S,\le 0}\cdot_A P_{\le 0}\bigr)\cdot_A a_{S,\le 0}
&=(1_A\cdot_A 1_A)\cdot_A 1_A
&&\left(\because\ a^{\dagger}_{S,\le 0}=1_A\text{、}P_{\le 0}=1_A\text{、}a_{S,\le 0}=1_A\ \text{を代入}\right)\\
&=1_A\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\Pi_0
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`1\le m\le M`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`\kappa:=a^{\dagger}_{S,\le m-1}`), "、", math(String.raw`P':=P_{\le m-1}`), "、", math(String.raw`\alpha:=a_{S,\le m-1}`), "、", math(String.raw`x:=x_m`), "、", math(String.raw`y:=y^{S}_m`), "、", math(String.raw`z:=z^{S}_m`), "、", math(String.raw`u:=u^{S}_m`), " と置く（", math(String.raw`x_m`), " は ", ref("def_vacuum_factor_of_split_clifford_algebra"), " のもの）。準備として次の二つが成り立つ。", math(String.raw`1_A`), " はどの元とも交換する（", ref("def_unital_ring"), " の乗法の単位元）。"]),
      paragraph(["（イ）", math(String.raw`y\cdot_A P'=P'\cdot_A y`), "。", math(String.raw`j\in\{1,\dots,m-1\}`), " とする。", math(String.raw`m\in S`), " なら ", math(String.raw`y=a^{\dagger}_m`), " であり、", math(String.raw`m\neq j`), " なので ", math(String.raw`y\cdot_A x_j=x_j\cdot_A y`), " である（", ref("claim_creation_generator_commutes_with_other_number_pair"), " の ", math(String.raw`i,j`), " に ", math(String.raw`m,j`), " を当てる）。", math(String.raw`m\notin S`), " なら ", math(String.raw`y=1_A`), " である。したがって ", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=y`), " と族 ", math(String.raw`x_1,\dots,x_{m-1}`), " に当てて（イ）を得る。"]),
      paragraph(["（ロ）", math(String.raw`u\cdot_A\alpha=\alpha\cdot_A u`), "。", math(String.raw`\alpha`), " の因子は ", math(String.raw`z^{S}_{m-k}`), "（", math(String.raw`k\in\{1,\dots,m-1\}`), "）であり、", math(String.raw`t:=m-k\in\{1,\dots,m-1\}`), " なので ", math(String.raw`t\neq m`), " である。", math(String.raw`t\in S`), " なら ", math(String.raw`z^{S}_t=a_t`), " であり、", math(String.raw`u=a^{\dagger}_m\cdot_A a_m`), " のとき ", ref("claim_annihilation_generator_commutes_with_other_number_reversed_pair"), "、", math(String.raw`u=a_m\cdot_A a^{\dagger}_m`), " のとき ", ref("claim_annihilation_generator_commutes_with_other_number_pair"), " を ", math(String.raw`i,j`), " に ", math(String.raw`t,m`), " を当てて、", math(String.raw`a_t\cdot_A u=u\cdot_A a_t`), " である。", math(String.raw`t\notin S`), " なら ", math(String.raw`z^{S}_t=1_A`), " である。したがって ", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u`), " と ", math(String.raw`\alpha`), " を定める族に当てて（ロ）を得る。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(a^{\dagger}_{S,\le m}\cdot_A P_{\le m}\bigr)\cdot_A a_{S,\le m}
&=\bigl((\kappa\cdot_A y)\cdot_A P_{\le m}\bigr)\cdot_A a_{S,\le m}
&&\left(\because\ \blkref{claim_initial_ordered_creation_product_splits_off_last_number}\right)\\
&=\bigl((\kappa\cdot_A y)\cdot_A(P'\cdot_A x)\bigr)\cdot_A a_{S,\le m}
&&\left(\because\ \blkref{claim_initial_part_of_vacuum_element_splits_off_last_factor}\right)\\
&=\bigl((\kappa\cdot_A y)\cdot_A(P'\cdot_A x)\bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_splits_off_last_number}\right)\\
&=\Bigl(\kappa\cdot_A\bigl(y\cdot_A(P'\cdot_A x)\bigr)\Bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\kappa\cdot_A\bigl((y\cdot_A P')\cdot_A x\bigr)\Bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\kappa\cdot_A\bigl((P'\cdot_A y)\cdot_A x\bigr)\Bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ \text{（イ）}\right)\\
&=\Bigl(\kappa\cdot_A\bigl(P'\cdot_A(y\cdot_A x)\bigr)\Bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((\kappa\cdot_A P')\cdot_A(y\cdot_A x)\bigr)\cdot_A(z\cdot_A\alpha)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(\kappa\cdot_A P')\cdot_A\bigl((y\cdot_A x)\cdot_A(z\cdot_A\alpha)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(\kappa\cdot_A P')\cdot_A\Bigl(\bigl((y\cdot_A x)\cdot_A z\bigr)\cdot_A\alpha\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(\kappa\cdot_A P')\cdot_A(u\cdot_A\alpha)
&&\left(\because\ i:=m\text{。}\blkref{claim_creation_vacuum_annihilation_factor_of_one_number}\right)\\
&=(\kappa\cdot_A P')\cdot_A(\alpha\cdot_A u)
&&\left(\because\ \text{（ロ）}\right)\\
&=\bigl((\kappa\cdot_A P')\cdot_A\alpha\bigr)\cdot_A u
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Pi_{m-1}\cdot_A u
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\Pi_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_sum_over_subsets_of_selected_products_is_product_of_sums",
    kind: "claim",
    title: { text: "部分集合ごとに因子を選んだ番号順の積を、部分集合の 2 進の番号付けの順に足すと、因子の和の番号順の積になる" },
    labels: ["claim_sum_over_subsets_of_selected_products_is_product_of_sums"],
    statement: [
      paragraph([math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`M\in\mathbb{Z}_{\ge 0}`), " とし、", math(String.raw`\{1,\dots,M\}`), " の各元 ", math(String.raw`i`), " に ", math(String.raw`B`), " の元 ", math(String.raw`g_i`), " と ", math(String.raw`h_i`), " が一つずつ与えられているとする。", math(String.raw`S\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）と ", math(String.raw`i\in\{1,\dots,M\}`), " について、", math(String.raw`B`), " の元 ", math(String.raw`v^{S}_i`), " を、", math(String.raw`i\in S`), " なら ", math(String.raw`v^{S}_i:=g_i`), "、", math(String.raw`i\notin S`), " なら ", math(String.raw`v^{S}_i:=h_i`), " と定める。", math(String.raw`m\in\{0,1,\dots,M\}`), " について、", math(String.raw`2^m`), " と ", math(String.raw`e_m:\{1,\dots,2^m\}\to\mathcal{P}_m`), " を ", ref("def_binary_numbering_of_power_set"), " のものとする。", math(String.raw`\{1,\dots,m\}\subseteq\{1,\dots,M\}`), " なので ", math(String.raw`\mathcal{P}_m\subseteq\mathcal{P}_M`), " であり、", math(String.raw`v^{e_m(k)}_i`), " は定まる。このとき、すべての ", math(String.raw`m\in\{0,1,\dots,M\}`), " について、", math(String.raw`U_{\mathrm{vec}}(B)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の線型結合（", ref("def_linear_combination"), "）と、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した番号順の積（", ref("def_ordered_product_in_algebra"), "）について次が成り立つ。"]),
      displayMath(String.raw`\sum_{k=1}^{2^m}1_{\mathbb{C}}\ast_B\prod_{B,\,i=1}^{m}v^{e_m(k)}_i=\prod_{B,\,i=1}^{m}\bigl(h_i+_B g_i\bigr)`),
    ],
    proof: [
      paragraph([math(String.raw`S\in\mathcal{P}_M`), " と ", math(String.raw`m\in\{0,1,\dots,M\}`), " について ", math(String.raw`F_m(S):=\prod_{B,\,i=1}^{m}v^{S}_i`), "、", math(String.raw`\Pi_m:=\prod_{B,\,i=1}^{m}(h_i+_B g_i)`), " と置く。", math(String.raw`F_0(S)=1_B`), "、", math(String.raw`\Pi_0=1_B`), " である（", ref("def_ordered_product_in_algebra"), "）。", ref("claim_partial_product_is_ordered_product_of_restricted_family"), "（", math(String.raw`n:=M`), "）により、", math(String.raw`F_m(S)`), " と ", math(String.raw`\Pi_m`), " は族 ", math(String.raw`v^{S}_1,\dots,v^{S}_M`), " と族 ", math(String.raw`h_1+_B g_1,\dots,h_M+_B g_M`), " の ", ref("def_ordered_product_in_algebra"), " の帰納的な定義の ", math(String.raw`m`), " 番目の元に等しいので、", math(String.raw`1\le m\le M`), " のとき ", math(String.raw`F_m(S)=F_{m-1}(S)\cdot_B v^{S}_m`), "、", math(String.raw`\Pi_m=\Pi_{m-1}\cdot_B(h_m+_B g_m)`), " である。", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき、", math(String.raw`2^0=1`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{1}1_{\mathbb{C}}\ast_B F_0\bigl(e_0(k)\bigr)
&=0_B+_B\Bigl(1_{\mathbb{C}}\ast_B F_0\bigl(e_0(1)\bigr)\Bigr)
&&\left(\because\ \blkref{def_linear_combination}\right)\\
&=0_B+_B\bigl(1_{\mathbb{C}}\ast_B 1_B\bigr)
&&\left(\because\ F_0\bigl(e_0(1)\bigr)=1_B\right)\\
&=0_B+_B 1_B
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=1_B+_B 0_B
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=1_B
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=\Pi_0
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`1\le m\le M`), " とし、", math(String.raw`m-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`n:=2^{m-1}`), " と置くと、", math(String.raw`2^m=2\cdot n=n+n`), " である（", ref("def_binary_numbering_of_power_set"), "）。準備として次の三つが成り立つ。"]),
      paragraph(["（イ）", math(String.raw`k\in\{1,\dots,n\}`), " について次が成り立つ。", math(String.raw`k\le 2^{m-1}`), " なので ", math(String.raw`e_m(k)=e_{m-1}(k)`), " であり（", ref("def_binary_numbering_of_power_set"), "）、", math(String.raw`e_{m-1}(k)\subseteq\{1,\dots,m-1\}`), " なので ", math(String.raw`m\notin e_m(k)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
F_m\bigl(e_m(k)\bigr)
&=F_{m-1}\bigl(e_m(k)\bigr)\cdot_B v^{e_m(k)}_m
&&\left(\because\ F_m\ \text{の漸化式}\right)\\
&=F_{m-1}\bigl(e_m(k)\bigr)\cdot_B h_m
&&\left(\because\ m\notin e_m(k)\text{。}v\ \text{の定め方}\right)\\
&=F_{m-1}\bigl(e_{m-1}(k)\bigr)\cdot_B h_m
&&\left(\because\ e_m(k)=e_{m-1}(k)\right).
\end{aligned}`),
      paragraph(["（ロ）", math(String.raw`j\in\{1,\dots,n\}`), " について次が成り立つ。", math(String.raw`n<n+j\le 2^m`), " なので ", math(String.raw`e_m(n+j)=e_{m-1}(j)\cup\{m\}`), " である（", ref("def_binary_numbering_of_power_set"), "）。", math(String.raw`i\in\{1,\dots,m-1\}`), " なら ", math(String.raw`i\neq m`), " なので、", math(String.raw`i\in e_m(n+j)`), " と ", math(String.raw`i\in e_{m-1}(j)`), " は同値であり、", math(String.raw`v^{e_m(n+j)}_i=v^{e_{m-1}(j)}_i`), " である。また ", math(String.raw`m\in e_m(n+j)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
F_m\bigl(e_m(n+j)\bigr)
&=F_{m-1}\bigl(e_m(n+j)\bigr)\cdot_B v^{e_m(n+j)}_m
&&\left(\because\ F_m\ \text{の漸化式}\right)\\
&=F_{m-1}\bigl(e_m(n+j)\bigr)\cdot_B g_m
&&\left(\because\ m\in e_m(n+j)\text{。}v\ \text{の定め方}\right)\\
&=F_{m-1}\bigl(e_{m-1}(j)\bigr)\cdot_B g_m
&&\left(\because\ \text{各}\ i\in\{1,\dots,m-1\}\ \text{で}\ v^{e_m(n+j)}_i=v^{e_{m-1}(j)}_i\text{。}\blkref{claim_ordered_products_with_equal_factors_are_equal}\right).
\end{aligned}`),
      paragraph(["（ハ）", math(String.raw`r\in B`), " について、右から ", math(String.raw`r`), " を掛ける写像は ", math(String.raw`U_{\mathrm{vec}}(B)`), " から ", math(String.raw`U_{\mathrm{vec}}(B)`), " への線型写像である（", ref("claim_right_multiplication_in_algebra_is_linear_map"), "）。したがって ", ref("claim_linear_map_maps_linear_combination_to_linear_combination_of_values"), " により、", math(String.raw`\{1,\dots,n\}`), " の上の ", math(String.raw`B`), " の元の族 ", math(String.raw`X_k`), " について ", math(String.raw`\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B(X_k\cdot_B r)=\bigl(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B X_k\bigr)\cdot_B r`), " である。"]),
      paragraph(["帰納法の仮定は ", math(String.raw`\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B F_{m-1}(e_{m-1}(k))=\Pi_{m-1}`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{2^m}1_{\mathbb{C}}\ast_B F_m\bigl(e_m(k)\bigr)
&=\left(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B F_m\bigl(e_m(k)\bigr)\right)+_B\left(\sum_{j=1}^{n}1_{\mathbb{C}}\ast_B F_m\bigl(e_m(n+j)\bigr)\right)
&&\left(\because\ 2^m=n+n\text{、}n':=n\text{。}\blkref{claim_splitting_linear_combination_into_first_and_last_terms}\right)\\
&=\left(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B\Bigl(F_{m-1}\bigl(e_{m-1}(k)\bigr)\cdot_B h_m\Bigr)\right)+_B\left(\sum_{j=1}^{n}1_{\mathbb{C}}\ast_B F_m\bigl(e_m(n+j)\bigr)\right)
&&\left(\because\ \text{各}\ k\ \text{で（イ）。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\left(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B\Bigl(F_{m-1}\bigl(e_{m-1}(k)\bigr)\cdot_B h_m\Bigr)\right)+_B\left(\sum_{j=1}^{n}1_{\mathbb{C}}\ast_B\Bigl(F_{m-1}\bigl(e_{m-1}(j)\bigr)\cdot_B g_m\Bigr)\right)
&&\left(\because\ \text{各}\ j\ \text{で（ロ）。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\left(\left(\sum_{k=1}^{n}1_{\mathbb{C}}\ast_B F_{m-1}\bigl(e_{m-1}(k)\bigr)\right)\cdot_B h_m\right)+_B\left(\left(\sum_{j=1}^{n}1_{\mathbb{C}}\ast_B F_{m-1}\bigl(e_{m-1}(j)\bigr)\right)\cdot_B g_m\right)
&&\left(\because\ \text{（ハ）を}\ r:=h_m\ \text{と}\ r:=g_m\ \text{の二か所に適用}\right)\\
&=\bigl(\Pi_{m-1}\cdot_B h_m\bigr)+_B\bigl(\Pi_{m-1}\cdot_B g_m\bigr)
&&\left(\because\ \text{帰納法の仮定を二か所に適用}\right)\\
&=\Pi_{m-1}\cdot_B\bigl(h_m+_B g_m\bigr)
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の分配法則（左の因子が共通）。}\blkref{def_unital_ring}\right)\\
&=\Pi_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_decomposition_of_unity_in_split_clifford_algebra",
    kind: "claim",
    title: { text: "生成の積と真空への射影にあたる元と消滅の逆順の積の積を、部分集合全体の上で足すと 1 になる" },
    labels: ["claim_decomposition_of_unity_in_split_clifford_algebra"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`a^{\dagger}_S`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a_S`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`P`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`\mathcal{P}_M`), " は有限集合である（", ref("claim_binary_numbering_is_numbering_of_power_set"), "）。", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "）について次が成り立つ。"]),
      displayMath(String.raw`\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)=1_A`),
    ],
    proof: [
      paragraph([math(String.raw`u^{S}_i`), " を ", ref("def_selected_number_factor_of_split_clifford_algebra"), " のものとする。準備として次の四つが成り立つ。"]),
      paragraph(["（イ）", math(String.raw`S\in\mathcal{P}_M`), " について次が成り立つ。", math(String.raw`a^{\dagger}_{S,\le m}`), " を ", ref("def_initial_ordered_product_of_selected_creation_generators"), "、", math(String.raw`P_{\le m}`), " を ", ref("def_initial_part_of_vacuum_element"), "、", math(String.raw`a_{S,\le m}`), " を ", ref("def_initial_reverse_ordered_product_of_selected_annihilation_generators"), " のものとする。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S
&=\bigl(a^{\dagger}_{S,\le M}\cdot_A P\bigr)\cdot_A a_S
&&\left(\because\ \blkref{claim_initial_ordered_creation_product_up_to_last_number_is_whole_product}\ \text{を右辺から左辺へ読む}\right)\\
&=\bigl(a^{\dagger}_{S,\le M}\cdot_A P_{\le M}\bigr)\cdot_A a_S
&&\left(\because\ \blkref{claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element}\ \text{を右辺から左辺へ読む}\right)\\
&=\bigl(a^{\dagger}_{S,\le M}\cdot_A P_{\le M}\bigr)\cdot_A a_{S,\le M}
&&\left(\because\ \blkref{claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product}\ \text{を右辺から左辺へ読む}\right)\\
&=\prod_{A,\,i=1}^{M}u^{S}_i
&&\left(\because\ m:=M\text{。}\blkref{claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors}\right).
\end{aligned}`),
      paragraph(["（ロ）", ref("claim_sum_over_subsets_of_selected_products_is_product_of_sums"), " を ", math(String.raw`B:=A`), "、", math(String.raw`g_i:=a^{\dagger}_i\cdot_A a_i`), "、", math(String.raw`h_i:=a_i\cdot_A a^{\dagger}_i`), "、", math(String.raw`m:=M`), " で当てる。このとき ", ref("def_selected_number_factor_of_split_clifford_algebra"), " により ", math(String.raw`v^{S}_i=u^{S}_i`), " である。"]),
      paragraph(["（ハ）", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(a_i\cdot_A a^{\dagger}_i\bigr)+_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)
&=\delta_{i,i}\ast_A 1_A
&&\left(\because\ j:=i\text{。}\blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=1_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=1_A
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["（ニ）すべての因子が ", math(String.raw`1_A`), " の番号順の積は ", math(String.raw`1_A`), " である。", math(String.raw`\Pi_m`), "（", math(String.raw`m\in\{0,1,\dots,M\}`), "）を、すべての番号で ", math(String.raw`1_A`), " をとる族について ", ref("def_ordered_product_in_algebra"), " で帰納的に定めた元とし、", math(String.raw`\Pi_m=1_A`), " を ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`\Pi_0=1_A`), " である（", ref("def_ordered_product_in_algebra"), "）。", math(String.raw`1\le m\le M`), " とし、", math(String.raw`\Pi_{m-1}=1_A`), " とする（帰納法の仮定）。"]),
      displayMath(String.raw`\begin{aligned}
\Pi_m
&=\Pi_{m-1}\cdot_A 1_A
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi_{m-1}
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A
&&\left(\because\ \text{帰納法の仮定}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\prod_{A,\,i=1}^{M}u^{S}_i
&&\left(\because\ \text{（イ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{k=1}^{2^M}1_{\mathbb{C}}\ast_A\prod_{A,\,i=1}^{M}u^{e_M(k)}_i
&&\left(\because\ \text{番号付け}\ (2^M,e_M)\text{。}\blkref{claim_binary_numbering_is_numbering_of_power_set}\text{、}\blkref{def_sum_over_finite_set}\right)\\
&=\prod_{A,\,i=1}^{M}\Bigl(\bigl(a_i\cdot_A a^{\dagger}_i\bigr)+_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)\Bigr)
&&\left(\because\ \text{（ロ）。}\blkref{claim_sum_over_subsets_of_selected_products_is_product_of_sums}\right)\\
&=\prod_{A,\,i=1}^{M}1_A
&&\left(\because\ \text{各}\ i\ \text{で（ハ）。}\blkref{claim_ordered_products_with_equal_factors_are_equal}\right)\\
&=\Pi_M
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=1_A
&&\left(\because\ \text{（ニ）で}\ m:=M\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_homomorphism_from_matrix_algebra_to_clifford_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "行列環からクリフォード代数への準同型" },
    labels: [],
  },
  {
    id: "isomorphism_definition_matrix_unit_element_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "行列単位にあたる元" },
    labels: ["def_matrix_unit_element_of_split_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(V,q)`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_S`), " を ",
        ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a_T`), " を ", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、",
        math(String.raw`P`), " を ", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。",
        math(String.raw`S,T\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）について、", math(String.raw`A`), " の元 ", math(String.raw`\mathcal{E}_{S,T}`),
        " を次で定める。",
      ]),
      displayMath(String.raw`\mathcal{E}_{S,T}:=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_T`),
      paragraph([
        math(String.raw`\mathcal{E}_{S,T}`), " を行列単位にあたる元と呼ぶ。", math(String.raw`\mathcal{E}_{S,T}`), " は ", math(String.raw`A`), " の元であり、", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元である行列単位 ", math(String.raw`E_{S,T}`), "（", ref("def_matrix_unit"), "）とは別の記号である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_product_of_matrix_unit_elements_of_split_clifford_algebra",
    kind: "claim",
    title: { text: "行列単位にあたる元の積の規則" },
    labels: ["claim_product_of_matrix_unit_elements_of_split_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`\mathcal{E}_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), " のものとし、",
        math(String.raw`\delta_{T,U}`), " を集合 ", math(String.raw`\mathcal{P}_M`), " の上のクロネッカーのデルタ（", ref("def_kronecker_delta"), "）とする。すべての ",
        math(String.raw`S,T,U,R\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\mathcal{E}_{S,T}\cdot_A \mathcal{E}_{U,R}=\delta_{T,U}\ast_A \mathcal{E}_{S,R}`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\mathcal{E}_{S,T}\cdot_A \mathcal{E}_{U,R}
&=\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_T\Bigr)\cdot_A\Bigl(\bigl(a^{\dagger}_U\cdot_A P\bigr)\cdot_A a_R\Bigr)
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\Bigl(a_T\cdot_A\Bigl(\bigl(a^{\dagger}_U\cdot_A P\bigr)\cdot_A a_R\Bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\Bigl(\Bigl(a_T\cdot_A\bigl(a^{\dagger}_U\cdot_A P\bigr)\Bigr)\cdot_A a_R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\Bigl(\Bigl(\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\cdot_A P\Bigr)\cdot_A a_R\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\Bigl(\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\cdot_A P\Bigr)\Bigr)\cdot_A a_R
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(a^{\dagger}_S\cdot_A\Bigl(P\cdot_A\Bigl(\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\cdot_A P\Bigr)\Bigr)\Bigr)\cdot_A a_R
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(a^{\dagger}_S\cdot_A\Bigl(\Bigl(P\cdot_A\bigl(a_T\cdot_A a^{\dagger}_U\bigr)\Bigr)\cdot_A P\Bigr)\Bigr)\cdot_A a_R
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(a^{\dagger}_S\cdot_A\bigl(\delta_{T,U}\ast_A P\bigr)\Bigr)\cdot_A a_R
&&\left(\because\ \blkref{claim_vacuum_element_sandwich_of_annihilation_and_creation_products}\right)\\
&=\Bigl(\delta_{T,U}\ast_A\bigl(a^{\dagger}_S\cdot_A P\bigr)\Bigr)\cdot_A a_R
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\delta_{T,U}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_R\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\delta_{T,U}\ast_A \mathcal{E}_{S,R}
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_from_matrix_algebra_to_clifford_algebra",
    kind: "definition",
    title: { text: "行列環からクリフォード代数への写像" },
    labels: ["def_homomorphism_from_matrix_algebra_to_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`\mathcal{E}_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"),
        " のものとし、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), "（", ref("def_matrices_indexed_by_finite_set"), "。", math(String.raw`\mathcal{P}_M`),
        " が有限集合であることは ", ref("claim_binary_numbering_is_numbering_of_power_set"), "）と書く。写像 ", math(String.raw`\Psi:B\to A`), " を、", math(String.raw`F\in B`),
        " について、", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の有限集合の上の和（",
        ref("def_sum_over_finite_set"), "）で次のように定める。",
      ]),
      displayMath(String.raw`\Psi(F):=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\right)`),
      paragraph([
        "内側の和は、", math(String.raw`S`), " を固定して ", math(String.raw`T\in\mathcal{P}_M`), " に係数 ", math(String.raw`F_{S,T}\in\mathbb{C}`), " と元 ",
        math(String.raw`\mathcal{E}_{S,T}\in A`), " を与えた族の和であり、外側の和は、", math(String.raw`S\in\mathcal{P}_M`), " にその内側の和と係数 ", math(String.raw`1_{\mathbb{C}}`),
        " を与えた族の和である。どちらの和も ", math(String.raw`\mathcal{P}_M`), " の番号付けの取り方によらず ", math(String.raw`A`), " の元として一つに決まる（",
        ref("def_sum_over_finite_set"), "）ので、", math(String.raw`\Psi(F)`), " は ", math(String.raw`A`), " の元として一つに決まる。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への写像は線型写像である" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`A`), "、", math(String.raw`B`), "、", math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとする。",
        math(String.raw`\Psi`), " は ℂ-線型空間 ", math(String.raw`(B,+_B,\ast_B,0_B)`), "（", ref("claim_matrices_indexed_by_finite_set_form_complex_vector_space"), "。",
        math(String.raw`+_B,\ \ast_B,\ 0_B`), " は ", ref("def_matrices_indexed_by_finite_set"), " の ", math(String.raw`+_{\mathrm{Mat}_{\mathcal{P}_M}},\ \ast_{\mathrm{Mat}_{\mathcal{P}_M}},\ 0_{\mathrm{Mat}_{\mathcal{P}_M}}`),
        "）から ", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`F,G\in B`), "、", math(String.raw`\rho\in\mathbb{C}`), " を任意にとる。和はすべて ", math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ",
        math(String.raw`\mathcal{P}_M`), "（2 進の番号付けをもつ。", ref("claim_binary_numbering_is_numbering_of_power_set"), "）の上の和（", ref("def_sum_over_finite_set"), "）である。準備として次の三つが成り立つ。",
      ]),
      paragraph([
        "（イ）", math(String.raw`S\in\mathcal{P}_M`), " について、", ref("claim_sum_of_sums_over_finite_set_with_same_family"), " を ", math(String.raw`X:=\mathcal{P}_M`), "、",
        math(String.raw`v_T:=\mathcal{E}_{S,T}`), "、", math(String.raw`\lambda_T:=F_{S,T}`), "、", math(String.raw`\mu_T:=G_{S,T}`), " に当て、右辺から左辺へ読んで、",
        math(String.raw`\sum_{T\in\mathcal{P}_M}(F_{S,T}+_{\mathbb{C}}G_{S,T})\ast_A \mathcal{E}_{S,T}=\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)+_A\Bigl(\sum_{T\in\mathcal{P}_M}G_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)`),
        "。",
      ]),
      paragraph([
        "（ロ）", math(String.raw`S\in\mathcal{P}_M`), " について、", ref("claim_scalar_multiple_of_sum_over_finite_set"), " を ", math(String.raw`X:=\mathcal{P}_M`), "、",
        math(String.raw`v_T:=\mathcal{E}_{S,T}`), "、", math(String.raw`\lambda_T:=F_{S,T}`), " に当て、右辺から左辺へ読んで、",
        math(String.raw`\sum_{T\in\mathcal{P}_M}(\rho\cdot_{\mathbb{C}}F_{S,T})\ast_A \mathcal{E}_{S,T}=\rho\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)`), "。",
      ]),
      paragraph(["（ハ）", math(String.raw`a\in A`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\ast_A(\rho\ast_A a)
&=(1_{\mathbb{C}}\cdot_{\mathbb{C}}\rho)\ast_A a
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(\rho\cdot_{\mathbb{C}}1_{\mathbb{C}})\ast_A a
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Psi(F+_B G)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(F+_B G)_{S,T}\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(F_{S,T}+_{\mathbb{C}}G_{S,T})\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ \text{行列の和の定義。}\blkref{def_matrices_indexed_by_finite_set}\text{、}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)+_A\Bigl(\sum_{T\in\mathcal{P}_M}G_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)\right)
&&\left(\because\ \text{各}\ S\ \text{で（イ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)\right)+_A\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}G_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)\right)
&&\left(\because\ \lambda_S:=1_{\mathbb{C}}\ \text{として右辺から左辺へ読む。}\blkref{claim_sum_of_sums_over_finite_set_with_same_coefficients}\right)\\
&=\Psi(F)+_A\Psi(G)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right),\\[4pt]
\Psi(\rho\ast_B F)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(\rho\ast_B F)_{S,T}\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(\rho\cdot_{\mathbb{C}}F_{S,T})\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ \text{行列のスカラー倍の定義。}\blkref{def_matrices_indexed_by_finite_set}\text{、}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\rho\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)\right)
&&\left(\because\ \text{各}\ S\ \text{で（ロ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{S\in\mathcal{P}_M}(\rho\cdot_{\mathbb{C}}1_{\mathbb{C}})\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)
&&\left(\because\ \text{各}\ S\ \text{で（ハ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\rho\ast_A\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)\right)
&&\left(\because\ \lambda_S:=1_{\mathbb{C}}\ \text{として右辺から左辺へ読む。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=\rho\ast_A\Psi(F)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right).
\end{aligned}`),
      paragraph([
        "二つの等式は線型写像の二つの条件（", ref("def_linear_map"), "）である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への写像は、行列単位を行列単位にあたる元へ移す" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit"],
    statement: [
      paragraph([
        math(String.raw`A`), "、", math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "、", math(String.raw`\mathcal{E}_{S,T}`), " を ",
        ref("def_matrix_unit_element_of_split_clifford_algebra"), " のものとし、", math(String.raw`E_{S,T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " を行列単位（",
        ref("def_matrix_unit"), "）とする。すべての ", math(String.raw`S,T\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi(E_{S,T})=\mathcal{E}_{S,T}`),
    ],
    proof: [
      paragraph([
        "和はすべて ", math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ", math(String.raw`\mathcal{P}_M`), "（2 進の番号付けをもつ。", ref("claim_binary_numbering_is_numbering_of_power_set"), "）の上の和（", ref("def_sum_over_finite_set"), "）、", math(String.raw`\delta`), " は ",
        math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。準備として次の三つが成り立つ。",
      ]),
      paragraph(["（イ）", math(String.raw`S',T'\in\mathcal{P}_M`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
(E_{S,T})_{S',T'}\ast_A \mathcal{E}_{S',T'}
&=\bigl(\delta_{S,S'}\cdot_{\mathbb{C}}\delta_{T,T'}\bigr)\ast_A \mathcal{E}_{S',T'}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=\bigl(\delta_{T,T'}\cdot_{\mathbb{C}}\delta_{S,S'}\bigr)\ast_A \mathcal{E}_{S',T'}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{T,T'}\ast_A\bigl(\delta_{S,S'}\ast_A \mathcal{E}_{S',T'}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "（ロ）", math(String.raw`S'\in\mathcal{P}_M`), " について、", ref("claim_sum_over_finite_set_with_kronecker_delta_picks_term"), " を、主張の ", math(String.raw`x`), " に ",
        math(String.raw`T`), "、和の変数に ", math(String.raw`T'`), "、", math(String.raw`v_{T'}:=\delta_{S,S'}\ast_A \mathcal{E}_{S',T'}`), " を当てて、",
        math(String.raw`\sum_{T'\in\mathcal{P}_M}\delta_{T,T'}\ast_A\bigl(\delta_{S,S'}\ast_A \mathcal{E}_{S',T'}\bigr)=\delta_{S,S'}\ast_A \mathcal{E}_{S',T}`), "。",
      ]),
      paragraph(["（ハ）", math(String.raw`S'\in\mathcal{P}_M`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\ast_A\bigl(\delta_{S,S'}\ast_A \mathcal{E}_{S',T}\bigr)
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{S,S'}\bigr)\ast_A \mathcal{E}_{S',T}
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{S,S'}\ast_A \mathcal{E}_{S',T}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Psi(E_{S,T})
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T'\in\mathcal{P}_M}(E_{S,T})_{S',T'}\ast_A \mathcal{E}_{S',T'}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T'\in\mathcal{P}_M}\delta_{T,T'}\ast_A\bigl(\delta_{S,S'}\ast_A \mathcal{E}_{S',T'}\bigr)\right)
&&\left(\because\ \text{各}\ S',T'\ \text{で（イ）。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\bigl(\delta_{S,S'}\ast_A \mathcal{E}_{S',T}\bigr)
&&\left(\because\ \text{各}\ S'\ \text{で（ロ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{S'\in\mathcal{P}_M}\delta_{S,S'}\ast_A \mathcal{E}_{S',T}
&&\left(\because\ \text{各}\ S'\ \text{で（ハ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\mathcal{E}_{S,T}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ S\text{、和の変数に}\ S'\text{、}v_{S'}:=\mathcal{E}_{S',T}\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への写像は、行列単位どうしの積を保つ" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units"],
    statement: [
      paragraph([
        math(String.raw`A`), "、", math(String.raw`B`), "、", math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとし、",
        math(String.raw`E_{S,T}\in B`), " を行列単位（", ref("def_matrix_unit"), "）、", math(String.raw`\cdot_B`), " を行列の積（", ref("def_matrices_indexed_by_finite_set"),
        "）とする。すべての ", math(String.raw`S,T,U,R\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi\bigl(E_{S,T}\cdot_B E_{U,R}\bigr)=\Psi(E_{S,T})\cdot_A\Psi(E_{U,R})`),
    ],
    proof: [
      paragraph([
        math(String.raw`\delta_{T,U}`), " は ", math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）、",
        math(String.raw`\mathcal{E}_{S,T}`), " は ", ref("def_matrix_unit_element_of_split_clifford_algebra"), " のものである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi\bigl(E_{S,T}\cdot_B E_{U,R}\bigr)
&=\Psi\bigl(\delta_{T,U}\ast_B E_{S,R}\bigr)
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_product_of_matrix_units}\right)\\
&=\delta_{T,U}\ast_A\Psi(E_{S,R})
&&\left(\because\ \Psi\ \text{はスカラー倍を保つ。}\blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map}\right)\\
&=\delta_{T,U}\ast_A \mathcal{E}_{S,R}
&&\left(\because\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit}\right)\\
&=\mathcal{E}_{S,T}\cdot_A \mathcal{E}_{U,R}
&&\left(\because\ \blkref{claim_product_of_matrix_unit_elements_of_split_clifford_algebra}\right)\\
&=\Psi(E_{S,T})\cdot_A\Psi(E_{U,R})
&&\left(\because\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への写像は ℂ-代数の準同型である" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`A`), "、", math(String.raw`B`), "、", math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとする。",
        math(String.raw`\Psi`), " は ℂ-代数 ", math(String.raw`B`), "（", ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）から ℂ-代数 ", math(String.raw`A`),
        "（", ref("def_clifford_algebra"), "）への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`B`), " の演算と単位元を ", math(String.raw`+_B,\ \cdot_B,\ \ast_B,\ 1_B`), " と書く（", ref("def_matrices_indexed_by_finite_set"), "）。",
        math(String.raw`B`), " の中の和は ", math(String.raw`U_{\mathrm{vec}}(B)`), "、", math(String.raw`A`), " の中の和は ", math(String.raw`U_{\mathrm{vec}}(A)`),
        "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の有限集合 ", math(String.raw`\mathcal{P}_M`), "（2 進の番号付けをもつ。", ref("claim_binary_numbering_is_numbering_of_power_set"), "）の上の和（", ref("def_sum_over_finite_set"), "）である。", math(String.raw`\mathcal{E}_{S,T}`), " は ",
        ref("def_matrix_unit_element_of_split_clifford_algebra"), " のもの、", math(String.raw`E_{S,T}\in B`), " は行列単位（", ref("def_matrix_unit"), "）、",
        math(String.raw`\delta`), " は ", math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
        math(String.raw`B`), " と ", math(String.raw`A`), " で元を左から・右から掛ける写像は線型写像である（", ref("claim_left_multiplication_in_algebra_is_linear_map"), "、",
        ref("claim_right_multiplication_in_algebra_is_linear_map"), "）。", math(String.raw`\Psi`), " は加法とスカラー倍を保つ（",
        ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map"), "）ので、残りは乗法の単位元と乗法を保つことである。",
      ]),
      paragraph([
        "（イ）乗法の単位元。", math(String.raw`S\in\mathcal{P}_M`), " について、", ref("claim_sum_over_finite_set_with_kronecker_delta_picks_term"), " を、主張の ",
        math(String.raw`x`), " に ", math(String.raw`S`), "、和の変数に ", math(String.raw`T`), "、", math(String.raw`v_T:=\mathcal{E}_{S,T}`), " を当てて、",
        math(String.raw`\sum_{T\in\mathcal{P}_M}\delta_{S,T}\ast_A \mathcal{E}_{S,T}=\mathcal{E}_{S,S}`), " が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi(1_B)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(1_B)_{S,T}\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}\delta_{S,T}\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ \text{単位行列の定義。}\blkref{def_matrices_indexed_by_finite_set}\text{、}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A \mathcal{E}_{S,S}
&&\left(\because\ \text{各}\ S\ \text{で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)
&&\left(\because\ \text{各}\ S\ \text{で}\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=1_A
&&\left(\because\ \blkref{claim_decomposition_of_unity_in_split_clifford_algebra}\right).
\end{aligned}`),
      paragraph([
        "（ロ）行列単位を左に置いた積。", math(String.raw`S,T\in\mathcal{P}_M`), " と ", math(String.raw`G\in B`), " について次が成り立つ。和の変数は ",
        math(String.raw`S',T'\in\mathcal{P}_M`), " と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi\bigl(E_{S,T}\cdot_B G\bigr)
&=\Psi\left(E_{S,T}\cdot_B\left(\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_B E_{S',T'}\Bigr)\right)\right)
&&\left(\because\ F:=G\text{、}X:=\mathcal{P}_M\text{。}\blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right)\\
&=\Psi\left(\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_B\bigl(E_{S,T}\cdot_B E_{S',T'}\bigr)\Bigr)\right)
&&\left(\because\ \text{線型写像に}\ E_{S,T}\cdot_B\bullet\ \text{を当てる。}\blkref{claim_left_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_A\Psi\bigl(E_{S,T}\cdot_B E_{S',T'}\bigr)\Bigr)
&&\left(\because\ \text{線型写像に}\ \Psi\ \text{を当てる。}\blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_A\bigl(\Psi(E_{S,T})\cdot_A\Psi(E_{S',T'})\bigr)\Bigr)
&&\left(\because\ \text{各}\ S',T'\ \text{で}\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units}\text{。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\Psi(E_{S,T})\cdot_A\left(\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_A\Psi(E_{S',T'})\Bigr)\right)
&&\left(\because\ \text{線型写像に}\ \Psi(E_{S,T})\cdot_A\bullet\ \text{を当て、右辺から左辺へ読む。}\blkref{claim_left_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\Psi(E_{S,T})\cdot_A\Psi\left(\sum_{S'\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T'\in\mathcal{P}_M}G_{S',T'}\ast_B E_{S',T'}\Bigr)\right)
&&\left(\because\ \text{線型写像に}\ \Psi\ \text{を当て、右辺から左辺へ読む。}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\Psi(E_{S,T})\cdot_A\Psi(G)
&&\left(\because\ F:=G\text{。}\blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right).
\end{aligned}`),
      paragraph(["（ハ）乗法。", math(String.raw`F,G\in B`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Psi\bigl(F\cdot_B G\bigr)
&=\Psi\left(\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B E_{S,T}\Bigr)\right)\cdot_B G\right)
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right)\\
&=\Psi\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B\bigl(E_{S,T}\cdot_B G\bigr)\Bigr)\right)
&&\left(\because\ \text{線型写像に}\ \bullet\cdot_B G\ \text{を当てる。}\blkref{claim_right_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A\Psi\bigl(E_{S,T}\cdot_B G\bigr)\Bigr)
&&\left(\because\ \text{線型写像に}\ \Psi\ \text{を当てる。}\blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A\bigl(\Psi(E_{S,T})\cdot_A\Psi(G)\bigr)\Bigr)
&&\left(\because\ \text{各}\ S,T\ \text{で（ロ）。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A\Psi(E_{S,T})\Bigr)\right)\cdot_A\Psi(G)
&&\left(\because\ \text{線型写像に}\ \bullet\cdot_A\Psi(G)\ \text{を当て、右辺から左辺へ読む。}\blkref{claim_right_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\Psi\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B E_{S,T}\Bigr)\right)\cdot_A\Psi(G)
&&\left(\because\ \text{線型写像に}\ \Psi\ \text{を当て、右辺から左辺へ読む。}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\Psi(F)\cdot_A\Psi(G)
&&\left(\because\ \blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right).
\end{aligned}`),
      paragraph([
        "加法を保つこと（", ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map"), "）と（ハ）と（イ）により、", math(String.raw`\Psi`), " は ",
        math(String.raw`U_{\mathrm{ring}}(B)`), " から ", math(String.raw`U_{\mathrm{ring}}(A)`), " への環の準同型（", ref("def_ring_homomorphism"), "）であり、",
        ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map"), " により ", math(String.raw`U_{\mathrm{vec}}(B)`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`),
        " への線型写像である。したがって ", math(String.raw`\Psi`), " は ℂ-代数の準同型である（", ref("def_complex_algebra_homomorphism"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_mutually_inverse_homomorphisms_heading",
    kind: "heading",
    level: 2,
    title: { text: "二つの準同型が互いに逆であること" },
    labels: [],
  },
  {
    id: "isomorphism_claim_homomorphism_to_matrix_algebra_on_matrix_unit_element",
    kind: "claim",
    title: { text: "行列環への準同型は、行列単位にあたる元を行列単位へ移す" },
    labels: ["claim_homomorphism_to_matrix_algebra_on_matrix_unit_element"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), " の準同型、", math(String.raw`\mathcal{E}_{S,T}`), " を ",
        ref("def_matrix_unit_element_of_split_clifford_algebra"), " のもの、", math(String.raw`E_{S,T}\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " を行列単位（",
        ref("def_matrix_unit"), "）とする。すべての ", math(String.raw`S,T\in\mathcal{P}_M`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi(\mathcal{E}_{S,T})=E_{S,T}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。", math(String.raw`y^{S}_t`), " を ",
        ref("def_selected_creation_factor"), "、", math(String.raw`z^{T}_t`), " を ", ref("def_selected_annihilation_factor"), "、", math(String.raw`\check{z}^{T}_k`), " を ",
        ref("def_reverse_numbered_selected_annihilation_factor"), "、", math(String.raw`x_i`), " を ", ref("def_vacuum_factor_of_split_clifford_algebra"),
        " のものとする。", math(String.raw`t\in\{1,\dots,M\}`), " について、", math(String.raw`B`), " の元 ", math(String.raw`Y_t`), " を ", math(String.raw`t\in S`), " なら ",
        math(String.raw`Y_t:=c_t`), "、", math(String.raw`t\notin S`), " なら ", math(String.raw`Y_t:=1_B`), " と定め、", math(String.raw`Z_t`), " を ",
        math(String.raw`t\in T`), " なら ", math(String.raw`Z_t:=c_t^{\mathsf T}`), "、", math(String.raw`t\notin T`), " なら ", math(String.raw`Z_t:=1_B`),
        " と定める（", math(String.raw`c_t`), " は ", ref("def_creation_operator_matrix"), "、", math(String.raw`c_t^{\mathsf T}`), " は ",
        ref("def_annihilation_operator_matrix"), " のもの）。", math(String.raw`k\in\{1,\dots,M\}`), " について ", math(String.raw`\check{Z}_k:=Z_{M+1-k}`), " と置く。準備として次の四つが成り立つ。",
      ]),
      paragraph(["（イ）", math(String.raw`t\in\{1,\dots,M\}`), " について ", math(String.raw`\Phi(y^{S}_t)=Y_t`), " と ", math(String.raw`\Phi(z^{T}_t)=Z_t`), " が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Phi(y^{S}_t)
&=\Phi(a^{\dagger}_t)
&&\left(\because\ t\in S\text{。}\blkref{def_selected_creation_factor}\right)\\
&=c_t
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix}\right)\\
&=Y_t
&&\left(\because\ t\in S\ \text{のときの}\ Y_t\ \text{の定め方}\right),\\[4pt]
\Phi(y^{S}_t)
&=\Phi(1_A)
&&\left(\because\ t\notin S\text{。}\blkref{def_selected_creation_factor}\right)\\
&=1_B
&&\left(\because\ \Phi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=Y_t
&&\left(\because\ t\notin S\ \text{のときの}\ Y_t\ \text{の定め方}\right),\\[4pt]
\Phi(z^{T}_t)
&=\Phi(a_t)
&&\left(\because\ t\in T\text{。}\blkref{def_selected_annihilation_factor}\right)\\
&=c_t^{\mathsf T}
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix}\right)\\
&=Z_t
&&\left(\because\ t\in T\ \text{のときの}\ Z_t\ \text{の定め方}\right),\\[4pt]
\Phi(z^{T}_t)
&=\Phi(1_A)
&&\left(\because\ t\notin T\text{。}\blkref{def_selected_annihilation_factor}\right)\\
&=1_B
&&\left(\because\ \Phi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=Z_t
&&\left(\because\ t\notin T\ \text{のときの}\ Z_t\ \text{の定め方}\right).
\end{aligned}`),
      paragraph(["さらに ", math(String.raw`k\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Phi(\check{z}^{T}_k)
&=\Phi(z^{T}_{M+1-k})
&&\left(\because\ \blkref{def_reverse_numbered_selected_annihilation_factor}\right)\\
&=Z_{M+1-k}
&&\left(\because\ \text{（イ）}\right)\\
&=\check{Z}_k
&&\left(\because\ \check{Z}_k\ \text{の置き方}\right).
\end{aligned}`),
      paragraph(["（ロ）", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Phi(x_i)
&=\Phi\bigl(a_i\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=\Phi(a_i)\cdot_B\Phi(a^{\dagger}_i)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=c_i^{\mathsf T}\cdot_B c_i
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix}\text{、}\blkref{claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph(["（ハ）三つの番号順の積の像。"]),
      displayMath(String.raw`\begin{aligned}
\Phi\bigl(a^{\dagger}_S\bigr)
&=\Phi\left(\prod_{A,\,t=1}^{M}y^{S}_t\right)
&&\left(\because\ \blkref{def_ordered_product_of_selected_creation_generators}\right)\\
&=\prod_{B,\,t=1}^{M}\Phi(y^{S}_t)
&&\left(\because\ \blkref{claim_algebra_homomorphism_maps_ordered_product_to_ordered_product}\right)\\
&=\prod_{B,\,t=1}^{M}Y_t
&&\left(\because\ \text{各}\ t\ \text{で（イ）。因子が等しい族の番号順の積は等しい（}\blkref{def_ordered_product_in_algebra}\text{）}\right),\\[4pt]
\Phi(P)
&=\Phi\left(\prod_{A,\,i=1}^{M}x_i\right)
&&\left(\because\ \blkref{def_vacuum_element_of_split_clifford_algebra}\right)\\
&=\prod_{B,\,i=1}^{M}\Phi(x_i)
&&\left(\because\ \blkref{claim_algebra_homomorphism_maps_ordered_product_to_ordered_product}\right)\\
&=\prod_{B,\,i=1}^{M}\bigl(c_i^{\mathsf T}\cdot_B c_i\bigr)
&&\left(\because\ \text{各}\ i\ \text{で（ロ）。因子が等しい族の番号順の積は等しい（}\blkref{def_ordered_product_in_algebra}\text{）}\right)\\
&=E_{\emptyset,\emptyset}
&&\left(\because\ \blkref{claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit}\right),\\[4pt]
\Phi(a_T)
&=\Phi\left(\prod_{A,\,k=1}^{M}\check{z}^{T}_k\right)
&&\left(\because\ \blkref{def_reverse_ordered_product_of_selected_annihilation_generators}\right)\\
&=\prod_{B,\,k=1}^{M}\Phi(\check{z}^{T}_k)
&&\left(\because\ \blkref{claim_algebra_homomorphism_maps_ordered_product_to_ordered_product}\right)\\
&=\prod_{B,\,k=1}^{M}\check{Z}_k
&&\left(\because\ \text{各}\ k\ \text{で（イ）の後の等式。因子が等しい族の番号順の積は等しい（}\blkref{def_ordered_product_in_algebra}\text{）}\right).
\end{aligned}`),
      paragraph(["（ニ）", math(String.raw`E_{S,\emptyset}`), " に ", math(String.raw`E_{\emptyset,\emptyset}`), " を右から掛けても変わらない。"]),
      displayMath(String.raw`\begin{aligned}
E_{S,\emptyset}\cdot_B E_{\emptyset,\emptyset}
&=\delta_{\emptyset,\emptyset}\ast_B E_{S,\emptyset}
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_product_of_matrix_units}\right)\\
&=1_{\mathbb{C}}\ast_B E_{S,\emptyset}
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=E_{S,\emptyset}
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Phi(\mathcal{E}_{S,T})
&=\Phi\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_T\Bigr)
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right)\\
&=\Phi\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_B\Phi(a_T)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Bigl(\Phi\bigl(a^{\dagger}_S\bigr)\cdot_B\Phi(P)\Bigr)\cdot_B\Phi(a_T)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Bigl(\Bigl(\prod_{B,\,t=1}^{M}Y_t\Bigr)\cdot_B\Phi(P)\Bigr)\cdot_B\Phi(a_T)
&&\left(\because\ \text{（ハ）の一つ目}\right)\\
&=\left(\Bigl(\prod_{B,\,t=1}^{M}Y_t\Bigr)\cdot_B E_{\emptyset,\emptyset}\right)\cdot_B\Phi(a_T)
&&\left(\because\ \text{（ハ）の二つ目}\right)\\
&=\left(\Bigl(\prod_{B,\,t=1}^{M}Y_t\Bigr)\cdot_B E_{\emptyset,\emptyset}\right)\cdot_B\Bigl(\prod_{B,\,k=1}^{M}\check{Z}_k\Bigr)
&&\left(\because\ \text{（ハ）の三つ目}\right)\\
&=E_{S,\emptyset}\cdot_B\Bigl(\prod_{B,\,k=1}^{M}\check{Z}_k\Bigr)
&&\left(\because\ y_t:=Y_t\text{。}\blkref{claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit}\right)\\
&=\bigl(E_{S,\emptyset}\cdot_B E_{\emptyset,\emptyset}\bigr)\cdot_B\Bigl(\prod_{B,\,k=1}^{M}\check{Z}_k\Bigr)
&&\left(\because\ \text{（ニ）}\right)\\
&=E_{S,\emptyset}\cdot_B\left(E_{\emptyset,\emptyset}\cdot_B\Bigl(\prod_{B,\,k=1}^{M}\check{Z}_k\Bigr)\right)
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=E_{S,\emptyset}\cdot_B E_{\emptyset,T}
&&\left(\because\ \text{主張の二つの族に}\ Z_t\ \text{と}\ \check{Z}_k\ \text{を当てる。}\blkref{claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices}\right)\\
&=\delta_{\emptyset,\emptyset}\ast_B E_{S,T}
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_product_of_matrix_units}\right)\\
&=1_{\mathbb{C}}\ast_B E_{S,T}
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=E_{S,T}
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への準同型のあとに行列環への準同型を合成すると、恒等写像になる" },
    labels: ["claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "、", math(String.raw`\Psi`), " を ",
        ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとし、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と書く。すべての ", math(String.raw`F\in B`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi\bigl(\Psi(F)\bigr)=F`),
    ],
    proof: [
      paragraph([
        "この証明の ", math(String.raw`\mathcal{P}_M`), " の上の和は、ℂ-線型空間の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "）であり、", math(String.raw`\mathcal{P}_M`),
        " の番号付けには 2 進の番号付け（", ref("claim_binary_numbering_is_numbering_of_power_set"), "）をとる。",
      ]),
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置く。", math(String.raw`\Phi`), " は ℂ-代数の準同型なので、", math(String.raw`U_{\mathrm{vec}}(A)`), " から ",
        math(String.raw`U_{\mathrm{vec}}(B)`), " への線型写像である（", ref("def_complex_algebra_homomorphism"), "、", ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）。", math(String.raw`\mathcal{E}_{S,T}`), " は ", ref("def_matrix_unit_element_of_split_clifford_algebra"), " のものである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi\bigl(\Psi(F)\bigr)
&=\Phi\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A \mathcal{E}_{S,T}\Bigr)\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B\Phi(\mathcal{E}_{S,T})\Bigr)
&&\left(\because\ \text{線型写像に}\ \Phi\ \text{を当てる。}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_B\Bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_B E_{S,T}\Bigr)
&&\left(\because\ \text{各}\ S,T\ \text{で}\ \blkref{claim_homomorphism_to_matrix_algebra_on_matrix_unit_element}\text{。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=F
&&\left(\because\ X:=\mathcal{P}_M\text{。}\blkref{claim_matrix_is_double_sum_of_entries_times_matrix_units}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements",
    kind: "claim",
    title: { text: "生成作用素の行列の一つの列の成分を係数にした、行列単位にあたる元の和" },
    labels: ["claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`\mathcal{E}_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), "、",
        math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), " のもの、", math(String.raw`c_i`), " を生成作用素の行列（",
        ref("def_creation_operator_matrix"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " と ", math(String.raw`T\in\mathcal{P}_M`), " について、",
        math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{S\in\mathcal{P}_M}(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}=a^{\dagger}_i\cdot_A \mathcal{E}_{T,T}`),
    ],
    proof: [
      paragraph([
        math(String.raw`a^{\dagger}_T`), " は ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a_T`), " は ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`P`), " は ", ref("def_vacuum_element_of_split_clifford_algebra"),
        " のもの、", math(String.raw`\delta`), " は ", math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
        math(String.raw`i\notin T`), " と ", math(String.raw`i\in T`), " のどちらか一方だけが成り立つ（", ref("def_power_set_of_first_m_positive_integers"), "）。",
      ]),
      paragraph([
        math(String.raw`i\notin T`), " のとき。", math(String.raw`\sigma:=\varsigma(N_i(T))\in\mathbb{C}`), "（", ref("def_count_of_subset_elements_below_index"), "、",
        ref("def_sign_of_nonnegative_integer"), "）と置く。（イ）", math(String.raw`S\in\mathcal{P}_M`), " について ",
        math(String.raw`(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}=\delta_{T\cup\{i\},S}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})`), " が成り立つ。", math(String.raw`S=T\cup\{i\}`),
        " のときと ", math(String.raw`S\neq T\cup\{i\}`), " のときに分ける。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}
&=\sigma\ast_A \mathcal{E}_{S,T}
&&\left(\because\ i\notin T\ \text{かつ}\ S=T\cup\{i\}\text{。}\blkref{def_creation_operator_matrix}\right)\\
&=1_{\mathbb{C}}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{T\cup\{i\},S}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ T\cup\{i\}=S\text{。}\blkref{def_kronecker_delta}\right),\\[4pt]
(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}
&=0_{\mathbb{C}}\ast_A \mathcal{E}_{S,T}
&&\left(\because\ S\neq T\cup\{i\}\ \text{なので条件が成り立たない。}\blkref{def_creation_operator_matrix}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\delta_{T\cup\{i\},S}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ T\cup\{i\}\neq S\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph(["（ロ）右辺は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A \mathcal{E}_{T,T}
&=a^{\dagger}_i\cdot_A\Bigl(\bigl(a^{\dagger}_T\cdot_A P\bigr)\cdot_A a_T\Bigr)
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right)\\
&=\Bigl(a^{\dagger}_i\cdot_A\bigl(a^{\dagger}_T\cdot_A P\bigr)\Bigr)\cdot_A a_T
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a^{\dagger}_i\cdot_A a^{\dagger}_T\bigr)\cdot_A P\Bigr)\cdot_A a_T
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(\sigma\ast_A a^{\dagger}_{T\cup\{i\}}\bigr)\cdot_A P\Bigr)\cdot_A a_T
&&\left(\because\ i\notin T\text{。}\blkref{claim_creation_generator_times_ordered_creation_product_without_index}\right)\\
&=\Bigl(\sigma\ast_A\bigl(a^{\dagger}_{T\cup\{i\}}\cdot_A P\bigr)\Bigr)\cdot_A a_T
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\sigma\ast_A\Bigl(\bigl(a^{\dagger}_{T\cup\{i\}}\cdot_A P\bigr)\cdot_A a_T\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\sigma\ast_A \mathcal{E}_{T\cup\{i\},T}
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{S\in\mathcal{P}_M}(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}
&=\sum_{S\in\mathcal{P}_M}\delta_{T\cup\{i\},S}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ \text{各}\ S\ \text{で（イ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sigma\ast_A \mathcal{E}_{T\cup\{i\},T}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ T\cup\{i\}\text{、和の変数に}\ S\text{、}v_S:=\sigma\ast_A \mathcal{E}_{S,T}\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=a^{\dagger}_i\cdot_A \mathcal{E}_{T,T}
&&\left(\because\ \text{（ロ）}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in T`), " のとき。（ハ）", math(String.raw`S\in\mathcal{P}_M`), " について、条件「", math(String.raw`i\notin T`), " かつ ",
        math(String.raw`S=T\cup\{i\}`), "」が成り立たないので、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}
&=0_{\mathbb{C}}\ast_A \mathcal{E}_{S,T}
&&\left(\because\ \blkref{def_creation_operator_matrix}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{S\in\mathcal{P}_M}(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}
&=0_A
&&\left(\because\ \text{各}\ S\ \text{で（ハ）。}\blkref{claim_sum_over_finite_set_of_zero_terms_is_zero}\right)\\
&=0_A\cdot_A a_T
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\ \text{を右辺から左辺へ読む}\right)\\
&=\bigl(0_A\cdot_A P\bigr)\cdot_A a_T
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\ \text{を右辺から左辺へ読む}\right)\\
&=\Bigl(\bigl(a^{\dagger}_i\cdot_A a^{\dagger}_T\bigr)\cdot_A P\Bigr)\cdot_A a_T
&&\left(\because\ i\in T\text{。}\blkref{claim_creation_generator_times_ordered_creation_product_with_index_is_zero}\right)\\
&=\Bigl(a^{\dagger}_i\cdot_A\bigl(a^{\dagger}_T\cdot_A P\bigr)\Bigr)\cdot_A a_T
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a^{\dagger}_i\cdot_A\Bigl(\bigl(a^{\dagger}_T\cdot_A P\bigr)\cdot_A a_T\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a^{\dagger}_i\cdot_A \mathcal{E}_{T,T}
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への準同型は、生成作用素の行列を生成作用素にあたる元へ移す" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "、", math(String.raw`a^{\dagger}_i`), " を ",
        ref("def_creation_generator_of_split_clifford_algebra"), " のもの、", math(String.raw`c_i`), " を生成作用素の行列（", ref("def_creation_operator_matrix"),
        "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi(c_i)=a^{\dagger}_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`\mathcal{E}_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), "、",
        math(String.raw`a^{\dagger}_T`), "・", math(String.raw`a_T`), "・", math(String.raw`P`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "・",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "・", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。和はすべて ",
        math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ", math(String.raw`\mathcal{P}_M`), "（2 進の番号付けをもつ。", ref("claim_binary_numbering_is_numbering_of_power_set"), "）の上の和（", ref("def_sum_over_finite_set"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi(c_i)
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{S\in\mathcal{P}_M}(c_i)_{S,T}\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ X:=Y:=\mathcal{P}_M\text{、}\lambda_{S,T}:=(c_i)_{S,T}\text{、}v_{S,T}:=\mathcal{E}_{S,T}\text{。}\blkref{claim_interchange_of_double_sum_over_finite_sets}\right)\\
&=\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\bigl(a^{\dagger}_i\cdot_A \mathcal{E}_{T,T}\bigr)
&&\left(\because\ \text{各}\ T\ \text{で}\ \blkref{claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=a^{\dagger}_i\cdot_A\left(\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A \mathcal{E}_{T,T}\right)
&&\left(\because\ \text{線型写像に}\ a^{\dagger}_i\cdot_A\bullet\ \text{を当て、右辺から左辺へ読む。}\blkref{claim_left_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=a^{\dagger}_i\cdot_A\left(\sum_{T\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_T\cdot_A P\bigr)\cdot_A a_T\Bigr)\right)
&&\left(\because\ \text{各}\ T\ \text{で}\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=a^{\dagger}_i\cdot_A 1_A
&&\left(\because\ \text{和の変数を}\ T\ \text{と書いた}\ \blkref{claim_decomposition_of_unity_in_split_clifford_algebra}\right)\\
&=a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements",
    kind: "claim",
    title: { text: "消滅作用素の行列の一つの行の成分を係数にした、行列単位にあたる元の和" },
    labels: ["claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`\mathcal{E}_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), "、",
        math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " のもの、", math(String.raw`c_i^{\mathsf T}`), " を消滅作用素の行列（",
        ref("def_annihilation_operator_matrix"), "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " と ", math(String.raw`S\in\mathcal{P}_M`), " について、",
        math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\ast_A \mathcal{E}_{S,T}=\mathcal{E}_{S,S}\cdot_A a_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`a^{\dagger}_S`), " は ", ref("def_ordered_product_of_selected_creation_generators"), "、", math(String.raw`a_S`), " は ",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "、", math(String.raw`P`), " は ", ref("def_vacuum_element_of_split_clifford_algebra"),
        " のもの、", math(String.raw`\delta`), " は ", math(String.raw`\mathcal{P}_M`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
        math(String.raw`T\in\mathcal{P}_M`), " について ", math(String.raw`(c_i^{\mathsf T})_{S,T}=(c_i)_{T,S}`), " であり（", ref("def_annihilation_operator_matrix"),
        "）、", math(String.raw`(c_i)_{T,S}`), " は、", math(String.raw`i\notin S`), " かつ ", math(String.raw`T=S\cup\{i\}`), " なら ", math(String.raw`\varsigma(N_i(S))`),
        "、それ以外なら ", math(String.raw`0_{\mathbb{C}}`), " である（", ref("def_creation_operator_matrix"), "）。", math(String.raw`i\notin S`), " と ",
        math(String.raw`i\in S`), " のどちらか一方だけが成り立つ（", ref("def_power_set_of_first_m_positive_integers"), "）。",
      ]),
      paragraph([
        math(String.raw`i\notin S`), " のとき。", math(String.raw`\sigma:=\varsigma(N_i(S))\in\mathbb{C}`), "（", ref("def_count_of_subset_elements_below_index"), "、",
        ref("def_sign_of_nonnegative_integer"), "）と置く。（イ）", math(String.raw`T\in\mathcal{P}_M`), " について ",
        math(String.raw`(c_i^{\mathsf T})_{S,T}\ast_A \mathcal{E}_{S,T}=\delta_{S\cup\{i\},T}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})`), " が成り立つ。", math(String.raw`T=S\cup\{i\}`),
        " のときと ", math(String.raw`T\neq S\cup\{i\}`), " のときに分ける。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i^{\mathsf T})_{S,T}\ast_A \mathcal{E}_{S,T}
&=(c_i)_{T,S}\ast_A \mathcal{E}_{S,T}
&&\left(\because\ \blkref{def_annihilation_operator_matrix}\right)\\
&=\sigma\ast_A \mathcal{E}_{S,T}
&&\left(\because\ i\notin S\ \text{かつ}\ T=S\cup\{i\}\text{。}\blkref{def_creation_operator_matrix}\right)\\
&=1_{\mathbb{C}}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{S\cup\{i\},T}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ S\cup\{i\}=T\text{。}\blkref{def_kronecker_delta}\right),\\[4pt]
(c_i^{\mathsf T})_{S,T}\ast_A \mathcal{E}_{S,T}
&=(c_i)_{T,S}\ast_A \mathcal{E}_{S,T}
&&\left(\because\ \blkref{def_annihilation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\ast_A \mathcal{E}_{S,T}
&&\left(\because\ T\neq S\cup\{i\}\ \text{なので条件が成り立たない。}\blkref{def_creation_operator_matrix}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\delta_{S\cup\{i\},T}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ S\cup\{i\}\neq T\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph(["（ロ）右辺は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\mathcal{E}_{S,S}\cdot_A a_i
&=\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)\cdot_A a_i
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\bigl(a_S\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\bigl(\sigma\ast_A a_{S\cup\{i\}}\bigr)
&&\left(\because\ i\notin S\text{。}\blkref{claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index}\right)\\
&=\sigma\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_{S\cup\{i\}}\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\sigma\ast_A \mathcal{E}_{S,S\cup\{i\}}
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\ast_A \mathcal{E}_{S,T}
&=\sum_{T\in\mathcal{P}_M}\delta_{S\cup\{i\},T}\ast_A(\sigma\ast_A \mathcal{E}_{S,T})
&&\left(\because\ \text{各}\ T\ \text{で（イ）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sigma\ast_A \mathcal{E}_{S,S\cup\{i\}}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ S\cup\{i\}\text{、和の変数に}\ T\text{、}v_T:=\sigma\ast_A \mathcal{E}_{S,T}\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=\mathcal{E}_{S,S}\cdot_A a_i
&&\left(\because\ \text{（ロ）}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in S`), " のとき。（ハ）", math(String.raw`T\in\mathcal{P}_M`), " について、", math(String.raw`(c_i)_{T,S}`), " の条件「",
        math(String.raw`i\notin S`), " かつ ", math(String.raw`T=S\cup\{i\}`), "」が成り立たないので、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
(c_i^{\mathsf T})_{S,T}\ast_A \mathcal{E}_{S,T}
&=(c_i)_{T,S}\ast_A \mathcal{E}_{S,T}
&&\left(\because\ \blkref{def_annihilation_operator_matrix}\right)\\
&=0_{\mathbb{C}}\ast_A \mathcal{E}_{S,T}
&&\left(\because\ \blkref{def_creation_operator_matrix}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\ast_A \mathcal{E}_{S,T}
&=0_A
&&\left(\because\ \text{各}\ T\ \text{で（ハ）。}\blkref{claim_sum_over_finite_set_of_zero_terms_is_zero}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A 0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\ \text{を右辺から左辺へ読む}\right)\\
&=\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A\bigl(a_S\cdot_A a_i\bigr)
&&\left(\because\ i\in S\text{。}\blkref{claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero}\right)\\
&=\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\mathcal{E}_{S,S}\cdot_A a_i
&&\left(\because\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix",
    kind: "claim",
    title: { text: "行列環からクリフォード代数への準同型は、消滅作用素の行列を消滅作用素にあたる元へ移す" },
    labels: ["claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix"],
    statement: [
      paragraph([
        math(String.raw`\Psi`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "、", math(String.raw`a_i`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " のもの、", math(String.raw`c_i^{\mathsf T}`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"),
        "）とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi(c_i^{\mathsf T})=a_i`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`\mathcal{E}_{S,T}`), " を ", ref("def_matrix_unit_element_of_split_clifford_algebra"), "、",
        math(String.raw`a^{\dagger}_S`), "・", math(String.raw`a_S`), "・", math(String.raw`P`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "・",
        ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "・", ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。和はすべて ",
        math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ", math(String.raw`\mathcal{P}_M`), "（2 進の番号付けをもつ。", ref("claim_binary_numbering_is_numbering_of_power_set"), "）の上の和（", ref("def_sum_over_finite_set"), "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi(c_i^{\mathsf T})
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\left(\sum_{T\in\mathcal{P}_M}(c_i^{\mathsf T})_{S,T}\ast_A \mathcal{E}_{S,T}\right)
&&\left(\because\ \blkref{def_homomorphism_from_matrix_algebra_to_clifford_algebra}\right)\\
&=\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\bigl(\mathcal{E}_{S,S}\cdot_A a_i\bigr)
&&\left(\because\ \text{各}\ S\ \text{で}\ \blkref{claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A \mathcal{E}_{S,S}\right)\cdot_A a_i
&&\left(\because\ \text{線型写像に}\ \bullet\cdot_A a_i\ \text{を当て、右辺から左辺へ読む。}\blkref{claim_right_multiplication_in_algebra_is_linear_map}\text{、}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\left(\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\Bigl(\bigl(a^{\dagger}_S\cdot_A P\bigr)\cdot_A a_S\Bigr)\right)\cdot_A a_i
&&\left(\because\ \text{各}\ S\ \text{で}\ \blkref{def_matrix_unit_element_of_split_clifford_algebra}\text{。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=1_A\cdot_A a_i
&&\left(\because\ \blkref{claim_decomposition_of_unity_in_split_clifford_algebra}\right)\\
&=a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators",
    kind: "claim",
    title: { text: "分裂した二次空間の元の像は、生成作用素にあたる元と消滅作用素にあたる元の線型結合である" },
    labels: ["claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`W`), "、", math(String.raw`w`), "、", math(String.raw`f`), "、", math(String.raw`V`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、",
        math(String.raw`\gamma`), "、", math(String.raw`\mathrm{in}_1`), "、", math(String.raw`\mathrm{in}_2`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"),
        " のもの、", math(String.raw`a^{\dagger}_k`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_k`), " を ",
        ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。", math(String.raw`\beta^{w}_k:W\to\mathbb{C}`),
        " を ", math(String.raw`w`), " についての第 ", math(String.raw`k`), " 座標の写像（", ref("claim_coordinate_map_is_linear_form"), "）とする。すべての ",
        math(String.raw`x\in W`), " と ", math(String.raw`g\in W^{*}`), " について、", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）の中の線型結合（", ref("def_linear_combination"), "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\gamma\bigl((x,g)\bigr)=\left(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\right)+_A\left(\sum_{k=1}^{M}g(w_k)\ast_A a_k\right)`),
    ],
    proof: [
      paragraph([
        "準備として、", math(String.raw`\gamma\circ\mathrm{in}_1:W\to U_{\mathrm{vec}}(A)`), " と ", math(String.raw`\gamma\circ\mathrm{in}_2:W^{*}\to U_{\mathrm{vec}}(A)`),
        " は線型写像である。", math(String.raw`\mathrm{in}_1`), " と ", math(String.raw`\mathrm{in}_2`), " が線型写像であり（", ref("claim_embedding_into_first_component_is_linear_map"),
        "、", ref("claim_embedding_into_second_component_is_linear_map"), "）、", math(String.raw`\gamma`), " が線型写像であり（", ref("claim_clifford_generator_map_is_linear_map"),
        "）、線型写像の合成は線型写像だからである（", ref("claim_composition_of_linear_maps_is_linear_map"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma\bigl(\mathrm{in}_1(x)\bigr)
&=(\gamma\circ\mathrm{in}_1)(x)
&&\left(\because\ \text{合成の定義}\right)\\
&=(\gamma\circ\mathrm{in}_1)\left(\sum_{k=1}^{M}\beta^{w}_k(x)\cdot_W w_k\right)
&&\left(\because\ V:=W\text{、}n:=M\text{、}b:=w\text{。}\blkref{claim_coordinate_map_is_linear_form}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A(\gamma\circ\mathrm{in}_1)(w_k)
&&\left(\because\ \text{線型写像に}\ \gamma\circ\mathrm{in}_1\ \text{を当てる。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A\gamma\bigl(\mathrm{in}_1(w_k)\bigr)
&&\left(\because\ \text{各}\ k\ \text{で合成の定義。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k
&&\left(\because\ \text{各}\ k\ \text{で}\ \blkref{def_creation_generator_of_split_clifford_algebra}\text{。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right),\\[4pt]
\gamma\bigl(\mathrm{in}_2(g)\bigr)
&=(\gamma\circ\mathrm{in}_2)(g)
&&\left(\because\ \text{合成の定義}\right)\\
&=(\gamma\circ\mathrm{in}_2)\left(\sum_{k=1}^{M}g(w_k)\cdot_{W^{*}}f_k\right)
&&\left(\because\ V:=W\text{、}n:=M\text{、}b:=w\text{。}\blkref{claim_dual_basis_spans_dual_space}\right)\\
&=\sum_{k=1}^{M}g(w_k)\ast_A(\gamma\circ\mathrm{in}_2)(f_k)
&&\left(\because\ \text{線型写像に}\ \gamma\circ\mathrm{in}_2\ \text{を当てる。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{k=1}^{M}g(w_k)\ast_A\gamma\bigl(\mathrm{in}_2(f_k)\bigr)
&&\left(\because\ \text{各}\ k\ \text{で合成の定義。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{k=1}^{M}g(w_k)\ast_A a_k
&&\left(\because\ \text{各}\ k\ \text{で}\ \blkref{def_annihilation_generator_of_split_clifford_algebra}\text{。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma\bigl((x,g)\bigr)
&=\gamma\bigl(\mathrm{in}_1(x)+_V\mathrm{in}_2(g)\bigr)
&&\left(\because\ \blkref{claim_direct_sum_element_is_sum_of_embedded_components}\right)\\
&=\gamma\bigl(\mathrm{in}_1(x)\bigr)+_A\gamma\bigl(\mathrm{in}_2(g)\bigr)
&&\left(\because\ \gamma\ \text{は加法を保つ。}\blkref{claim_clifford_generator_map_is_linear_map}\right)\\
&=\left(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\right)+_A\gamma\bigl(\mathrm{in}_2(g)\bigr)
&&\left(\because\ \text{準備の一つ目の等式}\right)\\
&=\left(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\right)+_A\left(\sum_{k=1}^{M}g(w_k)\ast_A a_k\right)
&&\left(\because\ \text{準備の二つ目の等式}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity",
    kind: "claim",
    title: { text: "クリフォード代数から行列環への準同型のあとに行列環からクリフォード代数への準同型を合成すると、恒等写像になる" },
    labels: ["claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity"],
    statement: [
      paragraph([
        math(String.raw`\Phi`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "、", math(String.raw`\Psi`), " を ",
        ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " のものとし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。すべての ", math(String.raw`a\in A`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Psi\bigl(\Phi(a)\bigr)=a`),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と置く。", math(String.raw`\Phi`), " は ", math(String.raw`A`), " から ", math(String.raw`B`), " への、",
        math(String.raw`\Psi`), " は ", math(String.raw`B`), " から ", math(String.raw`A`), " への ℂ-代数の準同型である（", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        "、", ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism"), "）。したがって合成 ", math(String.raw`\Psi\circ\Phi:A\to A`),
        " は ℂ-代数の準同型であり（", ref("claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism"), "）、", math(String.raw`U_{\mathrm{vec}}(A)`), " から ",
        math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像である（", ref("def_complex_algebra_homomorphism"), "、", ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）。恒等写像 ", math(String.raw`\mathrm{id}_A`), " も ℂ-代数の準同型である（", ref("claim_identity_map_is_algebra_homomorphism"), "）。",
        math(String.raw`\gamma(V)`), " は ", math(String.raw`A`), " を生成する（", ref("claim_image_of_clifford_generator_map_generates_clifford_algebra"), "）ので、",
        ref("claim_homomorphisms_agreeing_on_generators_are_equal"), " を ", math(String.raw`\varphi:=\Psi\circ\Phi`), "、", math(String.raw`\psi:=\mathrm{id}_A`), "、",
        math(String.raw`X:=\gamma(V)`), " に当てれば、すべての ", math(String.raw`v\in V`), " について ", math(String.raw`(\Psi\circ\Phi)(\gamma(v))=\mathrm{id}_A(\gamma(v))`),
        " を示せば主張が従う。",
      ]),
      paragraph(["準備として、", math(String.raw`k\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
(\Psi\circ\Phi)\bigl(a^{\dagger}_k\bigr)
&=\Psi\bigl(\Phi(a^{\dagger}_k)\bigr)
&&\left(\because\ \text{合成の定義}\right)\\
&=\Psi(c_k)
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix}\right)\\
&=a^{\dagger}_k
&&\left(\because\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix}\right),\\[4pt]
(\Psi\circ\Phi)(a_k)
&=\Psi\bigl(\Phi(a_k)\bigr)
&&\left(\because\ \text{合成の定義}\right)\\
&=\Psi(c_k^{\mathsf T})
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix}\right)\\
&=a_k
&&\left(\because\ \blkref{claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`v\in V`), " をとる。", math(String.raw`V=W\oplus W^{*}`), " の元は順序対なので、", math(String.raw`v=(x,g)`), " となる ", math(String.raw`x\in W`), " と ",
        math(String.raw`g\in W^{*}`), " がある（", ref("def_direct_sum_of_two_vector_spaces"), "）。", math(String.raw`\beta^{w}_k`), " は ",
        ref("claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators"), " のものである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\Psi\circ\Phi)\bigl(\gamma((x,g))\bigr)
&=(\Psi\circ\Phi)\left(\Bigl(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\Bigr)+_A\Bigl(\sum_{k=1}^{M}g(w_k)\ast_A a_k\Bigr)\right)
&&\left(\because\ \blkref{claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators}\right)\\
&=(\Psi\circ\Phi)\Bigl(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\Bigr)+_A(\Psi\circ\Phi)\Bigl(\sum_{k=1}^{M}g(w_k)\ast_A a_k\Bigr)
&&\left(\because\ \Psi\circ\Phi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Bigl(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A(\Psi\circ\Phi)(a^{\dagger}_k)\Bigr)+_A\Bigl(\sum_{k=1}^{M}g(w_k)\ast_A(\Psi\circ\Phi)(a_k)\Bigr)
&&\left(\because\ \text{線型写像に}\ \Psi\circ\Phi\ \text{を当て、二つの線型結合に使う。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\Bigl(\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k\Bigr)+_A\Bigl(\sum_{k=1}^{M}g(w_k)\ast_A a_k\Bigr)
&&\left(\because\ \text{各}\ k\ \text{で準備。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\gamma\bigl((x,g)\bigr)
&&\left(\because\ \blkref{claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators}\right)\\
&=\mathrm{id}_A\bigl(\gamma((x,g))\bigr)
&&\left(\because\ \mathrm{id}_A\ \text{の定義。}\blkref{claim_identity_map_is_algebra_homomorphism}\right).
\end{aligned}`),
      paragraph([
        "したがって ", ref("claim_homomorphisms_agreeing_on_generators_are_equal"), " により ", math(String.raw`\Psi\circ\Phi=\mathrm{id}_A`), " である。", math(String.raw`a\in A`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi(\Phi(a))
&=(\Psi\circ\Phi)(a)
&&\left(\because\ \text{写像の合成の定義}\right)\\
&=\mathrm{id}_A(a)
&&\left(\because\ \Psi\circ\Phi=\mathrm{id}_A\right)\\
&=a
&&\left(\because\ \text{恒等写像の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra",
    kind: "theorem",
    title: { text: "主定理：分裂した二次空間のクリフォード代数と行列環の同型" },
    labels: ["theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`W`), " を ℂ-線型空間、", math(String.raw`w_1,\dots,w_M`), " をその基底、", math(String.raw`f_1,\dots,f_M`),
        " を双対基底とし、", math(String.raw`V:=W\oplus W^{*}`), "、", math(String.raw`q((x,g)):=g(x)`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`),
        "、", math(String.raw`a^{\dagger}_i:=\gamma(\mathrm{in}_1(w_i))`), "、", math(String.raw`a_i:=\gamma(\mathrm{in}_2(f_i))`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"),
        "、", ref("def_creation_generator_of_split_clifford_algebra"), "、", ref("def_annihilation_generator_of_split_clifford_algebra"), " のものとし、",
        math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と書く。",
      ]),
      paragraph([
        math(String.raw`\varphi:V\to B`), " を ", ref("def_matrix_valued_map_on_split_quadratic_space"), " の写像、", math(String.raw`c_i`), " を生成作用素の行列（", ref("def_creation_operator_matrix"),
        "）、", math(String.raw`c_i^{\mathsf T}`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"), "）、", math(String.raw`a^{\dagger}_S`), "・", math(String.raw`a_T`), "・",
        math(String.raw`P`), " を ", ref("def_ordered_product_of_selected_creation_generators"), "・", ref("def_reverse_ordered_product_of_selected_annihilation_generators"), "・",
        ref("def_vacuum_element_of_split_clifford_algebra"), " のものとする。", math(String.raw`\Phi:A\to B`), " を、", math(String.raw`\Phi\circ\gamma=\varphi`), " を満たすただ一つの ℂ-代数の準同型（", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        "。", math(String.raw`\Phi(a^{\dagger}_i)=c_i`), "、", math(String.raw`\Phi(a_i)=c_i^{\mathsf T}`), " を満たす。", ref("claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix"), "、",
        ref("claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix"), "）、", math(String.raw`\Psi:B\to A`), " を、",
        math(String.raw`F\in B`), " に ", math(String.raw`\sum_{S\in\mathcal{P}_M}1_{\mathbb{C}}\ast_A\bigl(\sum_{T\in\mathcal{P}_M}F_{S,T}\ast_A((a^{\dagger}_S\cdot_A P)\cdot_A a_T)\bigr)`),
        " を与える写像（", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "。和は ", math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合 ", math(String.raw`\mathcal{P}_M`), "（", ref("claim_binary_numbering_is_numbering_of_power_set"), "）の上の和（", ref("def_sum_over_finite_set"), "）である）とする。このとき次が成り立つ。",
      ]),
      list([
        [math(String.raw`\Phi`), " と ", math(String.raw`\Psi`), " はどちらも ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。"],
        [
          "すべての ", math(String.raw`a\in A`), " について ", math(String.raw`\Psi(\Phi(a))=a`), " であり、すべての ", math(String.raw`F\in B`), " について ",
          math(String.raw`\Phi(\Psi(F))=F`), " である。",
        ],
      ]),
      paragraph([
        "したがって ", math(String.raw`\Phi`), " は全単射であり、その逆写像は ", math(String.raw`\Psi`), " である。すなわち ", math(String.raw`\Phi`), " と ", math(String.raw`\Psi`),
        " は互いに逆な ℂ-代数の準同型である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\Phi`), " は ℂ-代数の準同型であり（", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "）、", math(String.raw`\Psi`), " は ℂ-代数の準同型である（",
        ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism"), "）。", math(String.raw`\Psi(\Phi(a))=a`), " は ",
        ref("claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity"), "、", math(String.raw`\Phi(\Psi(F))=F`), " は ",
        ref("claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity"), " である。",
      ]),
      paragraph([
        "単射であること。", math(String.raw`a,b\in A`), " が ", math(String.raw`\Phi(a)=\Phi(b)`), " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
a
&=\Psi\bigl(\Phi(a)\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right)\\
&=\Psi\bigl(\Phi(b)\bigr)
&&\left(\because\ \Phi(a)=\Phi(b)\right)\\
&=b
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right).
\end{aligned}`),
      paragraph([
        "全射であること。", math(String.raw`F\in B`), " について、", math(String.raw`\Psi(F)\in A`), " は ", math(String.raw`\Phi(\Psi(F))=F`), " を満たす（",
        ref("claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity"), "）。",
      ]),
      paragraph([
        "したがって ", math(String.raw`\Phi`), " は全単射である。", math(String.raw`\Phi`), " の逆写像を ", math(String.raw`\Phi^{-1}:B\to A`), "（", math(String.raw`\Phi^{-1}(F)`),
        " は ", math(String.raw`\Phi(a)=F`), " を満たすただ一つの ", math(String.raw`a\in A`), "）とすると、", math(String.raw`F\in B`), " について ", math(String.raw`\Psi(F)`),
        " は ", math(String.raw`\Phi(\Psi(F))=F`), " を満たすので、", math(String.raw`\Phi^{-1}(F)=\Psi(F)`), " である。すなわち ", math(String.raw`\Phi^{-1}=\Psi`), " である。",
      ]),
    ],
  },
  {
    id: "isomorphism_basis_of_matrix_unit_elements_heading",
    kind: "heading",
    level: 2,
    title: { text: "系：行列単位にあたる元はクリフォード代数の基底をなす" },
    labels: [],
  },
  {
    id: "isomorphism_definition_family_of_matrix_unit_elements_numbered_by_pairs",
    kind: "definition",
    title: { text: "部分集合の組の番号付けで番号付けた、行列単位にあたる元の族" },
    labels: ["def_family_of_matrix_unit_elements_numbered_by_pairs"],
    statement: [
      paragraph([
        math(String.raw`M`),
        "、",
        math(String.raw`\mathrm{Cl}(V,q)`),
        " を ",
        ref("def_clifford_algebra_of_split_quadratic_space"),
        " のもの、",
        math(String.raw`\mathcal{E}_{S,T}`),
        " を ",
        ref("def_matrix_unit_element_of_split_clifford_algebra"),
        " のもの、",
        math(String.raw`N_M`),
        " と ",
        math(String.raw`p_M:\{1,\dots,N_M\}\to\mathcal{P}_M\times\mathcal{P}_M`),
        " を ",
        ref("def_numbering_of_pairs_of_subsets"),
        " のものとし、",
        math(String.raw`A:=\mathrm{Cl}(V,q)`),
        " と書く。",
        math(String.raw`m\in\{1,\dots,N_M\}`),
        " について、",
        math(String.raw`S_m,T_m\in\mathcal{P}_M`),
        " を ",
        math(String.raw`p_M(m)=(S_m,T_m)`),
        " で定め（順序対の第一成分と第二成分）、族 ",
        math(String.raw`b:\{1,\dots,N_M\}\to A`),
        " を次で定める。",
      ]),
      displayMath(String.raw`b_m:=b(m):=\mathcal{E}_{S_m,T_m}`),
      paragraph([
        math(String.raw`b`),
        " は ℂ-線型空間 ",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）の元の番号付けた族（",
        ref("def_linear_independence"),
        "）である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_entry_of_image_of_linear_combination_of_matrix_unit_elements",
    kind: "claim",
    title: { text: "行列単位にあたる元の線型結合の、行列環への像の成分は係数である" },
    labels: ["claim_entry_of_image_of_linear_combination_of_matrix_unit_elements"],
    statement: [
      paragraph([
        math(String.raw`\Phi`),
        " を ",
        ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        " の準同型、",
        math(String.raw`N_M`),
        "、",
        math(String.raw`S_m`),
        "、",
        math(String.raw`T_m`),
        "、",
        math(String.raw`b`),
        " を ",
        ref("def_family_of_matrix_unit_elements_numbered_by_pairs"),
        " のものとし、",
        math(String.raw`A:=\mathrm{Cl}(V,q)`),
        " と書く。",
        math(String.raw`\{1,\dots,N_M\}`),
        " の各元 ",
        math(String.raw`m`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_m`),
        " が一つずつ与えられているとする。すべての ",
        math(String.raw`j\in\{1,\dots,N_M\}`),
        " について、",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        " の中の線型結合（",
        ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi\left(\sum_{m=1}^{N_M}\lambda_m\ast_A b_m\right)_{S_j,T_j}=\lambda_j`),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と置く。",
        math(String.raw`\Phi`),
        " は ℂ-代数の準同型なので、",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        " から ",
        math(String.raw`U_{\mathrm{vec}}(B)`),
        " への線型写像である（",
        ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        "、",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）。",
        math(String.raw`\mathrm{ent}_{S_j,T_j}:B\to\mathbb{C}^{\mathrm{vec}}`),
        " は線型写像である（",
        ref("claim_matrix_entry_map_is_linear_map"),
        "）。",
        math(String.raw`\delta_{m,j}\in\mathbb{C}`),
        " は ",
        math(String.raw`\{1,\dots,N_M\}`),
        " の二元のクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）である。準備として、",
        math(String.raw`m\in\{1,\dots,N_M\}`),
        " について次の二つを示す。",
      ]),
      paragraph([
        "（イ）",
        math(String.raw`\Phi(b_m)=E_{S_m,T_m}`),
        "。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi(b_m)
&=\Phi(\mathcal{E}_{S_m,T_m})
&&\left(\because\ \blkref{def_family_of_matrix_unit_elements_numbered_by_pairs}\right)\\
&=E_{S_m,T_m}
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_on_matrix_unit_element}\right).
\end{aligned}`),
      paragraph([
        "（ロ）",
        math(String.raw`(E_{S_m,T_m})_{S_j,T_j}=\delta_{m,j}`),
        "。",
        math(String.raw`m=j`),
        " のとき、",
        math(String.raw`S_m=S_j`),
        " かつ ",
        math(String.raw`T_m=T_j`),
        " である。",
        math(String.raw`m\neq j`),
        " のとき、",
        math(String.raw`(N_M,p_M)`),
        " は番号付けなので（",
        ref("claim_numbering_of_pairs_of_subsets_is_numbering"),
        "）、単射の条件（",
        ref("def_numbering_of_finite_set"),
        "）から ",
        math(String.raw`p_M(m)\neq p_M(j)`),
        "、すなわち ",
        math(String.raw`S_m\neq S_j`),
        " または ",
        math(String.raw`T_m\neq T_j`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(E_{S_m,T_m})_{S_j,T_j}
&=\delta_{S_m,S_j}\cdot_{\mathbb{C}}\delta_{T_m,T_j}
&&\left(\because\ \blkref{def_matrix_unit}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ m=j\ \text{のとき}\ S_m=S_j,\ T_m=T_j\text{。}\blkref{def_kronecker_delta}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{m,j}
&&\left(\because\ m=j\text{。}\blkref{def_kronecker_delta}\right),\\[4pt]
(E_{S_m,T_m})_{S_j,T_j}
&=\delta_{S_m,S_j}\cdot_{\mathbb{C}}\delta_{T_m,T_j}
&&\left(\because\ \blkref{def_matrix_unit}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{T_m,T_j}
&&\left(\because\ m\neq j\ \text{かつ}\ S_m\neq S_j\ \text{のとき。}\blkref{def_kronecker_delta}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}z=0_{\mathbb{C}}\right)\\
&=\delta_{m,j}
&&\left(\because\ m\neq j\text{。}\blkref{def_kronecker_delta}\right),\\[4pt]
(E_{S_m,T_m})_{S_j,T_j}
&=\delta_{S_m,S_j}\cdot_{\mathbb{C}}\delta_{T_m,T_j}
&&\left(\because\ \blkref{def_matrix_unit}\right)\\
&=\delta_{S_m,S_j}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ m\neq j\ \text{かつ}\ T_m\neq T_j\ \text{のとき。}\blkref{def_kronecker_delta}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right)\\
&=\delta_{m,j}
&&\left(\because\ m\neq j\text{。}\blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m\neq j`),
        " のときは ",
        math(String.raw`S_m\neq S_j`),
        " か ",
        math(String.raw`T_m\neq T_j`),
        " の少なくとも一方が成り立つので、二つ目か三つ目の式変形のどちらかが当たる。",
      ]),
      paragraph([
        "主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi\left(\sum_{m=1}^{N_M}\lambda_m\ast_A b_m\right)_{S_j,T_j}
&=\mathrm{ent}_{S_j,T_j}\left(\Phi\left(\sum_{m=1}^{N_M}\lambda_m\ast_A b_m\right)\right)
&&\left(\because\ \mathrm{ent}_{S_j,T_j}\ \text{の定義。}\blkref{claim_matrix_entry_map_is_linear_map}\right)\\
&=\mathrm{ent}_{S_j,T_j}\left(\sum_{m=1}^{N_M}\lambda_m\ast_B\Phi(b_m)\right)
&&\left(\because\ \text{線型写像}\ \Phi\ \text{に。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\mathrm{ent}_{S_j,T_j}\left(\sum_{m=1}^{N_M}\lambda_m\ast_B E_{S_m,T_m}\right)
&&\left(\because\ \text{各}\ m\ \text{で（イ）。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{m=1}^{N_M}\lambda_m\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{S_j,T_j}(E_{S_m,T_m})
&&\left(\because\ \text{線型写像}\ \mathrm{ent}_{S_j,T_j}\ \text{に。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{m=1}^{N_M}\lambda_m\cdot_{\mathbb{C}^{\mathrm{vec}}}\delta_{m,j}
&&\left(\because\ \text{各}\ m\ \text{で}\ \mathrm{ent}_{S_j,T_j}\ \text{の定義と（ロ）。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{m=1}^{N_M}\delta_{m,j}\cdot_{\mathbb{C}^{\mathrm{vec}}}\lambda_m
&&\left(\because\ \text{各}\ m\ \text{で}\ \lambda_m\cdot_{\mathbb{C}}\delta_{m,j}=\delta_{m,j}\cdot_{\mathbb{C}}\lambda_m\text{。}\blkref{def_complex_numbers_as_complex_vector_space}\text{、}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\lambda_j
&&\left(\because\ V:=\mathbb{C}^{\mathrm{vec}}\text{、}n:=N_M\ge 1\text{、}b_k:=\lambda_k\ \text{に。}\blkref{claim_family_member_is_kronecker_delta_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " は ℂ-線型空間であり（",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）、",
        math(String.raw`N_M\ge 1`),
        " は ",
        ref("def_numbering_of_pairs_of_subsets"),
        " で確かめた。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_family_of_matrix_unit_elements_is_linearly_independent",
    kind: "claim",
    title: { text: "行列単位にあたる元の族は一次独立である" },
    labels: ["claim_family_of_matrix_unit_elements_is_linearly_independent"],
    statement: [
      paragraph([
        math(String.raw`b:\{1,\dots,N_M\}\to\mathrm{Cl}(V,q)`),
        " を ",
        ref("def_family_of_matrix_unit_elements_numbered_by_pairs"),
        " の族とする。",
        math(String.raw`b`),
        " は ℂ-線型空間 ",
        math(String.raw`U_{\mathrm{vec}}(\mathrm{Cl}(V,q))`),
        " の中で一次独立（",
        ref("def_linear_independence"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`),
        "、",
        math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と置き、",
        math(String.raw`\Phi`),
        " を ",
        ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        " の準同型とする。",
        math(String.raw`\{1,\dots,N_M\}`),
        " の各元 ",
        math(String.raw`m`),
        " に ",
        math(String.raw`\lambda_m\in\mathbb{C}`),
        " が与えられ、",
        math(String.raw`\sum_{m=1}^{N_M}\lambda_m\ast_A b_m=0_A`),
        " が成り立つとする。",
        math(String.raw`j\in\{1,\dots,N_M\}`),
        " をとり、",
        math(String.raw`S_j,T_j`),
        " を ",
        ref("def_family_of_matrix_unit_elements_numbered_by_pairs"),
        " のものとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda_j
&=\Phi\left(\sum_{m=1}^{N_M}\lambda_m\ast_A b_m\right)_{S_j,T_j}
&&\left(\because\ \blkref{claim_entry_of_image_of_linear_combination_of_matrix_unit_elements}\ \text{を右辺から左辺へ読む}\right)\\
&=\Phi(0_A)_{S_j,T_j}
&&\left(\because\ \text{仮定}\right)\\
&=(0_B)_{S_j,T_j}
&&\left(\because\ \Phi\ \text{は}\ U_{\mathrm{vec}}(A)\ \text{から}\ U_{\mathrm{vec}}(B)\ \text{への線型写像。}\blkref{claim_linear_map_sends_zero_to_zero}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \text{零行列。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`j`),
        " は任意だったので、すべての ",
        math(String.raw`j\in\{1,\dots,N_M\}`),
        " について ",
        math(String.raw`\lambda_j=0_{\mathbb{C}}`),
        " であり、",
        math(String.raw`b`),
        " は一次独立である（",
        ref("def_linear_independence"),
        "）。",
        math(String.raw`\Phi`),
        " が線型写像であることは ",
        ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        " と ",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        " による。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_family_of_matrix_unit_elements_spans_clifford_algebra",
    kind: "claim",
    title: { text: "行列単位にあたる元の族はクリフォード代数を線型結合で張る" },
    labels: ["claim_family_of_matrix_unit_elements_spans_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`\Phi`),
        " を ",
        ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        " の準同型、",
        math(String.raw`N_M`),
        "、",
        math(String.raw`S_m`),
        "、",
        math(String.raw`T_m`),
        "、",
        math(String.raw`b`),
        " を ",
        ref("def_family_of_matrix_unit_elements_numbered_by_pairs"),
        " のものとし、",
        math(String.raw`A:=\mathrm{Cl}(V,q)`),
        " と書く。すべての ",
        math(String.raw`x\in A`),
        " について、",
        math(String.raw`\lambda_m:=\Phi(x)_{S_m,T_m}\in\mathbb{C}`),
        "（",
        math(String.raw`m\in\{1,\dots,N_M\}`),
        "）と置くと次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{m=1}^{N_M}\lambda_m\ast_A b_m=x`),
      paragraph([
        "したがって ",
        math(String.raw`b`),
        " は ",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        " を線型結合で張る（",
        ref("def_spanning_family"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\Psi`),
        " を ",
        ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"),
        " の写像とし、",
        math(String.raw`y:=\sum_{m=1}^{N_M}\lambda_m\ast_A b_m\in A`),
        " と置く。まず ",
        math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元として ",
        math(String.raw`\Phi(y)=\Phi(x)`),
        " を示す。",
        math(String.raw`(S,T)\in\mathcal{P}_M\times\mathcal{P}_M`),
        " をとる。",
        math(String.raw`(N_M,p_M)`),
        " は ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M`),
        " の番号付けなので（",
        ref("claim_numbering_of_pairs_of_subsets_is_numbering"),
        "）、",
        math(String.raw`j:=p_M^{-1}((S,T))\in\{1,\dots,N_M\}`),
        " は ",
        math(String.raw`p_M(j)=(S,T)`),
        "、すなわち ",
        math(String.raw`S_j=S`),
        " かつ ",
        math(String.raw`T_j=T`),
        " を満たす（",
        ref("def_numbering_of_finite_set"),
        "、",
        ref("def_family_of_matrix_unit_elements_numbered_by_pairs"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi(y)_{S,T}
&=\Phi(y)_{S_j,T_j}
&&\left(\because\ S=S_j,\ T=T_j\right)\\
&=\lambda_j
&&\left(\because\ y\ \text{の置き方と}\ \blkref{claim_entry_of_image_of_linear_combination_of_matrix_unit_elements}\right)\\
&=\Phi(x)_{S_j,T_j}
&&\left(\because\ \lambda_j\ \text{の置き方}\right)\\
&=\Phi(x)_{S,T}
&&\left(\because\ S_j=S,\ T_j=T\right).
\end{aligned}`),
      paragraph([
        math(String.raw`(S,T)`),
        " は任意だったので ",
        math(String.raw`\Phi(y)=\Phi(x)`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{m=1}^{N_M}\lambda_m\ast_A b_m
&=y
&&\left(\because\ y\ \text{の置き方}\right)\\
&=\Psi\bigl(\Phi(y)\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right)\\
&=\Psi\bigl(\Phi(x)\bigr)
&&\left(\because\ \Phi(y)=\Phi(x)\right)\\
&=x
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x\in A`),
        " は任意だったので、",
        math(String.raw`b`),
        " は ",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        " を線型結合で張る（",
        ref("def_spanning_family"),
        "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_theorem_matrix_unit_elements_form_basis_of_clifford_algebra",
    kind: "theorem",
    title: { text: "系：行列単位にあたる元の族は、分裂した二次空間のクリフォード代数の基底である" },
    labels: ["theorem_matrix_unit_elements_form_basis_of_clifford_algebra"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`\mathrm{Cl}(V,q)`),
        " を ",
        ref("def_clifford_algebra_of_split_quadratic_space"),
        " の分裂した二次空間のクリフォード代数、",
        math(String.raw`\mathcal{E}_{S,T}`),
        " を ",
        ref("def_matrix_unit_element_of_split_clifford_algebra"),
        " の行列単位にあたる元、",
        math(String.raw`N_M=(2^M)^2`),
        " と ",
        math(String.raw`p_M(m)=(S_m,T_m)`),
        " を ",
        ref("def_numbering_of_pairs_of_subsets"),
        " の ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M`),
        " の番号付け（",
        ref("claim_numbering_of_pairs_of_subsets_is_numbering"),
        "）とする。族 ",
        math(String.raw`b:\{1,\dots,N_M\}\to\mathrm{Cl}(V,q)`),
        "、",
        math(String.raw`b_m:=\mathcal{E}_{S_m,T_m}`),
        "（",
        ref("def_family_of_matrix_unit_elements_numbered_by_pairs"),
        "）は、ℂ-線型空間 ",
        math(String.raw`U_{\mathrm{vec}}(\mathrm{Cl}(V,q))`),
        " の基底（",
        ref("def_basis"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`b`),
        " は一次独立であり（",
        ref("claim_family_of_matrix_unit_elements_is_linearly_independent"),
        "）、",
        math(String.raw`U_{\mathrm{vec}}(\mathrm{Cl}(V,q))`),
        " を線型結合で張る（",
        ref("claim_family_of_matrix_unit_elements_spans_clifford_algebra"),
        "）。したがって ",
        math(String.raw`b`),
        " は基底である（",
        ref("def_basis"),
        "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_general_even_dimensional_nondegenerate_quadratic_space_heading",
    kind: "heading",
    level: 2,
    title: { text: "系：一般の偶数次元の非退化な二次空間" },
    labels: [],
  },
  {
    id: "isomorphism_claim_polarization_of_quadratic_form_is_linear_in_second_argument",
    kind: "claim",
    title: { text: "二次形式に付随する双線型形式は、第二引数についても線型形式である" },
    labels: ["claim_polarization_of_quadratic_form_is_linear_in_second_argument"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の二次形式（", ref("def_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式とする。このとき、各 ",
        math(String.raw`x\in V`), " について、写像 ", math(String.raw`B_q(x,\bullet):V\to\mathbb{C}`), "、", math(String.raw`y\mapsto B_q(x,y)`),
        " は ", math(String.raw`V`), " 上の線型形式（", ref("def_linear_form"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y,y'\in V`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
B_q(x,y+_V y')
&=B_q(y+_V y',x)
&&\left(\because\ \blkref{claim_polarization_is_symmetric}\right)\\
&=B_q(y,x)+_{\mathbb{C}}B_q(y',x)
&&\left(\because\ B_q(\bullet,x)\ \text{は線型形式。}\blkref{def_quadratic_form}\text{、}\blkref{def_linear_form}\right)\\
&=B_q(x,y)+_{\mathbb{C}}B_q(x,y')
&&\left(\because\ \blkref{claim_polarization_is_symmetric}\ \text{を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
B_q(x,\lambda\cdot_V y)
&=B_q(\lambda\cdot_V y,x)
&&\left(\because\ \blkref{claim_polarization_is_symmetric}\right)\\
&=\lambda\cdot_{\mathbb{C}}B_q(y,x)
&&\left(\because\ B_q(\bullet,x)\ \text{は線型形式。}\blkref{def_quadratic_form}\text{、}\blkref{def_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}B_q(x,y)
&&\left(\because\ \blkref{claim_polarization_is_symmetric}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、", math(String.raw`B_q(x,\bullet)`), " は ", math(String.raw`V`), " 上の線型形式である（", ref("def_linear_form"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_polarization_of_quadratic_form_on_diagonal_is_twice_value",
    kind: "claim",
    title: { text: "二次形式に付随する双線型形式の、同じ元の組での値は、二次形式の値の 2 倍である" },
    labels: ["claim_polarization_of_quadratic_form_on_diagonal_is_twice_value"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の二次形式（", ref("def_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式とする。このとき、すべての ",
        math(String.raw`x\in V`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`B_q(x,x)=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}q(x)`),
    ],
    proof: [
      paragraph([
        math(String.raw`\tau:=1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}\in\mathbb{C}`), "、", math(String.raw`a:=q(x)\in\mathbb{C}`), " と置き、",
        math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`z`), " の加法の逆元を ", math(String.raw`-_{\mathbb{C}}z`), " と書く。準備として、",
        math(String.raw`z\in\mathbb{C}`), " について次の等式を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau\cdot_{\mathbb{C}}z
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}z
&&\left(\because\ \tau\ \text{の定義}\right)\\
&=(1_{\mathbb{C}}\cdot_{\mathbb{C}}z)+_{\mathbb{C}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}z)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=z+_{\mathbb{C}}z
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元（二か所に適用）}\right).
\end{aligned}`),
      paragraph(["さらに、", math(String.raw`V`), " の中で次の等式を置く。"]),
      displayMath(String.raw`\begin{aligned}
x+_V x
&=(1_{\mathbb{C}}\cdot_V x)+_V(1_{\mathbb{C}}\cdot_V x)
&&\left(\because\ \text{スカラー倍の単位元（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_V x
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\tau\cdot_V x
&&\left(\because\ \tau\ \text{の定義}\right).
\end{aligned}`),
      paragraph(["主張の左辺から始める。"]),
      displayMath(String.raw`\begin{aligned}
B_q(x,x)
&=0_{\mathbb{C}}+_{\mathbb{C}}B_q(x,x)
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=\Bigl(\bigl(-_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\Bigr)+_{\mathbb{C}}B_q(x,x)
&&\left(\because\ \mathbb{C}\ \text{の加法の逆元}\right)\\
&=\bigl(-_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}\Bigl((\tau\cdot_{\mathbb{C}}a)+_{\mathbb{C}}B_q(x,x)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=\bigl(-_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}\Bigl((a+_{\mathbb{C}}a)+_{\mathbb{C}}B_q(x,x)\Bigr)
&&\left(\because\ \text{一つ目の準備の等式で}\ z:=a\right)\\
&=\bigl(-_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}q(x+_V x)
&&\left(\because\ \blkref{claim_polarization_identity}\ \text{で二つの元をともに}\ x\ \text{にとる}\right)\\
&=\bigl(-_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}q(\tau\cdot_V x)
&&\left(\because\ \text{二つ目の準備の等式}\right)\\
&=\bigl(-_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}\bigl(\tau\cdot_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)
&&\left(\because\ \text{二次形式の一つ目の条件。}\blkref{def_quadratic_form}\right)\\
&=\bigl(-_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}\bigl((\tau\cdot_{\mathbb{C}}a)+_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)
&&\left(\because\ \text{一つ目の準備の等式で}\ z:=\tau\cdot_{\mathbb{C}}a\right)\\
&=\Bigl(\bigl(-_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)\Bigr)+_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}(\tau\cdot_{\mathbb{C}}a)
&&\left(\because\ \mathbb{C}\ \text{の加法の逆元}\right)\\
&=\tau\cdot_{\mathbb{C}}a
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}q(x)
&&\left(\because\ \tau,\ a\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_quadratic_form_at_sum_with_scalar_multiple",
    kind: "claim",
    title: { text: "二次形式の、元と別の元のスカラー倍の和での値" },
    labels: ["claim_quadratic_form_at_sum_with_scalar_multiple"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の二次形式（", ref("def_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式とする。このとき、すべての ",
        math(String.raw`x,y\in V`), "、", math(String.raw`t\in\mathbb{C}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`q(x+_V t\cdot_V y)=\Bigl(q(x)+_{\mathbb{C}}t\cdot_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}q(y)\bigr)\Bigr)+_{\mathbb{C}}t\cdot_{\mathbb{C}}B_q(x,y)`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
q(x+_V t\cdot_V y)
&=\bigl(q(x)+_{\mathbb{C}}q(t\cdot_V y)\bigr)+_{\mathbb{C}}B_q(x,t\cdot_V y)
&&\left(\because\ \blkref{claim_polarization_identity}\ \text{の二つ目の元に}\ t\cdot_V y\ \text{を入れ、右辺から左辺へ読む}\right)\\
&=\Bigl(q(x)+_{\mathbb{C}}t\cdot_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}q(y)\bigr)\Bigr)+_{\mathbb{C}}B_q(x,t\cdot_V y)
&&\left(\because\ \text{二次形式の一つ目の条件。}\blkref{def_quadratic_form}\right)\\
&=\Bigl(q(x)+_{\mathbb{C}}t\cdot_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}q(y)\bigr)\Bigr)+_{\mathbb{C}}t\cdot_{\mathbb{C}}B_q(x,y)
&&\left(\because\ B_q(x,\bullet)\ \text{はスカラー倍を保つ。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_member_of_linearly_independent_family_is_nonzero",
    kind: "claim",
    title: { text: "一次独立な族の元は零ベクトルでない" },
    labels: ["claim_member_of_linearly_independent_family_is_nonzero"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 1}`), "、",
        math(String.raw`b:\{1,\dots,n\}\to V`), " を一次独立な番号付けた族（", ref("def_linear_independence"), "）とし、", math(String.raw`b_k:=b(k)`),
        " と書く。このとき、すべての ", math(String.raw`j\in\{1,\dots,n\}`), " について ", math(String.raw`b_j\neq 0_V`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j\in\{1,\dots,n\}`), " を取り、", math(String.raw`b_j=0_V`), " と仮定する。", math(String.raw`\delta_{k,j}\in\mathbb{C}`),
        " を ", math(String.raw`\{1,\dots,n\}`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n}\delta_{k,j}\cdot_V b_k
&=b_j
&&\left(\because\ \blkref{claim_family_member_is_kronecker_delta_linear_combination}\right)\\
&=0_V
&&\left(\because\ \text{仮定}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`b`), " は一次独立なので、係数 ", math(String.raw`\lambda_k:=\delta_{k,j}`), " について ", math(String.raw`\delta_{j,j}=0_{\mathbb{C}}`),
        " である（", ref("def_linear_independence"), "）。一方 ", math(String.raw`\delta_{j,j}=1_{\mathbb{C}}`), " であり（", ref("def_kronecker_delta"),
        "）、", math(String.raw`\mathbb{C}`), " の中で ", math(String.raw`1_{\mathbb{C}}\neq 0_{\mathbb{C}}`), " である。これは矛盾なので、",
        math(String.raw`b_j\neq 0_V`), " である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_ordered_sum_of_zero_terms_is_zero",
    kind: "claim",
    title: { text: "どの項も 0 である ℂ の中の番号順の和は 0 である" },
    labels: ["claim_ordered_sum_of_zero_terms_is_zero"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`), " とし、", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`\mathbb{C}`),
        " の元 ", math(String.raw`\alpha_k`), " が一つずつ与えられ、すべての ", math(String.raw`k\in\{1,\dots,n\}`), " について ",
        math(String.raw`\alpha_k=0_{\mathbb{C}}`), " であるとする。このとき、", math(String.raw`\mathbb{C}`), " の中の番号順の和（",
        ref("def_ordered_sum_in_complex_numbers"), "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{\mathbb{C},\,k=1}^{n}\alpha_k=0_{\mathbb{C}}`),
    ],
    proof: [
      paragraph([
        ref("def_ordered_sum_in_complex_numbers"), " が帰納的に定める ", math(String.raw`\mathbb{C}`), " の元を ", math(String.raw`S_m`), "（",
        math(String.raw`m\in\{0,1,\dots,n\}`), "）とする。すべての ", math(String.raw`m`), " について ", math(String.raw`S_m=0_{\mathbb{C}}`),
        " であることを ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=n`), " の場合が主張である。", math(String.raw`m=0`),
        " のときは ", math(String.raw`S_0:=0_{\mathbb{C}}`), " である（", ref("def_ordered_sum_in_complex_numbers"), "）。", math(String.raw`1\le m\le n`),
        " で ", math(String.raw`S_{m-1}=0_{\mathbb{C}}`), " とすると：",
      ]),
      displayMath(String.raw`\begin{aligned}
S_m
&=S_{m-1}+_{\mathbb{C}}\alpha_m
&&\left(\because\ \blkref{def_ordered_sum_in_complex_numbers}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}\alpha_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{仮定}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_element_orthogonal_to_spanning_family_is_zero",
    kind: "claim",
    title: { text: "非退化な二次形式について、張る族のどの元とも直交する元は零ベクトルである" },
    labels: ["claim_element_orthogonal_to_spanning_family_is_zero"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の非退化な二次形式（", ref("def_nondegenerate_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式とする。",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`), "、", math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " を線型結合で張る族（",
        ref("def_spanning_family"), "）とし、", math(String.raw`b_k:=b(k)`), " と書く。", math(String.raw`x\in V`), " が、すべての ",
        math(String.raw`k\in\{1,\dots,n\}`), " について ", math(String.raw`B_q(x,b_k)=0_{\mathbb{C}}`), " を満たすならば、", math(String.raw`x=0_V`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y\in V`), " を任意に取る。", math(String.raw`b`), " は ", math(String.raw`V`), " を張るので、", math(String.raw`\sum_{k=1}^{n}\mu_k\cdot_V b_k=y`),
        " を満たす ", math(String.raw`\mu_k\in\mathbb{C}`), "（", math(String.raw`k\in\{1,\dots,n\}`), "）が取れる（", ref("def_spanning_family"),
        "）。準備として、各 ", math(String.raw`k\in\{1,\dots,n\}`), " について次の等式を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu_k\cdot_{\mathbb{C}}B_q(x,b_k)
&=\mu_k\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{仮定}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
B_q(x,y)
&=B_q\left(x,\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)
&&\left(\because\ \mu_k\ \text{の取り方}\right)\\
&=\sum_{\mathbb{C},\,k=1}^{n}\mu_k\cdot_{\mathbb{C}}B_q(x,b_k)
&&\left(\because\ B_q(x,\bullet)\ \text{は線型形式。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\text{、}\blkref{claim_linear_form_maps_linear_combination_to_ordered_sum}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \text{準備の等式で各項が}\ 0_{\mathbb{C}}\text{。}\blkref{claim_ordered_sum_of_zero_terms_is_zero}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`y`), " は任意だったので、", math(String.raw`q`), " が非退化であることから ", math(String.raw`x=0_V`), " である（",
        ref("def_nondegenerate_quadratic_form"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_family_adding_multiples_of_one_member",
    kind: "definition",
    title: { text: "番号付けた族の各元に、一つの元の倍を足した族" },
    labels: ["def_family_adding_multiples_of_one_member"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 1}`), "、",
        math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の元の番号付けた族（", ref("def_linear_independence"), "）とし、",
        math(String.raw`b_k:=b(k)`), " と書く。", math(String.raw`s\in\{1,\dots,n\}`), " と写像 ", math(String.raw`c:\{1,\dots,n\}\to\mathbb{C}`),
        "（", math(String.raw`c_r:=c(r)`), " と書く）について、番号付けた族 ", math(String.raw`b^{(s,c)}:\{1,\dots,n\}\to V`), " を次で定める。",
      ]),
      displayMath(String.raw`b^{(s,c)}_r:=b_r+_V(c_r\cdot_V b_s)\qquad(r\in\{1,\dots,n\})`),
      paragraph([
        math(String.raw`b^{(s,c)}`), " を、", math(String.raw`b`), " の各元に第 ", math(String.raw`s`), " 元の倍を足した族と呼ぶ。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged",
    kind: "claim",
    title: { text: "一つの元の倍を足した族で、係数が 0 の番号の元は変わらない" },
    labels: ["claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`n`), "、", math(String.raw`b`), "、", math(String.raw`s`), "、", math(String.raw`c`), "、",
        math(String.raw`b^{(s,c)}`), " を ", ref("def_family_adding_multiples_of_one_member"), " のものとする。", math(String.raw`r\in\{1,\dots,n\}`),
        " が ", math(String.raw`c_r=0_{\mathbb{C}}`), " を満たすならば、", math(String.raw`b^{(s,c)}_r=b_r`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
b^{(s,c)}_r
&=b_r+_V(c_r\cdot_V b_s)
&&\left(\because\ \blkref{def_family_adding_multiples_of_one_member}\right)\\
&=b_r+_V(0_{\mathbb{C}}\cdot_V b_s)
&&\left(\because\ \text{仮定}\right)\\
&=b_r+_V 0_V
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=b_r
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_linear_combination_of_family_adding_multiples_of_one_member",
    kind: "claim",
    title: { text: "一つの元の倍を足した族の線型結合を、元の族の線型結合で書く" },
    labels: ["claim_linear_combination_of_family_adding_multiples_of_one_member"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`n`), "、", math(String.raw`b`), "、", math(String.raw`s`), "、", math(String.raw`c`), "、",
        math(String.raw`b^{(s,c)}`), " を ", ref("def_family_adding_multiples_of_one_member"), " のものとし、", math(String.raw`\{1,\dots,n\}`),
        " の各元 ", math(String.raw`k`), " に ", math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`\nu_k`),
        " が一つずつ与えられているとする。このとき、線型結合（", ref("def_linear_combination"), "）と ", math(String.raw`\mathbb{C}`),
        " の中の番号順の和（", ref("def_ordered_sum_in_complex_numbers"), "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n}\nu_k\cdot_V b^{(s,c)}_k=\left(\sum_{k=1}^{n}\nu_k\cdot_V b_k\right)+_V\left(\sum_{\mathbb{C},\,k=1}^{n}\nu_k\cdot_{\mathbb{C}}c_k\right)\cdot_V b_s`),
    ],
    proof: [
      paragraph([
        "線型結合の定義（", ref("def_linear_combination"), "）が族 ", math(String.raw`b^{(s,c)}`), " と族 ", math(String.raw`b`), " について帰納的に定める ",
        math(String.raw`V`), " の元を、順に ", math(String.raw`L'_m`), "、", math(String.raw`L_m`), " と書き、", math(String.raw`\mathbb{C}`),
        " の中の番号順の和の定義（", ref("def_ordered_sum_in_complex_numbers"), "）が ", math(String.raw`\alpha_k:=\nu_k\cdot_{\mathbb{C}}c_k`),
        " について帰納的に定める ", math(String.raw`\mathbb{C}`), " の元を ", math(String.raw`S_m`), " と書く（", math(String.raw`m\in\{0,1,\dots,n\}`),
        "）。すべての ", math(String.raw`m`), " について ", math(String.raw`L'_m=L_m+_V(S_m\cdot_V b_s)`), " であることを ", math(String.raw`m`),
        " についての帰納法で示す。", math(String.raw`m=n`), " の場合が主張である。", math(String.raw`m=0`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
L'_0
&=0_V
&&\left(\because\ \blkref{def_linear_combination}\right)\\
&=0_V+_V 0_V
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=0_V+_V(0_{\mathbb{C}}\cdot_V b_s)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\ \text{を右辺から左辺へ読む}\right)\\
&=L_0+_V(S_0\cdot_V b_s)
&&\left(\because\ L_0:=0_V\text{、}S_0:=0_{\mathbb{C}}\text{。}\blkref{def_linear_combination}\text{、}\blkref{def_ordered_sum_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n`), " で ", math(String.raw`L'_{m-1}=L_{m-1}+_V(S_{m-1}\cdot_V b_s)`), " とする。", math(String.raw`A:=L_{m-1}`), "、",
        math(String.raw`\sigma:=S_{m-1}`), " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
L'_m
&=L'_{m-1}+_V(\nu_m\cdot_V b^{(s,c)}_m)
&&\left(\because\ \blkref{def_linear_combination}\right)\\
&=\bigl(A+_V(\sigma\cdot_V b_s)\bigr)+_V(\nu_m\cdot_V b^{(s,c)}_m)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\bigl(A+_V(\sigma\cdot_V b_s)\bigr)+_V\Bigl(\nu_m\cdot_V\bigl(b_m+_V(c_m\cdot_V b_s)\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_adding_multiples_of_one_member}\right)\\
&=\bigl(A+_V(\sigma\cdot_V b_s)\bigr)+_V\Bigl((\nu_m\cdot_V b_m)+_V\bigl(\nu_m\cdot_V(c_m\cdot_V b_s)\bigr)\Bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(A+_V(\sigma\cdot_V b_s)\bigr)+_V\Bigl((\nu_m\cdot_V b_m)+_V\bigl((\nu_m\cdot_{\mathbb{C}}c_m)\cdot_V b_s\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=A+_V\Bigl((\sigma\cdot_V b_s)+_V\Bigl((\nu_m\cdot_V b_m)+_V\bigl((\nu_m\cdot_{\mathbb{C}}c_m)\cdot_V b_s\bigr)\Bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=A+_V\Bigl(\bigl((\sigma\cdot_V b_s)+_V(\nu_m\cdot_V b_m)\bigr)+_V\bigl((\nu_m\cdot_{\mathbb{C}}c_m)\cdot_V b_s\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=A+_V\Bigl(\bigl((\nu_m\cdot_V b_m)+_V(\sigma\cdot_V b_s)\bigr)+_V\bigl((\nu_m\cdot_{\mathbb{C}}c_m)\cdot_V b_s\bigr)\Bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=A+_V\Bigl((\nu_m\cdot_V b_m)+_V\Bigl((\sigma\cdot_V b_s)+_V\bigl((\nu_m\cdot_{\mathbb{C}}c_m)\cdot_V b_s\bigr)\Bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(A+_V(\nu_m\cdot_V b_m)\bigr)+_V\Bigl((\sigma\cdot_V b_s)+_V\bigl((\nu_m\cdot_{\mathbb{C}}c_m)\cdot_V b_s\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(A+_V(\nu_m\cdot_V b_m)\bigr)+_V\bigl((\sigma+_{\mathbb{C}}\nu_m\cdot_{\mathbb{C}}c_m)\cdot_V b_s\bigr)
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=L_m+_V\bigl((\sigma+_{\mathbb{C}}\nu_m\cdot_{\mathbb{C}}c_m)\cdot_V b_s\bigr)
&&\left(\because\ A:=L_{m-1}\text{。}\blkref{def_linear_combination}\right)\\
&=L_m+_V(S_m\cdot_V b_s)
&&\left(\because\ \sigma:=S_{m-1}\text{。}\blkref{def_ordered_sum_in_complex_numbers}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_family_adding_multiples_of_one_member_to_basis_is_basis",
    kind: "claim",
    title: { text: "基底の各元に一つの元の倍を足した族は、その元自身の係数が 0 なら基底である" },
    labels: ["claim_family_adding_multiples_of_one_member_to_basis_is_basis"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`n`), "、", math(String.raw`b`), "、", math(String.raw`s`), "、", math(String.raw`c`), "、",
        math(String.raw`b^{(s,c)}`), " を ", ref("def_family_adding_multiples_of_one_member"), " のものとし、", math(String.raw`b`), " は ",
        math(String.raw`V`), " の基底（", ref("def_basis"), "）、", math(String.raw`c_s=0_{\mathbb{C}}`), " とする。このとき ", math(String.raw`b^{(s,c)}`),
        " は ", math(String.raw`V`), " の基底である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`z`), " の加法の逆元を ", math(String.raw`-_{\mathbb{C}}z`), " と書き、", math(String.raw`\delta_{k,j}\in\mathbb{C}`),
        " を ", math(String.raw`\{1,\dots,n\}`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）とする。", math(String.raw`c_s=0_{\mathbb{C}}`),
        " なので ", math(String.raw`b^{(s,c)}_s=b_s`), " である（", ref("claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged"), "）。",
      ]),
      paragraph([
        "（一次独立）", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`\nu_k\in\mathbb{C}`), " が与えられ、",
        math(String.raw`\sum_{k=1}^{n}\nu_k\cdot_V b^{(s,c)}_k=0_V`), " が成り立つとする。", math(String.raw`\sigma:=\sum_{\mathbb{C},\,k=1}^{n}\nu_k\cdot_{\mathbb{C}}c_k\in\mathbb{C}`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
0_V
&=\sum_{k=1}^{n}\nu_k\cdot_V b^{(s,c)}_k
&&\left(\because\ \text{仮定}\right)\\
&=\left(\sum_{k=1}^{n}\nu_k\cdot_V b_k\right)+_V(\sigma\cdot_V b_s)
&&\left(\because\ \blkref{claim_linear_combination_of_family_adding_multiples_of_one_member}\right)\\
&=\left(\sum_{k=1}^{n}\nu_k\cdot_V b_k\right)+_V\left(\sigma\cdot_V\sum_{k=1}^{n}\delta_{k,s}\cdot_V b_k\right)
&&\left(\because\ \blkref{claim_family_member_is_kronecker_delta_linear_combination}\right)\\
&=\left(\sum_{k=1}^{n}\nu_k\cdot_V b_k\right)+_V\left(\sum_{k=1}^{n}(\sigma\cdot_{\mathbb{C}}\delta_{k,s})\cdot_V b_k\right)
&&\left(\because\ \blkref{claim_scalar_multiple_of_linear_combination}\right)\\
&=\sum_{k=1}^{n}(\nu_k+_{\mathbb{C}}\sigma\cdot_{\mathbb{C}}\delta_{k,s})\cdot_V b_k
&&\left(\because\ \blkref{claim_sum_of_linear_combinations_of_same_family}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`b`), " は一次独立なので（", ref("def_basis"), "）、すべての ", math(String.raw`k\in\{1,\dots,n\}`), " について ",
        math(String.raw`\nu_k+_{\mathbb{C}}\sigma\cdot_{\mathbb{C}}\delta_{k,s}=0_{\mathbb{C}}`), " である（", ref("def_linear_independence"),
        "）。これを (*) と呼ぶ。", math(String.raw`k\neq s`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
\nu_k
&=\nu_k+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=\nu_k+_{\mathbb{C}}\sigma\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right)\\
&=\nu_k+_{\mathbb{C}}\sigma\cdot_{\mathbb{C}}\delta_{k,s}
&&\left(\because\ k\neq s\text{。}\blkref{def_kronecker_delta}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ (*)\right).
\end{aligned}`),
      paragraph([
        "したがって各 ", math(String.raw`k\in\{1,\dots,n\}`), " について ", math(String.raw`\nu_k\cdot_{\mathbb{C}}c_k=0_{\mathbb{C}}`), " である（", math(String.raw`k\neq s`),
        " なら ", math(String.raw`\nu_k=0_{\mathbb{C}}`), "、", math(String.raw`k=s`), " なら ", math(String.raw`c_s=0_{\mathbb{C}}`), " で、", math(String.raw`\mathbb{C}`),
        " の中で ", math(String.raw`0_{\mathbb{C}}\cdot_{\mathbb{C}}z=z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}`), "）。よって ", math(String.raw`\sigma=0_{\mathbb{C}}`),
        " である（", ref("claim_ordered_sum_of_zero_terms_is_zero"), "）。", math(String.raw`k=s`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
\nu_s
&=\nu_s+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=\nu_s+_{\mathbb{C}}0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{s,s}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}z=0_{\mathbb{C}}\right)\\
&=\nu_s+_{\mathbb{C}}\sigma\cdot_{\mathbb{C}}\delta_{s,s}
&&\left(\because\ \sigma=0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ (*)\right).
\end{aligned}`),
      paragraph([
        "よってすべての ", math(String.raw`k`), " について ", math(String.raw`\nu_k=0_{\mathbb{C}}`), " であり、", math(String.raw`b^{(s,c)}`), " は一次独立である（",
        ref("def_linear_independence"), "）。",
      ]),
      paragraph([
        "（張る）", math(String.raw`x\in V`), " を任意に取る。", math(String.raw`b`), " は ", math(String.raw`V`), " を張るので（", ref("def_basis"), "）、",
        math(String.raw`\sum_{k=1}^{n}\mu_k\cdot_V b_k=x`), " を満たす ", math(String.raw`\mu_k\in\mathbb{C}`), " が取れる（", ref("def_spanning_family"), "）。",
        math(String.raw`\rho:=\sum_{\mathbb{C},\,k=1}^{n}\mu_k\cdot_{\mathbb{C}}c_k\in\mathbb{C}`), "、", math(String.raw`\nu_k:=\mu_k+_{\mathbb{C}}(-_{\mathbb{C}}\rho)\cdot_{\mathbb{C}}\delta_{k,s}`),
        "（", math(String.raw`k\in\{1,\dots,n\}`), "）と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\sum_{k=1}^{n}\nu_k\cdot_V b^{(s,c)}_k\\
&=\left(\sum_{k=1}^{n}\mu_k\cdot_V b^{(s,c)}_k\right)+_V\left(\sum_{k=1}^{n}\bigl((-_{\mathbb{C}}\rho)\cdot_{\mathbb{C}}\delta_{k,s}\bigr)\cdot_V b^{(s,c)}_k\right)
&&\left(\because\ \blkref{claim_sum_of_linear_combinations_of_same_family}\ \text{を右辺から左辺へ読む}\right)\\
&=\left(\sum_{k=1}^{n}\mu_k\cdot_V b^{(s,c)}_k\right)+_V\left((-_{\mathbb{C}}\rho)\cdot_V\sum_{k=1}^{n}\delta_{k,s}\cdot_V b^{(s,c)}_k\right)
&&\left(\because\ \blkref{claim_scalar_multiple_of_linear_combination}\ \text{を右辺から左辺へ読む}\right)\\
&=\left(\sum_{k=1}^{n}\mu_k\cdot_V b^{(s,c)}_k\right)+_V\bigl((-_{\mathbb{C}}\rho)\cdot_V b^{(s,c)}_s\bigr)
&&\left(\because\ \blkref{claim_family_member_is_kronecker_delta_linear_combination}\right)\\
&=\left(\sum_{k=1}^{n}\mu_k\cdot_V b^{(s,c)}_k\right)+_V\bigl((-_{\mathbb{C}}\rho)\cdot_V b_s\bigr)
&&\left(\because\ b^{(s,c)}_s=b_s\right)\\
&=\left(\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)+_V(\rho\cdot_V b_s)\right)+_V\bigl((-_{\mathbb{C}}\rho)\cdot_V b_s\bigr)
&&\left(\because\ \blkref{claim_linear_combination_of_family_adding_multiples_of_one_member}\right)\\
&=\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)+_V\Bigl((\rho\cdot_V b_s)+_V\bigl((-_{\mathbb{C}}\rho)\cdot_V b_s\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)+_V\bigl((\rho+_{\mathbb{C}}(-_{\mathbb{C}}\rho))\cdot_V b_s\bigr)
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)+_V(0_{\mathbb{C}}\cdot_V b_s)
&&\left(\because\ \mathbb{C}\ \text{の加法の逆元}\right)\\
&=\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)+_V 0_V
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\sum_{k=1}^{n}\mu_k\cdot_V b_k
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=x
&&\left(\because\ \mu_k\ \text{の取り方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x`), " は任意だったので、", math(String.raw`b^{(s,c)}`), " は ", math(String.raw`V`), " を張る（", ref("def_spanning_family"),
        "）。一次独立で張るので、", math(String.raw`b^{(s,c)}`), " は ", math(String.raw`V`), " の基底である（", ref("def_basis"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_basis_orthogonalized_up_to_index",
    kind: "definition",
    title: { text: "第 k 元まで直交化された基底" },
    labels: ["def_basis_orthogonalized_up_to_index"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の二次形式（", ref("def_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、", math(String.raw`e:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の基底（", ref("def_basis"), "）とし、", math(String.raw`e_k:=e(k)`),
        " と書く。", math(String.raw`k\in\{0,1,\dots,n\}`), " とする。次の三つを満たすとき、", math(String.raw`e`), " は ", math(String.raw`q`),
        " について第 ", math(String.raw`k`), " 元まで直交化された基底であるという。",
      ]),
      list([
        [math(String.raw`i,i'\in\{1,\dots,k\}`), "、", math(String.raw`i\neq i'`), " ならば ", math(String.raw`B_q(e_i,e_{i'})=0_{\mathbb{C}}`)],
        [math(String.raw`i\in\{1,\dots,k\}`), " ならば ", math(String.raw`q(e_i)\neq 0_{\mathbb{C}}`)],
        [math(String.raw`i\in\{1,\dots,k\}`), "、", math(String.raw`j\in\{k+1,\dots,n\}`), " ならば ", math(String.raw`B_q(e_i,e_j)=0_{\mathbb{C}}`)],
      ]),
    ],
  },
  {
    id: "isomorphism_claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value",
    kind: "claim",
    title: { text: "第 k 元まで直交化された基底は、第 k+1 元で二次形式が 0 でないものに取り替えられる" },
    labels: ["claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の非退化な二次形式（", ref("def_nondegenerate_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式、",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`k\in\{0,1,\dots,n-1\}`), " とする。", math(String.raw`e:\{1,\dots,n\}\to V`),
        " が ", math(String.raw`q`), " について第 ", math(String.raw`k`), " 元まで直交化された基底（", ref("def_basis_orthogonalized_up_to_index"),
        "）ならば、", math(String.raw`q`), " について第 ", math(String.raw`k`), " 元まで直交化された基底 ", math(String.raw`\tilde e:\{1,\dots,n\}\to V`),
        " であって ", math(String.raw`q(\tilde e_{k+1})\neq 0_{\mathbb{C}}`), " を満たすものが存在する。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`e_r:=e(r)`), " と書き、", math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`z`), " の加法の逆元を ", math(String.raw`-_{\mathbb{C}}z`),
        " と書く。", math(String.raw`q(e_{k+1})\neq 0_{\mathbb{C}}`), " なら ", math(String.raw`\tilde e:=e`), " でよい。以下、", math(String.raw`q(e_{k+1})=0_{\mathbb{C}}`),
        " とする。",
      ]),
      paragraph([
        "（第 ", math(String.raw`k+1`), " 元と直交しない元が後ろにあること）", math(String.raw`B_q(e_{k+1},e_j)\neq 0_{\mathbb{C}}`), " を満たす ",
        math(String.raw`j\in\{k+2,\dots,n\}`), " があることを示す。そのような ", math(String.raw`j`), " が無いと仮定する。すなわち、すべての ",
        math(String.raw`j\in\{k+2,\dots,n\}`), " について ", math(String.raw`B_q(e_{k+1},e_j)=0_{\mathbb{C}}`), " とする。", math(String.raw`j\in\{1,\dots,k\}`),
        " については次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
B_q(e_{k+1},e_j)
&=B_q(e_j,e_{k+1})
&&\left(\because\ \blkref{claim_polarization_is_symmetric}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ j\in\{1,\dots,k\}\text{、}k+1\in\{k+1,\dots,n\}\text{。}\blkref{def_basis_orthogonalized_up_to_index}\ \text{の三つ目の条件}\right).
\end{aligned}`),
      paragraph([math(String.raw`j=k+1`), " については次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
B_q(e_{k+1},e_{k+1})
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}q(e_{k+1})
&&\left(\because\ \blkref{claim_polarization_of_quadratic_form_on_diagonal_is_twice_value}\right)\\
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ q(e_{k+1})=0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "したがってすべての ", math(String.raw`j\in\{1,\dots,n\}`), " について ", math(String.raw`B_q(e_{k+1},e_j)=0_{\mathbb{C}}`), " である。", math(String.raw`e`),
        " は ", math(String.raw`V`), " を張るので（", ref("def_basis"), "）、", math(String.raw`e_{k+1}=0_V`), " である（",
        ref("claim_element_orthogonal_to_spanning_family_is_zero"), "）。一方 ", math(String.raw`e`), " は一次独立なので ", math(String.raw`e_{k+1}\neq 0_V`),
        " である（", ref("def_basis"), "、", ref("claim_member_of_linearly_independent_family_is_nonzero"), "）。これは矛盾である。よってそのような ",
        math(String.raw`j`), " があり、一つ取って固定する。", math(String.raw`\beta:=B_q(e_{k+1},e_j)\in\mathbb{C}`), "、", math(String.raw`\gamma:=q(e_j)\in\mathbb{C}`),
        " と置く。", math(String.raw`\beta\neq 0_{\mathbb{C}}`), " である。",
      ]),
      paragraph([
        "（足す倍の係数の選び方）", math(String.raw`t\cdot_{\mathbb{C}}t=1_{\mathbb{C}}`), " を満たす ", math(String.raw`t\in\mathbb{C}`), " について：",
      ]),
      displayMath(String.raw`\begin{aligned}
q(e_{k+1}+_V t\cdot_V e_j)
&=\Bigl(q(e_{k+1})+_{\mathbb{C}}t\cdot_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}q(e_j)\bigr)\Bigr)+_{\mathbb{C}}t\cdot_{\mathbb{C}}B_q(e_{k+1},e_j)
&&\left(\because\ \blkref{claim_quadratic_form_at_sum_with_scalar_multiple}\right)\\
&=\bigl(0_{\mathbb{C}}+_{\mathbb{C}}t\cdot_{\mathbb{C}}(t\cdot_{\mathbb{C}}\gamma)\bigr)+_{\mathbb{C}}t\cdot_{\mathbb{C}}\beta
&&\left(\because\ q(e_{k+1})=0_{\mathbb{C}}\text{、}\beta,\ \gamma\ \text{の定義}\right)\\
&=t\cdot_{\mathbb{C}}(t\cdot_{\mathbb{C}}\gamma)+_{\mathbb{C}}t\cdot_{\mathbb{C}}\beta
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=(t\cdot_{\mathbb{C}}t)\cdot_{\mathbb{C}}\gamma+_{\mathbb{C}}t\cdot_{\mathbb{C}}\beta
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\gamma+_{\mathbb{C}}t\cdot_{\mathbb{C}}\beta
&&\left(\because\ t\cdot_{\mathbb{C}}t=1_{\mathbb{C}}\right)\\
&=\gamma+_{\mathbb{C}}t\cdot_{\mathbb{C}}\beta
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`t=1_{\mathbb{C}}`), " と ", math(String.raw`t=-_{\mathbb{C}}1_{\mathbb{C}}`), " はどちらも ", math(String.raw`t\cdot_{\mathbb{C}}t=1_{\mathbb{C}}`),
        " を満たす（", math(String.raw`\mathbb{C}`), " の性質）。この二つの ", math(String.raw`t`), " で値がともに ", math(String.raw`0_{\mathbb{C}}`),
        " である、すなわち ", math(String.raw`\gamma+_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}\beta=0_{\mathbb{C}}`), " かつ ",
        math(String.raw`\gamma+_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}\beta=0_{\mathbb{C}}`), " と仮定すると：",
      ]),
      displayMath(String.raw`\begin{aligned}
(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}\beta
&=\bigl(\gamma+_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}\beta\bigr)+_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}\bigl(\gamma+_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}\beta\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則（右辺を展開すると}\ \gamma\ \text{の項が打ち消し合う）}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{仮定した二つの等式}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\ \text{と加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "一方、", math(String.raw`\mathbb{C}`), " の中で ", math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}\neq 0_{\mathbb{C}}`), " であり、",
        math(String.raw`\beta\neq 0_{\mathbb{C}}`), " であり、", math(String.raw`\mathbb{C}`), " の中で 0 でない二つの元の積は 0 でないので、左辺は ",
        math(String.raw`0_{\mathbb{C}}`), " でない。これは矛盾である。よって ", math(String.raw`t\in\{1_{\mathbb{C}},\ -_{\mathbb{C}}1_{\mathbb{C}}\}`), " を ",
        math(String.raw`q(e_{k+1}+_V t\cdot_V e_j)\neq 0_{\mathbb{C}}`), " となるように一つ取って固定できる。",
      ]),
      paragraph([
        "（取り替えた族）写像 ", math(String.raw`c:\{1,\dots,n\}\to\mathbb{C}`), " を ", math(String.raw`c_{k+1}:=t`), "、", math(String.raw`r\neq k+1`), " なら ",
        math(String.raw`c_r:=0_{\mathbb{C}}`), " で定め、", math(String.raw`\tilde e:=e^{(j,c)}`), "（", ref("def_family_adding_multiples_of_one_member"), "）と置く。",
        math(String.raw`j\ge k+2`), " なので ", math(String.raw`j\neq k+1`), " であり、", math(String.raw`c_j=0_{\mathbb{C}}`), " である。よって ", math(String.raw`\tilde e`),
        " は ", math(String.raw`V`), " の基底である（", ref("claim_family_adding_multiples_of_one_member_to_basis_is_basis"), "）。", math(String.raw`r\neq k+1`),
        " なら ", math(String.raw`\tilde e_r=e_r`), " であり（", ref("claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged"), "）、",
        math(String.raw`\tilde e_{k+1}=e_{k+1}+_V t\cdot_V e_j`), " である（", ref("def_family_adding_multiples_of_one_member"), "）。したがって ",
        math(String.raw`q(\tilde e_{k+1})\neq 0_{\mathbb{C}}`), " である。",
      ]),
      paragraph([
        "（", math(String.raw`\tilde e`), " が第 ", math(String.raw`k`), " 元まで直交化されていること）", ref("def_basis_orthogonalized_up_to_index"),
        " の一つ目と二つ目の条件は番号 ", math(String.raw`1,\dots,k`), " の元だけについての条件で、そこでは ", math(String.raw`\tilde e_i=e_i`),
        " なので、", math(String.raw`e`), " の同じ条件から従う。三つ目の条件について、", math(String.raw`i\in\{1,\dots,k\}`), "、",
        math(String.raw`r\in\{k+1,\dots,n\}`), " を取る。", math(String.raw`r\neq k+1`), " なら ", math(String.raw`\tilde e_i=e_i`), "、", math(String.raw`\tilde e_r=e_r`), " なので、", math(String.raw`e`),
        " の三つ目の条件から ", math(String.raw`B_q(\tilde e_i,\tilde e_r)=0_{\mathbb{C}}`), " である。", math(String.raw`r=k+1`), " なら：",
      ]),
      displayMath(String.raw`\begin{aligned}
B_q(\tilde e_i,\tilde e_{k+1})
&=B_q(e_i,e_{k+1}+_V t\cdot_V e_j)
&&\left(\because\ \tilde e_i=e_i\text{、}\tilde e_{k+1}=e_{k+1}+_V t\cdot_V e_j\right)\\
&=B_q(e_i,e_{k+1})+_{\mathbb{C}}B_q(e_i,t\cdot_V e_j)
&&\left(\because\ B_q(e_i,\bullet)\ \text{は加法を保つ。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\right)\\
&=B_q(e_i,e_{k+1})+_{\mathbb{C}}t\cdot_{\mathbb{C}}B_q(e_i,e_j)
&&\left(\because\ B_q(e_i,\bullet)\ \text{はスカラー倍を保つ。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}t\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ k+1,\ j\in\{k+1,\dots,n\}\text{。}\blkref{def_basis_orthogonalized_up_to_index}\ \text{の三つ目の条件を二か所に適用}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\ \text{と加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "よって ", math(String.raw`\tilde e`), " は ", math(String.raw`q`), " について第 ", math(String.raw`k`), " 元まで直交化された基底であり、",
        math(String.raw`q(\tilde e_{k+1})\neq 0_{\mathbb{C}}`), " を満たす。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero",
    kind: "claim",
    title: { text: "二次形式の値が 0 でない元では、付随する双線型形式の同じ元の組での値も 0 でない" },
    labels: ["claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の二次形式（", ref("def_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式とする。", math(String.raw`v\in V`),
        " が ", math(String.raw`q(v)\neq 0_{\mathbb{C}}`), " を満たすならば、", math(String.raw`B_q(v,v)\neq 0_{\mathbb{C}}`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`B_q(v,v)=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}q(v)`), " である（",
        ref("claim_polarization_of_quadratic_form_on_diagonal_is_twice_value"), "）。", math(String.raw`\mathbb{C}`), " の中で ",
        math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}\neq 0_{\mathbb{C}}`), " であり、", math(String.raw`q(v)\neq 0_{\mathbb{C}}`), " であり、",
        math(String.raw`\mathbb{C}`), " の中で 0 でない二つの元の積は 0 でないので、", math(String.raw`B_q(v,v)\neq 0_{\mathbb{C}}`), " である。",
      ]),
      paragraph([
        "次の主張で ", math(String.raw`B_q(v,v)`), " の ", math(String.raw`\mathbb{C}`), " の中の乗法の逆元を使う。それが存在する理由はこの主張であり、",
        math(String.raw`q(v)\neq 0_{\mathbb{C}}`), " に加えて ", math(String.raw`\mathbb{C}`), " の中で ", math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}\neq 0_{\mathbb{C}}`),
        " であること（2 で割れること）を使う。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_orthogonalization_step_extends_orthogonalized_part",
    kind: "claim",
    title: { text: "第 k+1 元と直交するように後ろの元を直すと、第 k+1 元まで直交化された基底になる" },
    labels: ["claim_orthogonalization_step_extends_orthogonalized_part"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の二次形式（", ref("def_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式、", math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、", math(String.raw`k\in\{0,1,\dots,n-1\}`), " とする。", math(String.raw`\tilde e:\{1,\dots,n\}\to V`), " を ", math(String.raw`q`),
        " について第 ", math(String.raw`k`), " 元まで直交化された基底（", ref("def_basis_orthogonalized_up_to_index"), "）で、",
        math(String.raw`q(\tilde e_{k+1})\neq 0_{\mathbb{C}}`), " を満たすものとする。", math(String.raw`v:=\tilde e_{k+1}`), "、",
        math(String.raw`d:=B_q(v,v)`), " と置くと ", math(String.raw`d\neq 0_{\mathbb{C}}`), " であり（",
        ref("claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero"), "）、その ", math(String.raw`\mathbb{C}`), " の中の乗法の逆元を ",
        math(String.raw`d^{-1}`), " と書く。", math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`z`), " の加法の逆元を ", math(String.raw`-_{\mathbb{C}}z`),
        " と書く。写像 ", math(String.raw`c:\{1,\dots,n\}\to\mathbb{C}`), " を次で定める。",
      ]),
      list([
        [math(String.raw`c_r:=0_{\mathbb{C}}`), "（", math(String.raw`r\in\{1,\dots,k+1\}`), "）"],
        [math(String.raw`c_r:=-_{\mathbb{C}}\bigl(B_q(\tilde e_r,v)\cdot_{\mathbb{C}}d^{-1}\bigr)`), "（", math(String.raw`r\in\{k+2,\dots,n\}`), "）"],
      ]),
      paragraph([
        "このとき、", math(String.raw`\tilde e^{(k+1,c)}`), "（", ref("def_family_adding_multiples_of_one_member"), "）は ", math(String.raw`q`),
        " について第 ", math(String.raw`k+1`), " 元まで直交化された基底である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`e':=\tilde e^{(k+1,c)}`), " と置く。", math(String.raw`c_{k+1}=0_{\mathbb{C}}`), " なので ", math(String.raw`e'`), " は ", math(String.raw`V`),
        " の基底である（", ref("claim_family_adding_multiples_of_one_member_to_basis_is_basis"), "）。", math(String.raw`r\in\{1,\dots,k+1\}`), " なら ",
        math(String.raw`c_r=0_{\mathbb{C}}`), " なので ", math(String.raw`e'_r=\tilde e_r`), " であり（", ref("claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged"),
        "）、", math(String.raw`r\in\{k+2,\dots,n\}`), " なら ", math(String.raw`e'_r=\tilde e_r+_V c_r\cdot_V v`), " である（", ref("def_family_adding_multiples_of_one_member"),
        "、", math(String.raw`\tilde e_{k+1}=v`), "）。", ref("def_basis_orthogonalized_up_to_index"), " の三つの条件を、番号 ", math(String.raw`k+1`),
        " について確かめる。",
      ]),
      paragraph([
        "（一つ目の条件）", math(String.raw`i,i'\in\{1,\dots,k+1\}`), "、", math(String.raw`i\neq i'`), " とする。", math(String.raw`e'_i=\tilde e_i`), "、",
        math(String.raw`e'_{i'}=\tilde e_{i'}`), " である。", math(String.raw`i,i'\le k`), " なら ", math(String.raw`\tilde e`), " の一つ目の条件から ",
        math(String.raw`B_q(\tilde e_i,\tilde e_{i'})=0_{\mathbb{C}}`), " である。", math(String.raw`i\le k`), "、", math(String.raw`i'=k+1`), " なら ",
        math(String.raw`\tilde e`), " の三つ目の条件から ", math(String.raw`B_q(\tilde e_i,\tilde e_{k+1})=0_{\mathbb{C}}`), " である。", math(String.raw`i=k+1`), "、",
        math(String.raw`i'\le k`), " なら、", math(String.raw`\tilde e`), " の三つ目の条件から ", math(String.raw`B_q(\tilde e_{i'},\tilde e_{k+1})=0_{\mathbb{C}}`),
        " であり、", ref("claim_polarization_is_symmetric"), " から ", math(String.raw`B_q(\tilde e_{k+1},\tilde e_{i'})=0_{\mathbb{C}}`), " である。",
      ]),
      paragraph([
        "（二つ目の条件）", "番号 ", math(String.raw`i\in\{1,\dots,k+1\}`), " では ", math(String.raw`e'_i=\tilde e_i`), " である。", math(String.raw`i\in\{1,\dots,k\}`),
        " なら、", math(String.raw`\tilde e`), " の二つ目の条件から ", math(String.raw`q(\tilde e_i)\neq 0_{\mathbb{C}}`), " である。", math(String.raw`i=k+1`),
        " なら、仮定から ", math(String.raw`q(\tilde e_{k+1})\neq 0_{\mathbb{C}}`), " である。よって ", math(String.raw`q(e'_i)\neq 0_{\mathbb{C}}`), " である。",
      ]),
      paragraph([
        "（三つ目の条件）", math(String.raw`r\in\{k+2,\dots,n\}`), " を取る。", math(String.raw`i\in\{1,\dots,k\}`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
B_q(e'_i,e'_r)
&=B_q(\tilde e_i,\tilde e_r+_V c_r\cdot_V v)
&&\left(\because\ e'_i=\tilde e_i\text{、}e'_r=\tilde e_r+_V c_r\cdot_V v\right)\\
&=B_q(\tilde e_i,\tilde e_r)+_{\mathbb{C}}B_q(\tilde e_i,c_r\cdot_V v)
&&\left(\because\ B_q(\tilde e_i,\bullet)\ \text{は加法を保つ。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\right)\\
&=B_q(\tilde e_i,\tilde e_r)+_{\mathbb{C}}c_r\cdot_{\mathbb{C}}B_q(\tilde e_i,v)
&&\left(\because\ B_q(\tilde e_i,\bullet)\ \text{はスカラー倍を保つ。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}c_r\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ r,\ k+1\in\{k+1,\dots,n\}\text{、}v=\tilde e_{k+1}\text{。}\tilde e\ \text{の三つ目の条件を二か所に適用}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\ \text{と加法の単位元}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i=k+1`), " のとき、", math(String.raw`\alpha:=B_q(\tilde e_r,v)\in\mathbb{C}`), " と置くと：",
      ]),
      displayMath(String.raw`\begin{aligned}
B_q(e'_{k+1},e'_r)
&=B_q(v,\tilde e_r+_V c_r\cdot_V v)
&&\left(\because\ e'_{k+1}=\tilde e_{k+1}=v\text{、}e'_r=\tilde e_r+_V c_r\cdot_V v\right)\\
&=B_q(v,\tilde e_r)+_{\mathbb{C}}B_q(v,c_r\cdot_V v)
&&\left(\because\ B_q(v,\bullet)\ \text{は加法を保つ。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\right)\\
&=B_q(v,\tilde e_r)+_{\mathbb{C}}c_r\cdot_{\mathbb{C}}B_q(v,v)
&&\left(\because\ B_q(v,\bullet)\ \text{はスカラー倍を保つ。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\right)\\
&=B_q(\tilde e_r,v)+_{\mathbb{C}}c_r\cdot_{\mathbb{C}}B_q(v,v)
&&\left(\because\ \blkref{claim_polarization_is_symmetric}\right)\\
&=\alpha+_{\mathbb{C}}c_r\cdot_{\mathbb{C}}d
&&\left(\because\ \alpha,\ d\ \text{の定義}\right)\\
&=\alpha+_{\mathbb{C}}\bigl(-_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}d^{-1})\bigr)\cdot_{\mathbb{C}}d
&&\left(\because\ r\in\{k+2,\dots,n\}\ \text{での}\ c_r\ \text{の定義}\right)\\
&=\alpha+_{\mathbb{C}}\Bigl(-_{\mathbb{C}}\bigl((\alpha\cdot_{\mathbb{C}}d^{-1})\cdot_{\mathbb{C}}d\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の中で}\ (-_{\mathbb{C}}z)\cdot_{\mathbb{C}}w=-_{\mathbb{C}}(z\cdot_{\mathbb{C}}w)\right)\\
&=\alpha+_{\mathbb{C}}\Bigl(-_{\mathbb{C}}\bigl(\alpha\cdot_{\mathbb{C}}(d^{-1}\cdot_{\mathbb{C}}d)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\alpha+_{\mathbb{C}}\bigl(-_{\mathbb{C}}(\alpha\cdot_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ d^{-1}\ \text{は}\ d\ \text{の乗法の逆元}\right)\\
&=\alpha+_{\mathbb{C}}(-_{\mathbb{C}}\alpha)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の加法の逆元}\right).
\end{aligned}`),
      paragraph([
        "三つの条件が満たされたので、", math(String.raw`e'`), " は ", math(String.raw`q`), " について第 ", math(String.raw`k+1`), " 元まで直交化された基底である（",
        ref("def_basis_orthogonalized_up_to_index"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form",
    kind: "claim",
    title: { text: "基底をもつ ℂ-線型空間の上の非退化な二次形式には、直交基底がある" },
    labels: ["claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の基底（", ref("def_basis"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の非退化な二次形式（", ref("def_nondegenerate_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式とする。このとき、",
        math(String.raw`V`), " の基底 ", math(String.raw`e:\{1,\dots,n\}\to V`), "（", math(String.raw`e_i:=e(i)`), "）であって、次の二つを満たすものが存在する。",
      ]),
      list([
        [math(String.raw`i,j\in\{1,\dots,n\}`), "、", math(String.raw`i\neq j`), " ならば ", math(String.raw`B_q(e_i,e_j)=0_{\mathbb{C}}`)],
        [math(String.raw`i\in\{1,\dots,n\}`), " ならば ", math(String.raw`q(e_i)\neq 0_{\mathbb{C}}`)],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k\in\{0,1,\dots,n\}`), " について、「", math(String.raw`q`), " について第 ", math(String.raw`k`), " 元まで直交化された ", math(String.raw`V`),
        " の基底 ", math(String.raw`\{1,\dots,n\}\to V`), " が存在する」（", ref("def_basis_orthogonalized_up_to_index"), "）ことを ", math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`), " のとき：", math(String.raw`\{1,\dots,0\}`), " は空集合なので、", ref("def_basis_orthogonalized_up_to_index"),
        " の三つの条件はどれも条件なしに成り立ち、", math(String.raw`b`), " は第 ", math(String.raw`0`), " 元まで直交化された基底である。",
      ]),
      paragraph([
        math(String.raw`k\in\{0,1,\dots,n-1\}`), " で、第 ", math(String.raw`k`), " 元まで直交化された基底 ", math(String.raw`e`), " があるとする（このとき ",
        math(String.raw`n\ge 1`), "）。", math(String.raw`q`), " は非退化なので、第 ", math(String.raw`k`), " 元まで直交化された基底 ", math(String.raw`\tilde e`),
        " で ", math(String.raw`q(\tilde e_{k+1})\neq 0_{\mathbb{C}}`), " を満たすものがある（", ref("claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value"),
        "）。これに ", ref("claim_orthogonalization_step_extends_orthogonalized_part"), " を適用すると、第 ", math(String.raw`k+1`),
        " 元まで直交化された基底が得られる。",
      ]),
      paragraph([
        "帰納法により、第 ", math(String.raw`n`), " 元まで直交化された基底 ", math(String.raw`e`), " がある。", ref("def_basis_orthogonalized_up_to_index"),
        " の一つ目と二つ目の条件で ", math(String.raw`k:=n`), " としたものが、主張の二つの条件である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_existence_of_square_root_in_complex_numbers",
    kind: "claim",
    title: { text: "ℂ の元は ℂ の中に平方根をもつ" },
    labels: ["claim_existence_of_square_root_in_complex_numbers"],
    statement: [
      paragraph([
        "すべての ", math(String.raw`z\in\mathbb{C}`), " について、", math(String.raw`s\cdot_{\mathbb{C}}s=z`), " を満たす ", math(String.raw`s\in\mathbb{C}`),
        " が存在する。",
      ]),
    ],
    proof: [
      paragraph([
        "この主張は ", math(String.raw`\mathbb{C}`), " の四則だけからは示せないので、", math(String.raw`\mathbb{R}`), " と ", math(String.raw`\mathbb{C}`), " の次の二つの事実を使う（",
        math(String.raw`\mathbb{R}`), " への脱出。理由は二つ目の性質が ", math(String.raw`\mathbb{R}`), " の完備性に依ることである）。", math(String.raw`\mathbb{R}`),
        " の中の加法・乗法・順序・除法は添字を付けずに書く。",
      ]),
      list([
        [
          "写像 ", math(String.raw`\rho:\mathbb{R}\to\mathbb{C}`), "（実数を ", math(String.raw`\mathbb{C}`), " の元へ送る写像）と元 ", math(String.raw`\mathrm{i}\in\mathbb{C}`),
          " があり、すべての ", math(String.raw`x,y\in\mathbb{R}`), " について ", math(String.raw`\rho(x+y)=\rho(x)+_{\mathbb{C}}\rho(y)`), "、",
          math(String.raw`\rho(xy)=\rho(x)\cdot_{\mathbb{C}}\rho(y)`), " を満たし、", math(String.raw`\mathrm{i}\cdot_{\mathbb{C}}\mathrm{i}=-_{\mathbb{C}}1_{\mathbb{C}}`),
          " を満たす。", math(String.raw`\mathbb{C}`), " の各元 ", math(String.raw`z`), " は、実数 ", math(String.raw`a,b`), " によって ",
          math(String.raw`z=\rho(a)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\rho(b)`), " と書ける。",
        ],
        [
          "0 以上の実数 ", math(String.raw`t`), " について、", math(String.raw`uu=t`), " を満たす 0 以上の実数 ", math(String.raw`u`),
          " が存在する。これは ", math(String.raw`\mathbb{R}`), " の完備性（上に有界な空でない部分集合が上限をもつこと）から示される性質である。この ",
          math(String.raw`u`), " を ", math(String.raw`\sqrt{t}`), " と書く。",
        ],
      ]),
      paragraph([
        math(String.raw`\rho`), " が加法を保つので、", math(String.raw`x\in\mathbb{R}`), " について ", math(String.raw`\rho(-x)=-_{\mathbb{C}}\rho(x)`),
        " である（", math(String.raw`\rho(0)=\rho(0+0)`), " と ", math(String.raw`\rho(0+0)=\rho(0)+_{\mathbb{C}}\rho(0)`), " から ",
        math(String.raw`\rho(0)=0_{\mathbb{C}}`), "、", math(String.raw`\rho(x)+_{\mathbb{C}}\rho(-x)=\rho(x+(-x))`), " と ", math(String.raw`\rho(x+(-x))=\rho(0)`), " から）。", math(String.raw`z\in\mathbb{C}`), " を任意に取り、実数 ", math(String.raw`a,b`), " で ",
        math(String.raw`z=\rho(a)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\rho(b)`), " と書く。まず、次の二つを満たす実数 ", math(String.raw`u,v`),
        " があることを示す。これを (★) と呼ぶ。",
      ]),
      displayMath(String.raw`uu-vv=a,\qquad 2uv=b`),
      paragraph([
        "（", math(String.raw`b=0`), "、", math(String.raw`a\ge 0`), " の場合）", math(String.raw`u:=\sqrt{a}`), "、", math(String.raw`v:=0`), " と置くと、",
        math(String.raw`uu=a`), "、", math(String.raw`vv=0`), " より ", math(String.raw`uu-vv=a`), " であり、", math(String.raw`v=0`), " より ", math(String.raw`2uv=0`), "、これは ", math(String.raw`b`), " に等しい。",
      ]),
      paragraph([
        "（", math(String.raw`b=0`), "、", math(String.raw`a<0`), " の場合）", math(String.raw`-a>0`), " なので ", math(String.raw`u:=0`), "、",
        math(String.raw`v:=\sqrt{-a}`), " と置くと、", math(String.raw`uu=0`), "、", math(String.raw`vv=-a`), " より ", math(String.raw`uu-vv=a`), " であり、", math(String.raw`u=0`), " より ", math(String.raw`2uv=0`), "、これは ", math(String.raw`b`), " に等しい。",
      ]),
      paragraph([
        "（", math(String.raw`b\neq 0`), " の場合）", math(String.raw`aa+bb\ge 0`), " なので ", math(String.raw`r:=\sqrt{aa+bb}`), " と置く。", math(String.raw`r\ge 0`),
        "、", math(String.raw`rr=aa+bb`), " であり、", math(String.raw`b\neq 0`), " より ", math(String.raw`bb>0`), " なので ", math(String.raw`rr>aa`), " である。",
        math(String.raw`r+a>0`), " を示す。", math(String.raw`a\ge 0`), " なら、", math(String.raw`rr>aa\ge 0`), " より ", math(String.raw`r\neq 0`), " なので ",
        math(String.raw`r>0`), " であり、", math(String.raw`r+a\ge r>0`), " である。", math(String.raw`a<0`), " なら ", math(String.raw`-a>0`), " であり、仮に ",
        math(String.raw`r\le -a`), " とすると、", math(String.raw`0\le r`), " と合わせて ", math(String.raw`rr\le(-a)(-a)`), " となり、", math(String.raw`(-a)(-a)=aa`), " なので ", math(String.raw`rr\le aa`), " となって ", math(String.raw`rr>aa`),
        " に反するので、", math(String.raw`r>-a`), "、すなわち ", math(String.raw`r+a>0`), " である。",
      ]),
      paragraph([
        math(String.raw`(r+a)/2>0`), " なので ", math(String.raw`u:=\sqrt{(r+a)/2}`), " と置く。", math(String.raw`uu=(r+a)/2>0`), " なので ", math(String.raw`u\neq 0`),
        " であり、", math(String.raw`v:=b/(2u)`), " と置ける。このとき ", math(String.raw`2uv=b`), " である（", math(String.raw`v`), " の定義と ", math(String.raw`2u\neq 0`), " での約分）。また次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
uu-vv
&=\frac{r+a}{2}-\frac{b}{2u}\cdot\frac{b}{2u}
&&\left(\because\ u,\ v\ \text{の定義}\right)\\
&=\frac{r+a}{2}-\frac{bb}{4\,uu}
&&\left(\because\ \text{分数の積}\right)\\
&=\frac{r+a}{2}-\frac{bb}{4\cdot\frac{r+a}{2}}
&&\left(\because\ uu=(r+a)/2\right)\\
&=\frac{r+a}{2}-\frac{bb}{2(r+a)}
&&\left(\because\ 4\cdot\tfrac{r+a}{2}=2(r+a)\right)\\
&=\frac{(r+a)(r+a)-bb}{2(r+a)}
&&\left(\because\ \text{通分}\right)\\
&=\frac{rr+2ar+aa-bb}{2(r+a)}
&&\left(\because\ \text{展開}\right)\\
&=\frac{(aa+bb)+2ar+aa-bb}{2(r+a)}
&&\left(\because\ rr=aa+bb\right)\\
&=\frac{2a(r+a)}{2(r+a)}
&&\left(\because\ \text{同類項をまとめる}\right)\\
&=a
&&\left(\because\ 2(r+a)\neq 0\ \text{で約分}\right).
\end{aligned}`),
      paragraph([
        "これで (★) が示された。", math(String.raw`A:=\rho(u)`), "、", math(String.raw`B:=\rho(v)`), "、", math(String.raw`s:=A+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}B\in\mathbb{C}`),
        " と置くと、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
s\cdot_{\mathbb{C}}s
&=(A+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}B)\cdot_{\mathbb{C}}(A+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}B)
&&\left(\because\ s,\ A,\ B\ \text{の定義}\right)\\
&=A\cdot_{\mathbb{C}}(A+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}B)+_{\mathbb{C}}(\mathrm{i}\cdot_{\mathbb{C}}B)\cdot_{\mathbb{C}}(A+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}B)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=\bigl(A\cdot_{\mathbb{C}}A+_{\mathbb{C}}A\cdot_{\mathbb{C}}(\mathrm{i}\cdot_{\mathbb{C}}B)\bigr)+_{\mathbb{C}}\bigl((\mathrm{i}\cdot_{\mathbb{C}}B)\cdot_{\mathbb{C}}A+_{\mathbb{C}}(\mathrm{i}\cdot_{\mathbb{C}}B)\cdot_{\mathbb{C}}(\mathrm{i}\cdot_{\mathbb{C}}B)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則（二か所に適用）}\right)\\
&=\bigl(A\cdot_{\mathbb{C}}A+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}(A\cdot_{\mathbb{C}}B)\bigr)+_{\mathbb{C}}\bigl(\mathrm{i}\cdot_{\mathbb{C}}(B\cdot_{\mathbb{C}}A)+_{\mathbb{C}}(\mathrm{i}\cdot_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}(B\cdot_{\mathbb{C}}B)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則と交換法則（三か所に適用）}\right)\\
&=\bigl(A\cdot_{\mathbb{C}}A+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}(A\cdot_{\mathbb{C}}B)\bigr)+_{\mathbb{C}}\bigl(\mathrm{i}\cdot_{\mathbb{C}}(B\cdot_{\mathbb{C}}A)+_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}(B\cdot_{\mathbb{C}}B)\bigr)
&&\left(\because\ \mathrm{i}\cdot_{\mathbb{C}}\mathrm{i}=-_{\mathbb{C}}1_{\mathbb{C}}\right)\\
&=\bigl(A\cdot_{\mathbb{C}}A+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}(A\cdot_{\mathbb{C}}B)\bigr)+_{\mathbb{C}}\Bigl(\mathrm{i}\cdot_{\mathbb{C}}(B\cdot_{\mathbb{C}}A)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}(B\cdot_{\mathbb{C}}B)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の中で}\ (-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}z=-_{\mathbb{C}}z\right)\\
&=\Bigl(A\cdot_{\mathbb{C}}A+_{\mathbb{C}}\bigl(-_{\mathbb{C}}(B\cdot_{\mathbb{C}}B)\bigr)\Bigr)+_{\mathbb{C}}\bigl(\mathrm{i}\cdot_{\mathbb{C}}(A\cdot_{\mathbb{C}}B)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}(B\cdot_{\mathbb{C}}A)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則と交換法則}\right)\\
&=\Bigl(A\cdot_{\mathbb{C}}A+_{\mathbb{C}}\bigl(-_{\mathbb{C}}(B\cdot_{\mathbb{C}}B)\bigr)\Bigr)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\bigl(A\cdot_{\mathbb{C}}B+_{\mathbb{C}}B\cdot_{\mathbb{C}}A\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=\Bigl(\rho(uu)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}\rho(vv)\bigr)\Bigr)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\bigl(\rho(uv)+_{\mathbb{C}}\rho(vu)\bigr)
&&\left(\because\ \rho\ \text{は乗法を保つ（四か所に適用）}\right)\\
&=\bigl(\rho(uu)+_{\mathbb{C}}\rho(-vv)\bigr)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\bigl(\rho(uv)+_{\mathbb{C}}\rho(vu)\bigr)
&&\left(\because\ \rho(-x)=-_{\mathbb{C}}\rho(x)\right)\\
&=\bigl(\rho(uu)+_{\mathbb{C}}\rho(-vv)\bigr)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\rho(uv+vu)
&&\left(\because\ \rho\ \text{は加法を保つ}\right)\\
&=\rho(uu-vv)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\rho(2uv)
&&\left(\because\ \rho\ \text{は加法を保つ。}uv+vu=2uv\right)\\
&=\rho(a)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\rho(b)
&&\left(\because\ (\bigstar)\right)\\
&=z
&&\left(\because\ a,\ b\ \text{の取り方}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_nonzero_scalar_multiples_of_basis_members_form_basis",
    kind: "claim",
    title: { text: "基底の各元を 0 でないスカラーで倍した族は基底である" },
    labels: ["claim_nonzero_scalar_multiples_of_basis_members_form_basis"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の基底（", ref("def_basis"), "）とし、", math(String.raw`b_k:=b(k)`),
        " と書く。", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`t_k\in\mathbb{C}`), " が一つずつ与えられ、すべての ",
        math(String.raw`k`), " について ", math(String.raw`t_k\neq 0_{\mathbb{C}}`), " であるとする。番号付けた族 ", math(String.raw`b':\{1,\dots,n\}\to V`), " を ",
        math(String.raw`b'_k:=t_k\cdot_V b_k`), " で定める。このとき ", math(String.raw`b'`), " は ", math(String.raw`V`), " の基底である。",
      ]),
    ],
    proof: [
      paragraph([
        "各 ", math(String.raw`k`), " について、", math(String.raw`t_k`), " の ", math(String.raw`\mathbb{C}`), " の中の乗法の逆元を ", math(String.raw`t_k^{-1}`), " と書く（",
        math(String.raw`t_k\neq 0_{\mathbb{C}}`), " なので存在する）。",
      ]),
      paragraph([
        "（一次独立）", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`\nu_k\in\mathbb{C}`), " が与えられ、",
        math(String.raw`\sum_{k=1}^{n}\nu_k\cdot_V b'_k=0_V`), " が成り立つとする。準備として、各 ", math(String.raw`k`), " について次の等式を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\nu_k\cdot_V b'_k
&=\nu_k\cdot_V(t_k\cdot_V b_k)
&&\left(\because\ b'\ \text{の定義}\right)\\
&=(\nu_k\cdot_{\mathbb{C}}t_k)\cdot_V b_k
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0_V
&=\sum_{k=1}^{n}\nu_k\cdot_V b'_k
&&\left(\because\ \text{仮定}\right)\\
&=\sum_{k=1}^{n}(\nu_k\cdot_{\mathbb{C}}t_k)\cdot_V b_k
&&\left(\because\ \text{準備の等式を各項に適用。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`b`), " は一次独立なので（", ref("def_basis"), "）、すべての ", math(String.raw`k`), " について ", math(String.raw`\nu_k\cdot_{\mathbb{C}}t_k=0_{\mathbb{C}}`),
        " である（", ref("def_linear_independence"), "）。したがって次が成り立ち、", math(String.raw`b'`), " は一次独立である（", ref("def_linear_independence"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\nu_k
&=\nu_k\cdot_{\mathbb{C}}(t_k\cdot_{\mathbb{C}}t_k^{-1})
&&\left(\because\ t_k^{-1}\ \text{は}\ t_k\ \text{の乗法の逆元}\right)\\
&=(\nu_k\cdot_{\mathbb{C}}t_k)\cdot_{\mathbb{C}}t_k^{-1}
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}t_k^{-1}
&&\left(\because\ \nu_k\cdot_{\mathbb{C}}t_k=0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}z=0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "（張る）", math(String.raw`x\in V`), " を任意に取る。", math(String.raw`b`), " は ", math(String.raw`V`), " を張るので（", ref("def_basis"), "）、",
        math(String.raw`\sum_{k=1}^{n}\mu_k\cdot_V b_k=x`), " を満たす ", math(String.raw`\mu_k\in\mathbb{C}`), " が取れる（", ref("def_spanning_family"), "）。",
        math(String.raw`\lambda_k:=\mu_k\cdot_{\mathbb{C}}t_k^{-1}`), " と置く。準備として、各 ", math(String.raw`k`), " について次の等式を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda_k\cdot_V b'_k
&=(\mu_k\cdot_{\mathbb{C}}t_k^{-1})\cdot_V(t_k\cdot_V b_k)
&&\left(\because\ \lambda_k,\ b'_k\ \text{の定義}\right)\\
&=\bigl((\mu_k\cdot_{\mathbb{C}}t_k^{-1})\cdot_{\mathbb{C}}t_k\bigr)\cdot_V b_k
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(\mu_k\cdot_{\mathbb{C}}(t_k^{-1}\cdot_{\mathbb{C}}t_k)\bigr)\cdot_V b_k
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(\mu_k\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_V b_k
&&\left(\because\ t_k^{-1}\ \text{は}\ t_k\ \text{の乗法の逆元}\right)\\
&=\mu_k\cdot_V b_k
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n}\lambda_k\cdot_V b'_k
&=\sum_{k=1}^{n}\mu_k\cdot_V b_k
&&\left(\because\ \text{準備の等式を各項に適用。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=x
&&\left(\because\ \mu_k\ \text{の取り方}\right).
\end{aligned}`),
      paragraph([
        "したがって ", math(String.raw`b'`), " は ", math(String.raw`V`), " を張る（", ref("def_spanning_family"), "）。二つを合わせて ", math(String.raw`b'`), " は基底である（",
        ref("def_basis"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form",
    kind: "claim",
    title: { text: "基底をもつ ℂ-線型空間の上の非退化な二次形式には、どの元での値も 1 の直交基底がある" },
    labels: ["claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の基底（", ref("def_basis"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の非退化な二次形式（", ref("def_nondegenerate_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式とする。このとき、",
        math(String.raw`V`), " の基底 ", math(String.raw`e:\{1,\dots,n\}\to V`), "（", math(String.raw`e_i:=e(i)`), "）であって、次の二つを満たすものが存在する。",
      ]),
      list([
        [math(String.raw`i,j\in\{1,\dots,n\}`), "、", math(String.raw`i\neq j`), " ならば ", math(String.raw`B_q(e_i,e_j)=0_{\mathbb{C}}`)],
        [math(String.raw`i\in\{1,\dots,n\}`), " ならば ", math(String.raw`q(e_i)=1_{\mathbb{C}}`)],
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form"), " により、", math(String.raw`V`), " の基底 ", math(String.raw`\tilde e:\{1,\dots,n\}\to V`),
        " で、", math(String.raw`i\neq j`), " なら ", math(String.raw`B_q(\tilde e_i,\tilde e_j)=0_{\mathbb{C}}`), "、すべての ", math(String.raw`i`), " について ",
        math(String.raw`q(\tilde e_i)\neq 0_{\mathbb{C}}`), " を満たすものがある。各 ", math(String.raw`k\in\{1,\dots,n\}`), " について、",
        math(String.raw`s_k\cdot_{\mathbb{C}}s_k=q(\tilde e_k)`), " を満たす ", math(String.raw`s_k\in\mathbb{C}`), " を一つ選ぶ（",
        ref("claim_existence_of_square_root_in_complex_numbers"), "）。", math(String.raw`s_k=0_{\mathbb{C}}`), " なら ", math(String.raw`q(\tilde e_k)=0_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}`), " であり、", math(String.raw`\mathbb{C}`),
        " の中で ", math(String.raw`0_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}`), " なので ", math(String.raw`q(\tilde e_k)=0_{\mathbb{C}}`), " となって矛盾するので、", math(String.raw`s_k\neq 0_{\mathbb{C}}`), " である。", math(String.raw`t_k:=s_k^{-1}`), "（", math(String.raw`\mathbb{C}`),
        " の中の乗法の逆元）と置くと、", math(String.raw`t_k\cdot_{\mathbb{C}}s_k=1_{\mathbb{C}}\neq 0_{\mathbb{C}}`), " なので ", math(String.raw`t_k\neq 0_{\mathbb{C}}`),
        " である。", math(String.raw`e_k:=t_k\cdot_V\tilde e_k`), " と置くと、", math(String.raw`e`), " は ", math(String.raw`V`), " の基底である（",
        ref("claim_nonzero_scalar_multiples_of_basis_members_form_basis"), "）。",
      ]),
      paragraph(["（値が 1 であること）", math(String.raw`i\in\{1,\dots,n\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
q(e_i)
&=q(t_i\cdot_V\tilde e_i)
&&\left(\because\ e_i\ \text{の定義}\right)\\
&=t_i\cdot_{\mathbb{C}}\bigl(t_i\cdot_{\mathbb{C}}q(\tilde e_i)\bigr)
&&\left(\because\ \blkref{def_quadratic_form}\ \text{の一つ目の条件}\right)\\
&=t_i\cdot_{\mathbb{C}}\bigl(t_i\cdot_{\mathbb{C}}(s_i\cdot_{\mathbb{C}}s_i)\bigr)
&&\left(\because\ s_i\ \text{の取り方}\right)\\
&=(t_i\cdot_{\mathbb{C}}s_i)\cdot_{\mathbb{C}}(t_i\cdot_{\mathbb{C}}s_i)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則と交換法則}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ t_i\ \text{は}\ s_i\ \text{の乗法の逆元}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph(["（直交すること）", math(String.raw`i,j\in\{1,\dots,n\}`), "、", math(String.raw`i\neq j`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
B_q(e_i,e_j)
&=B_q(t_i\cdot_V\tilde e_i,\ t_j\cdot_V\tilde e_j)
&&\left(\because\ e_i,\ e_j\ \text{の定義}\right)\\
&=t_i\cdot_{\mathbb{C}}B_q(\tilde e_i,\ t_j\cdot_V\tilde e_j)
&&\left(\because\ B_q(\bullet,t_j\cdot_V\tilde e_j)\ \text{は線型形式。}\blkref{def_quadratic_form}\text{、}\blkref{def_linear_form}\right)\\
&=t_i\cdot_{\mathbb{C}}\bigl(t_j\cdot_{\mathbb{C}}B_q(\tilde e_i,\tilde e_j)\bigr)
&&\left(\because\ B_q(\tilde e_i,\bullet)\ \text{は線型形式。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\text{、}\blkref{def_linear_form}\right)\\
&=t_i\cdot_{\mathbb{C}}(t_j\cdot_{\mathbb{C}}0_{\mathbb{C}})
&&\left(\because\ \tilde e\ \text{の取り方と}\ i\neq j\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\ \text{（二か所に適用）}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_quadratic_form_of_linear_combination_of_orthogonal_family",
    kind: "claim",
    title: { text: "互いに直交する族の線型結合での二次形式の値は、係数の平方と値の積の和である" },
    labels: ["claim_quadratic_form_of_linear_combination_of_orthogonal_family"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の二次形式（", ref("def_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`e:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の元の番号付けた族（", ref("def_linear_independence"), "）とし、",
        math(String.raw`e_k:=e(k)`), " と書く。", math(String.raw`i,j\in\{1,\dots,n\}`), "、", math(String.raw`i\neq j`), " ならば ",
        math(String.raw`B_q(e_i,e_j)=0_{\mathbb{C}}`), " であるとする。", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ",
        math(String.raw`\nu_k\in\mathbb{C}`), " が一つずつ与えられているとする。このとき、線型結合（", ref("def_linear_combination"), "）と ",
        math(String.raw`\mathbb{C}`), " の中の番号順の和（", ref("def_ordered_sum_in_complex_numbers"), "）について次が成り立つ。",
      ]),
      displayMath(String.raw`q\left(\sum_{k=1}^{n}\nu_k\cdot_V e_k\right)=\sum_{\mathbb{C},\,k=1}^{n}\nu_k\cdot_{\mathbb{C}}\bigl(\nu_k\cdot_{\mathbb{C}}q(e_k)\bigr)`),
    ],
    proof: [
      paragraph([
        math(String.raw`m\in\{0,1,\dots,n\}`), " について、", ref("def_linear_combination"), " が帰納的に定める ", math(String.raw`V`), " の元を ", math(String.raw`G_m`),
        "、", math(String.raw`\alpha_k:=\nu_k\cdot_{\mathbb{C}}(\nu_k\cdot_{\mathbb{C}}q(e_k))`), " について ", ref("def_ordered_sum_in_complex_numbers"),
        " が帰納的に定める ", math(String.raw`\mathbb{C}`), " の元を ", math(String.raw`S_m`), " とする。主張は ", math(String.raw`q(G_n)=S_n`), " である。",
        "準備として、次の二つを置く。",
      ]),
      paragraph(["一つ目は ", math(String.raw`q(0_V)=0_{\mathbb{C}}`), " である。"]),
      displayMath(String.raw`\begin{aligned}
q(0_V)
&=q(0_{\mathbb{C}}\cdot_V 0_V)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}q(0_V)\bigr)
&&\left(\because\ \blkref{def_quadratic_form}\ \text{の一つ目の条件}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}z=0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "二つ目は、", math(String.raw`m\in\{1,\dots,n\}`), " と ", math(String.raw`j\in\{0,1,\dots,m-1\}`), " について ", math(String.raw`B_q(G_j,e_m)=0_{\mathbb{C}}`),
        " であることである。", math(String.raw`m`), " を固定し、", math(String.raw`j`), " についての帰納法で示す。", math(String.raw`B_q(\bullet,e_m)`), " は ",
        math(String.raw`V`), " 上の線型形式である（", ref("def_quadratic_form"), "）。", math(String.raw`j=0`), " のときは ",
        math(String.raw`G_0=0_V`), " であり（", ref("def_linear_combination"), "）、", math(String.raw`B_q(0_V,e_m)=0_{\mathbb{C}}`), " なので（", ref("claim_linear_form_sends_zero_vector_to_zero"),
        "）、", math(String.raw`B_q(G_0,e_m)=0_{\mathbb{C}}`), " である。", math(String.raw`1\le j\le m-1`), " で ", math(String.raw`B_q(G_{j-1},e_m)=0_{\mathbb{C}}`), " とすると、", math(String.raw`j\neq m`), " なので次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
B_q(G_j,e_m)
&=B_q\bigl(G_{j-1}+_V\nu_j\cdot_V e_j,\ e_m\bigr)
&&\left(\because\ \blkref{def_linear_combination}\right)\\
&=B_q(G_{j-1},e_m)+_{\mathbb{C}}\nu_j\cdot_{\mathbb{C}}B_q(e_j,e_m)
&&\left(\because\ B_q(\bullet,e_m)\ \text{は加法とスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}\nu_j\cdot_{\mathbb{C}}B_q(e_j,e_m)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}\nu_j\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ j\neq m\ \text{なので主張の仮定}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\ \text{と加法の単位元}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`q(G_m)=S_m`), " を ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のときは、", math(String.raw`G_0=0_V`), "、",
        math(String.raw`S_0=0_{\mathbb{C}}`), " と一つ目の準備の等式から成り立つ。", math(String.raw`1\le m\le n`), " で ", math(String.raw`q(G_{m-1})=S_{m-1}`),
        " とすると次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
q(G_m)
&=q\bigl(G_{m-1}+_V\nu_m\cdot_V e_m\bigr)
&&\left(\because\ \blkref{def_linear_combination}\right)\\
&=\Bigl(q(G_{m-1})+_{\mathbb{C}}\nu_m\cdot_{\mathbb{C}}\bigl(\nu_m\cdot_{\mathbb{C}}q(e_m)\bigr)\Bigr)+_{\mathbb{C}}\nu_m\cdot_{\mathbb{C}}B_q(G_{m-1},e_m)
&&\left(\because\ \blkref{claim_quadratic_form_at_sum_with_scalar_multiple}\right)\\
&=\Bigl(S_{m-1}+_{\mathbb{C}}\nu_m\cdot_{\mathbb{C}}\bigl(\nu_m\cdot_{\mathbb{C}}q(e_m)\bigr)\Bigr)+_{\mathbb{C}}\nu_m\cdot_{\mathbb{C}}B_q(G_{m-1},e_m)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\bigl(S_{m-1}+_{\mathbb{C}}\alpha_m\bigr)+_{\mathbb{C}}\nu_m\cdot_{\mathbb{C}}B_q(G_{m-1},e_m)
&&\left(\because\ \alpha_m\ \text{の定義}\right)\\
&=\bigl(S_{m-1}+_{\mathbb{C}}\alpha_m\bigr)+_{\mathbb{C}}\nu_m\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{二つ目の準備の等式で}\ j:=m-1\right)\\
&=S_{m-1}+_{\mathbb{C}}\alpha_m
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\ \text{と加法の単位元}\right)\\
&=S_m
&&\left(\because\ \blkref{def_ordered_sum_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m=n`), " とすれば、", math(String.raw`G_n=\sum_{k=1}^{n}\nu_k\cdot_V e_k`), "、", math(String.raw`S_n=\sum_{\mathbb{C},\,k=1}^{n}\alpha_k`),
        " なので主張が成り立つ。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_rearranging_sum_of_two_sums_in_vector_space",
    kind: "claim",
    title: { text: "二つの和の和は、項を入れ替えた二つの和の和に等しい" },
    labels: ["claim_rearranging_sum_of_two_sums_in_vector_space"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）とする。すべての ", math(String.raw`x_1,x_2,y_1,y_2\in V`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`(x_1+_V x_2)+_V(y_1+_V y_2)=(x_1+_V y_1)+_V(x_2+_V y_2)`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(x_1+_V x_2)+_V(y_1+_V y_2)
&=x_1+_V\bigl(x_2+_V(y_1+_V y_2)\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=x_1+_V\bigl((x_2+_V y_1)+_V y_2\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=x_1+_V\bigl((y_1+_V x_2)+_V y_2\bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=x_1+_V\bigl(y_1+_V(x_2+_V y_2)\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(x_1+_V y_1)+_V(x_2+_V y_2)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_map_by_coordinates_and_family",
    kind: "definition",
    title: { text: "基底の座標を係数にした、族の線型結合の写像" },
    labels: ["def_map_by_coordinates_and_family"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " と ", math(String.raw`(U,+_U,\cdot_U,0_U)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の基底（", ref("def_basis"), "）、",
        math(String.raw`u:\{1,\dots,n\}\to U`), " を ", math(String.raw`U`), " の元の番号付けた族（", ref("def_linear_independence"), "）とし、",
        math(String.raw`b_k:=b(k)`), "、", math(String.raw`u_k:=u(k)`), " と書く。", math(String.raw`k\in\{1,\dots,n\}`), " について、", math(String.raw`\beta^{b}_k:V\to\mathbb{C}`),
        " を ", math(String.raw`b`), " についての第 ", math(String.raw`k`), " 座標の写像（", ref("claim_coordinate_map_is_linear_form"), "）とする。写像 ",
        math(String.raw`L_{b,u}:V\to U`), " を次で定める。",
      ]),
      displayMath(String.raw`L_{b,u}(x):=\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_U u_k\qquad(x\in V)`),
      paragraph([
        "右辺は ", math(String.raw`U`), " の中の線型結合（", ref("def_linear_combination"), "）であり、", math(String.raw`\beta^{b}_k(x)\in\mathbb{C}`), " なので ",
        math(String.raw`U`), " の元を一つ定める。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_map_by_coordinates_and_family_is_linear_map",
    kind: "claim",
    title: { text: "基底の座標を係数にした、族の線型結合の写像は線型写像である" },
    labels: ["claim_map_by_coordinates_and_family_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`U`), "、", math(String.raw`b`), "、", math(String.raw`u`), "、", math(String.raw`L_{b,u}`), " を ",
        ref("def_map_by_coordinates_and_family"), " のものとする。このとき ", math(String.raw`L_{b,u}`), " は ", math(String.raw`V`), " から ", math(String.raw`U`),
        " への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y\in V`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。各 ", math(String.raw`\beta^{b}_k`), " は ", math(String.raw`V`),
        " 上の線型形式なので（", ref("claim_coordinate_map_is_linear_form"), "）、各 ", math(String.raw`k`), " について ",
        math(String.raw`\beta^{b}_k(x+_V y)=\beta^{b}_k(x)+_{\mathbb{C}}\beta^{b}_k(y)`), "、", math(String.raw`\beta^{b}_k(\lambda\cdot_V x)=\lambda\cdot_{\mathbb{C}}\beta^{b}_k(x)`),
        " である（", ref("def_linear_form"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_{b,u}(x+_V y)
&=\sum_{k=1}^{n}\beta^{b}_k(x+_V y)\cdot_U u_k
&&\left(\because\ \blkref{def_map_by_coordinates_and_family}\right)\\
&=\sum_{k=1}^{n}\bigl(\beta^{b}_k(x)+_{\mathbb{C}}\beta^{b}_k(y)\bigr)\cdot_U u_k
&&\left(\because\ \beta^{b}_k\ \text{は加法を保つ（各項に適用）。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\left(\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_U u_k\right)+_U\left(\sum_{k=1}^{n}\beta^{b}_k(y)\cdot_U u_k\right)
&&\left(\because\ \blkref{claim_sum_of_linear_combinations_of_same_family}\right)\\
&=L_{b,u}(x)+_U L_{b,u}(y)
&&\left(\because\ \blkref{def_map_by_coordinates_and_family}\ \text{を二か所に適用}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
L_{b,u}(\lambda\cdot_V x)
&=\sum_{k=1}^{n}\beta^{b}_k(\lambda\cdot_V x)\cdot_U u_k
&&\left(\because\ \blkref{def_map_by_coordinates_and_family}\right)\\
&=\sum_{k=1}^{n}\bigl(\lambda\cdot_{\mathbb{C}}\beta^{b}_k(x)\bigr)\cdot_U u_k
&&\left(\because\ \beta^{b}_k\ \text{はスカラー倍を保つ（各項に適用）。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\lambda\cdot_U\left(\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_U u_k\right)
&&\left(\because\ \blkref{claim_scalar_multiple_of_linear_combination}\right)\\
&=\lambda\cdot_U L_{b,u}(x)
&&\left(\because\ \blkref{def_map_by_coordinates_and_family}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_map_by_coordinates_and_family_sends_basis_member_to_family_member",
    kind: "claim",
    title: { text: "基底の座標を係数にした、族の線型結合の写像は、基底の第 j 元を族の第 j 元へ移す" },
    labels: ["claim_map_by_coordinates_and_family_sends_basis_member_to_family_member"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`U`), "、", math(String.raw`n`), "、", math(String.raw`b`), "、", math(String.raw`u`), "、", math(String.raw`L_{b,u}`), " を ",
        ref("def_map_by_coordinates_and_family"), " のものとする。このとき、すべての ", math(String.raw`j\in\{1,\dots,n\}`), " について ",
        math(String.raw`L_{b,u}(b_j)=u_j`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\delta_{k,j}\in\mathbb{C}`), " を ", math(String.raw`\{1,\dots,n\}`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"),
        "）とする。座標の写像の族 ", math(String.raw`\beta^{b}`), " は ", math(String.raw`b`), " の双対基底なので（", ref("claim_coordinate_maps_form_dual_basis"),
        "）、各 ", math(String.raw`k`), " について ", math(String.raw`\beta^{b}_k(b_j)=\delta_{k,j}`), " である（", ref("def_dual_basis"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_{b,u}(b_j)
&=\sum_{k=1}^{n}\beta^{b}_k(b_j)\cdot_U u_k
&&\left(\because\ \blkref{def_map_by_coordinates_and_family}\right)\\
&=\sum_{k=1}^{n}\delta_{k,j}\cdot_U u_k
&&\left(\because\ \beta^{b}_k(b_j)=\delta_{k,j}\ \text{を各項に適用。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=u_j
&&\left(\because\ \blkref{claim_family_member_is_kronecker_delta_linear_combination}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_linear_map_fixing_basis_members_is_identity",
    kind: "claim",
    title: { text: "基底のどの元も動かさない線型写像は、どの元も動かさない" },
    labels: ["claim_linear_map_fixing_basis_members_is_identity"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 1}`), "、",
        math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`), " の基底（", ref("def_basis"), "）とし、", math(String.raw`b_k:=b(k)`), " と書く。",
        math(String.raw`F:V\to V`), " を線型写像（", ref("def_linear_map"), "）とし、すべての ", math(String.raw`k\in\{1,\dots,n\}`), " について ",
        math(String.raw`F(b_k)=b_k`), " であるとする。このとき、すべての ", math(String.raw`x\in V`), " について ", math(String.raw`F(x)=x`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\beta^{b}_k`), " を ", math(String.raw`b`), " についての第 ", math(String.raw`k`), " 座標の写像（", ref("claim_coordinate_map_is_linear_form"), "）とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
F(x)
&=F\left(\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_V b_k\right)
&&\left(\because\ \text{座標の写像の性質。}\blkref{claim_coordinate_map_is_linear_form}\right)\\
&=\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_V F(b_k)
&&\left(\because\ \blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_V b_k
&&\left(\because\ F(b_k)=b_k\ \text{を各項に適用。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=x
&&\left(\because\ \text{座標の写像の性質。}\blkref{claim_coordinate_map_is_linear_form}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_linear_right_inverse_of_isometry_is_isometry",
    kind: "claim",
    title: { text: "等長写像の右逆写像である線型写像は、等長写像である" },
    labels: ["claim_linear_right_inverse_of_isometry_is_isometry"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " と ", math(String.raw`(V',+_{V'},\cdot_{V'},0_{V'})`), " を ℂ-線型空間（", ref("def_complex_vector_space"),
        "）、", math(String.raw`q`), " を ", math(String.raw`V`), " 上の二次形式、", math(String.raw`q'`), " を ", math(String.raw`V'`), " 上の二次形式（",
        ref("def_quadratic_form"), "）、", math(String.raw`\theta:V\to V'`), " を ", math(String.raw`(V,q)`), " から ", math(String.raw`(V',q')`), " への等長写像（",
        ref("def_isometry_of_quadratic_spaces"), "）、", math(String.raw`\theta':V'\to V`), " を線型写像（", ref("def_linear_map"), "）とし、すべての ",
        math(String.raw`y\in V'`), " について ", math(String.raw`\theta(\theta'(y))=y`), " であるとする。このとき ", math(String.raw`\theta'`), " は ",
        math(String.raw`(V',q')`), " から ", math(String.raw`(V,q)`), " への等長写像である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`y\in V'`), " を任意に取る。"]),
      displayMath(String.raw`\begin{aligned}
q\bigl(\theta'(y)\bigr)
&=q'\Bigl(\theta\bigl(\theta'(y)\bigr)\Bigr)
&&\left(\because\ \theta\ \text{は等長写像。}\blkref{def_isometry_of_quadratic_spaces}\right)\\
&=q'(y)
&&\left(\because\ \theta(\theta'(y))=y\right).
\end{aligned}`),
      paragraph([
        math(String.raw`\theta'`), " は線型写像なので、", math(String.raw`(V',q')`), " から ", math(String.raw`(V,q)`), " への等長写像である（",
        ref("def_isometry_of_quadratic_spaces"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry",
    kind: "claim",
    title: { text: "等長写像が誘導するクリフォード代数の準同型の存在と一意性" },
    labels: ["claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " と ", math(String.raw`(V',+_{V'},\cdot_{V'},0_{V'})`), " を ℂ-線型空間（", ref("def_complex_vector_space"),
        "）、", math(String.raw`n,n'\in\mathbb{Z}_{\ge 0}`), "、", math(String.raw`b:\{1,\dots,n\}\to V`), " と ", math(String.raw`b':\{1,\dots,n'\}\to V'`),
        " を基底（", ref("def_basis"), "）、", math(String.raw`q`), " を ", math(String.raw`V`), " 上の二次形式、", math(String.raw`q'`), " を ", math(String.raw`V'`),
        " 上の二次形式（", ref("def_quadratic_form"), "）とする。", math(String.raw`\mathrm{Cl}(V,q)`), " を基底 ", math(String.raw`b`), " で、",
        math(String.raw`\mathrm{Cl}(V',q')`), " を基底 ", math(String.raw`b'`), " で構成したクリフォード代数（", ref("def_clifford_ideal"), "、",
        ref("def_clifford_algebra"), "）、", math(String.raw`\gamma:V\to\mathrm{Cl}(V,q)`), " と ", math(String.raw`\gamma':V'\to\mathrm{Cl}(V',q')`), " を ",
        ref("def_clifford_generator_map"), " の写像とする。", math(String.raw`\theta:V\to V'`), " を ", math(String.raw`(V,q)`), " から ", math(String.raw`(V',q')`),
        " への等長写像（", ref("def_isometry_of_quadratic_spaces"), "）とする。このとき、", math(String.raw`\mathrm{Cl}(V,q)`), " から ", math(String.raw`\mathrm{Cl}(V',q')`),
        " への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）", math(String.raw`\Theta`), " で、", math(String.raw`V`), " から ",
        math(String.raw`\mathrm{Cl}(V',q')`), " への写像として ", math(String.raw`\Theta\circ\gamma=\gamma'\circ\theta`), " を満たすものが、ただ一つ存在する。",
      ]),
    ],
    proof: [
      paragraph([
        "クリフォード代数の普遍性（", ref("claim_universal_property_of_clifford_algebra"), "）の代数に ", math(String.raw`A:=\mathrm{Cl}(V',q')`), "、線型写像に ",
        math(String.raw`g:=\gamma'\circ\theta`), " を当てる。", math(String.raw`A`), " は ℂ-代数である（", ref("def_clifford_algebra"), "）。", math(String.raw`\theta`),
        " は線型写像であり（", ref("def_isometry_of_quadratic_spaces"), "）、", math(String.raw`\gamma'`), " は ", math(String.raw`V'`), " から ",
        math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像なので（", ref("claim_clifford_generator_map_is_linear_map"), "）、", math(String.raw`g`), " は ",
        math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像である（", ref("claim_composition_of_linear_maps_is_linear_map"), "）。",
        math(String.raw`v\in V`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
g(v)\cdot_A g(v)
&=\gamma'\bigl(\theta(v)\bigr)\cdot_A\gamma'\bigl(\theta(v)\bigr)
&&\left(\because\ g\ \text{の定義}\right)\\
&=q'\bigl(\theta(v)\bigr)\ast_A 1_A
&&\left(\because\ \blkref{claim_square_of_clifford_generator}\right)\\
&=q(v)\ast_A 1_A
&&\left(\because\ \theta\ \text{は等長写像。}\blkref{def_isometry_of_quadratic_spaces}\right).
\end{aligned}`),
      paragraph([
        "普遍性の仮定がすべて満たされたので、", math(String.raw`\Theta\circ\gamma=g=\gamma'\circ\theta`), " を満たす ℂ-代数の準同型 ", math(String.raw`\Theta`),
        " がただ一つ存在する。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_of_clifford_algebras_induced_by_isometry",
    kind: "definition",
    title: { text: "等長写像が誘導するクリフォード代数の準同型" },
    labels: ["def_homomorphism_of_clifford_algebras_induced_by_isometry"],
    statement: [
      paragraph([
        ref("claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry"), " の状況で、", math(String.raw`\Theta\circ\gamma=\gamma'\circ\theta`), " を満たすただ一つの ℂ-代数の準同型 ", math(String.raw`\Theta`), " を ",
        math(String.raw`\mathrm{Cl}(\theta):\mathrm{Cl}(V,q)\to\mathrm{Cl}(V',q')`), " と書き、等長写像 ", math(String.raw`\theta`), " が誘導する準同型と呼ぶ。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity",
    kind: "claim",
    title: { text: "逆向きの等長写像が誘導する準同型を続けると、恒等写像になる" },
    labels: ["claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`V'`), "、", math(String.raw`b`), "、", math(String.raw`b'`), "、", math(String.raw`q`), "、", math(String.raw`q'`), "、",
        math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\mathrm{Cl}(V',q')`), "、", math(String.raw`\gamma`), "、", math(String.raw`\gamma'`), " を ",
        ref("claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry"), " のものとする。", math(String.raw`\sigma:V\to V'`), " を ",
        math(String.raw`(V,q)`), " から ", math(String.raw`(V',q')`), " への等長写像、", math(String.raw`\tau:V'\to V`), " を ", math(String.raw`(V',q')`), " から ",
        math(String.raw`(V,q)`), " への等長写像（", ref("def_isometry_of_quadratic_spaces"), "）とし、すべての ", math(String.raw`x\in V`), " について ",
        math(String.raw`\tau(\sigma(x))=x`), " であるとする。", math(String.raw`\mathrm{Cl}(\sigma)`), " と ", math(String.raw`\mathrm{Cl}(\tau)`), " を、",
        math(String.raw`\sigma`), " と ", math(String.raw`\tau`), " が誘導する準同型（", ref("def_homomorphism_of_clifford_algebras_induced_by_isometry"),
        "）とする。このとき、すべての ", math(String.raw`a\in\mathrm{Cl}(V,q)`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\mathrm{Cl}(\tau)\bigl(\mathrm{Cl}(\sigma)(a)\bigr)=a`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と置き、", math(String.raw`\Xi:=\mathrm{Cl}(\tau)\circ\mathrm{Cl}(\sigma):A\to A`), " とする。", math(String.raw`\Xi`),
        " は ℂ-代数の準同型である（", ref("def_homomorphism_of_clifford_algebras_induced_by_isometry"), "、",
        ref("claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism"), "）。", math(String.raw`\mathrm{id}_A`), " も ℂ-代数の準同型である（",
        ref("claim_identity_map_is_algebra_homomorphism"), "）。", math(String.raw`v\in V`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Xi\bigl(\gamma(v)\bigr)
&=\mathrm{Cl}(\tau)\Bigl(\mathrm{Cl}(\sigma)\bigl(\gamma(v)\bigr)\Bigr)
&&\left(\because\ \Xi\ \text{の定義}\right)\\
&=\mathrm{Cl}(\tau)\Bigl(\gamma'\bigl(\sigma(v)\bigr)\Bigr)
&&\left(\because\ \mathrm{Cl}(\sigma)\circ\gamma=\gamma'\circ\sigma\text{。}\blkref{def_homomorphism_of_clifford_algebras_induced_by_isometry}\right)\\
&=\gamma\Bigl(\tau\bigl(\sigma(v)\bigr)\Bigr)
&&\left(\because\ \mathrm{Cl}(\tau)\circ\gamma'=\gamma\circ\tau\text{。}\blkref{def_homomorphism_of_clifford_algebras_induced_by_isometry}\right)\\
&=\gamma(v)
&&\left(\because\ \tau(\sigma(v))=v\right)\\
&=\mathrm{id}_A\bigl(\gamma(v)\bigr)
&&\left(\because\ \mathrm{id}_A\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "クリフォード代数の普遍性（", ref("claim_universal_property_of_clifford_algebra"), "）の代数に ", math(String.raw`A`), "、線型写像に ", math(String.raw`\gamma`),
        " を当てる。", math(String.raw`\gamma`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像であり（",
        ref("claim_clifford_generator_map_is_linear_map"), "）、すべての ", math(String.raw`v\in V`), " について ", math(String.raw`\gamma(v)\cdot_A\gamma(v)=q(v)\ast_A 1_A`),
        " である（", ref("claim_square_of_clifford_generator"), "）。普遍性により、", math(String.raw`\Upsilon\circ\gamma=\gamma`), " を満たす ℂ-代数の準同型 ",
        math(String.raw`\Upsilon:A\to A`), " はただ一つである。上の等式から ", math(String.raw`\Xi`), " と ", math(String.raw`\mathrm{id}_A`), " はどちらもこれを満たすので、",
        math(String.raw`\Xi=\mathrm{id}_A`), " である。", math(String.raw`\Xi`), " の定義により、これは主張の等式である。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_setting_of_general_even_dimensional_corollary",
    kind: "definition",
    title: { text: "一般の偶数次元の系で固定する記号" },
    labels: ["def_setting_of_general_even_dimensional_corollary"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`W`), "、", math(String.raw`w`), "、", math(String.raw`w_k`), "、", math(String.raw`f`), "、", math(String.raw`f_k`), "、",
        math(String.raw`V=W\oplus W^{*}`), "、", math(String.raw`q=q_W`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`), "、",
        math(String.raw`\mathrm{in}_1`), "、", math(String.raw`\mathrm{in}_2`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、",
        math(String.raw`B_q`), " を ", math(String.raw`q`), " に付随する双線型形式とする。同じ定義が基底 ", math(String.raw`c`), " と呼ぶ ", math(String.raw`V`),
        " の基底を、生成作用素の行列との区別のため、ここでは ", math(String.raw`d:\{1,\dots,2M\}\to V`), " と書く。", math(String.raw`\{1,\dots,2M\}`),
        " の各元は、", math(String.raw`m\in\{1,\dots,M\}`), " であるか、ただ一つの ", math(String.raw`m\in\{1,\dots,M\}`), " によって ", math(String.raw`M+m`),
        " と書けるかのどちらか一方であり、", math(String.raw`d_m=\mathrm{in}_1(w_m)`), "、", math(String.raw`d_{M+m}=\mathrm{in}_2(f_m)`), " である（",
        ref("claim_basis_of_direct_sum_of_two_vector_spaces"), "）。",
      ]),
      paragraph([
        math(String.raw`(Y,+_Y,\cdot_Y,0_Y)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`b^{Y}:\{1,\dots,2M\}\to Y`), " を ",
        math(String.raw`Y`), " の基底（", ref("def_basis"), "）、", math(String.raw`Q`), " を ", math(String.raw`Y`), " 上の非退化な二次形式（",
        ref("def_nondegenerate_quadratic_form"), "）、", math(String.raw`B_Q`), " をそれに付随する双線型形式とする。", math(String.raw`\mathrm{Cl}(Y,Q)`), " を基底 ",
        math(String.raw`b^{Y}`), " で構成した ", math(String.raw`(Y,Q)`), " のクリフォード代数（", ref("def_clifford_ideal"), "、", ref("def_clifford_algebra"), "）、",
        math(String.raw`\gamma_Y:Y\to\mathrm{Cl}(Y,Q)`), " を ", ref("def_clifford_generator_map"), " の写像とする。",
      ]),
      paragraph([
        math(String.raw`e:\{1,\dots,2M\}\to Y`), "（", math(String.raw`e_k:=e(k)`), "）を、", math(String.raw`k\neq l`), " なら ", math(String.raw`B_Q(e_k,e_l)=0_{\mathbb{C}}`),
        "、すべての ", math(String.raw`k`), " について ", math(String.raw`Q(e_k)=1_{\mathbb{C}}`), " を満たす ", math(String.raw`Y`), " の基底とし、一つ固定する（存在は ",
        ref("claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form"), "）。",
      ]),
      paragraph([
        math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`z`), " の加法の逆元を ", math(String.raw`-_{\mathbb{C}}z`), " と書く。", ref("claim_existence_of_square_root_in_complex_numbers"),
        " で ", math(String.raw`z:=-_{\mathbb{C}}1_{\mathbb{C}}`), " としたときの ", math(String.raw`s`), " を一つ選んで固定し、", math(String.raw`\mathrm{i}\in\mathbb{C}`), " と書く。すなわち ",
        math(String.raw`\mathrm{i}\cdot_{\mathbb{C}}\mathrm{i}=-_{\mathbb{C}}1_{\mathbb{C}}`), " である。", math(String.raw`\mathbb{C}`),
        " の中で ", math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}\neq 0_{\mathbb{C}}`), " なので、その乗法の逆元を ",
        math(String.raw`h:=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\in\mathbb{C}`), " と書く。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_negative_imaginary_unit_times_imaginary_unit_is_one",
    kind: "claim",
    title: { text: "虚数単位の加法の逆元と虚数単位の積は 1 である" },
    labels: ["claim_negative_imaginary_unit_times_imaginary_unit_is_one"],
    statement: [
      paragraph([
        math(String.raw`\mathrm{i}`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " のものとする。", math(String.raw`\mathbb{C}`), " の中で ",
        math(String.raw`(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\mathrm{i}=1_{\mathbb{C}}`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\mathrm{i}
&=-_{\mathbb{C}}(\mathrm{i}\cdot_{\mathbb{C}}\mathrm{i})
&&\left(\because\ \mathbb{C}\ \text{の中で}\ (-_{\mathbb{C}}z)\cdot_{\mathbb{C}}z'=-_{\mathbb{C}}(z\cdot_{\mathbb{C}}z')\right)\\
&=-_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})
&&\left(\because\ \mathrm{i}\cdot_{\mathbb{C}}\mathrm{i}=-_{\mathbb{C}}1_{\mathbb{C}}\text{。}\blkref{def_setting_of_general_even_dimensional_corollary}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ -_{\mathbb{C}}(-_{\mathbb{C}}z)=z\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_family_in_split_space_for_isometry",
    kind: "definition",
    title: { text: "直交基底の行き先にする、分裂した二次空間の元の族" },
    labels: ["def_family_in_split_space_for_isometry"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`w_m`), "、", math(String.raw`f_m`), "、", math(String.raw`V`), "、", math(String.raw`\mathrm{i}`), " を ",
        ref("def_setting_of_general_even_dimensional_corollary"), " のものとする。", math(String.raw`V`), " の元の番号付けた族 ", math(String.raw`u:\{1,\dots,2M\}\to V`),
        "（", math(String.raw`u_k:=u(k)`), "）を次で定める（", math(String.raw`m\in\{1,\dots,M\}`), "）。",
      ]),
      displayMath(String.raw`u_m:=(w_m,\ f_m),\qquad u_{M+m}:=\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m,\ \mathrm{i}\cdot_{W^{*}}f_m\bigr)`),
      paragraph([
        "どちらも ", math(String.raw`W`), " の元と ", math(String.raw`W^{*}`), " の元の順序対であり、", math(String.raw`V=W\oplus W^{*}`), " の元である（",
        ref("def_direct_sum_of_two_vector_spaces"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_quadratic_form_on_family_in_split_space_is_one",
    kind: "claim",
    title: { text: "分裂した二次空間の族のどの元でも、二次形式の値は 1 である" },
    labels: ["claim_quadratic_form_on_family_in_split_space_is_one"],
    statement: [
      paragraph([
        math(String.raw`q`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " のもの、", math(String.raw`u`), " を ", ref("def_family_in_split_space_for_isometry"),
        " の族とする。すべての ", math(String.raw`k\in\{1,\dots,2M\}`), " について ", math(String.raw`q(u_k)=1_{\mathbb{C}}`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\delta_{m,m'}\in\mathbb{C}`), " を ", math(String.raw`\{1,\dots,M\}`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"),
        "）とする。", math(String.raw`f`), " は ", math(String.raw`w`), " の双対基底なので ", math(String.raw`f_m(w_{m'})=\delta_{m,m'}`), " である（",
        ref("def_dual_basis"), "）。", math(String.raw`k=m\in\{1,\dots,M\}`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
q(u_m)
&=q_W\bigl((w_m,\ f_m)\bigr)
&&\left(\because\ q=q_W\ \text{と}\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&=f_m(w_m)
&&\left(\because\ \blkref{def_split_quadratic_form}\right)\\
&=\delta_{m,m}
&&\left(\because\ \blkref{def_dual_basis}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \blkref{def_kronecker_delta}\right).
\end{aligned}`),
      paragraph([math(String.raw`k=M+m`), "（", math(String.raw`m\in\{1,\dots,M\}`), "）のとき："]),
      displayMath(String.raw`\begin{aligned}
q(u_{M+m})
&=q_W\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m,\ \mathrm{i}\cdot_{W^{*}}f_m\bigr)\Bigr)
&&\left(\because\ q=q_W\ \text{と}\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&=\bigl(\mathrm{i}\cdot_{W^{*}}f_m\bigr)\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m\bigr)
&&\left(\because\ \blkref{def_split_quadratic_form}\right)\\
&=\mathrm{i}\cdot_{\mathbb{C}}f_m\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m\bigr)
&&\left(\because\ \cdot_{W^{*}}\ \text{は各点ごとのスカラー倍。}\blkref{def_dual_space}\text{、}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}f_m(w_m)\bigr)
&&\left(\because\ f_m\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\delta_{m,m}\bigr)
&&\left(\because\ \blkref{def_dual_basis}\right)\\
&=\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=\mathrm{i}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\mathrm{i}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \blkref{claim_negative_imaginary_unit_times_imaginary_unit_is_one}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_family_in_split_space_is_orthogonal",
    kind: "claim",
    title: { text: "分裂した二次空間の族の異なる二元は直交する" },
    labels: ["claim_family_in_split_space_is_orthogonal"],
    statement: [
      paragraph([
        math(String.raw`B_q`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " のもの、", math(String.raw`u`), " を ", ref("def_family_in_split_space_for_isometry"),
        " の族とする。", math(String.raw`k,l\in\{1,\dots,2M\}`), "、", math(String.raw`k\neq l`), " ならば ", math(String.raw`B_q(u_k,u_l)=0_{\mathbb{C}}`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\delta_{m,m'}\in\mathbb{C}`), " を ", math(String.raw`\{1,\dots,M\}`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"),
        "）とする。", math(String.raw`f_m(w_{m'})=\delta_{m,m'}`), " であり（", ref("def_dual_basis"), "）、", math(String.raw`\delta_{m,m'}`), " の値は ",
        math(String.raw`m=m'`), " かどうかだけで決まるので ", math(String.raw`\delta_{m',m}=\delta_{m,m'}`), " である（", ref("def_kronecker_delta"), "）。",
        math(String.raw`q=q_W`), " なので、", ref("claim_value_of_polarization_of_split_quadratic_form"), " により、", math(String.raw`x,x'\in W`), "、",
        math(String.raw`g,g'\in W^{*}`), " について ", math(String.raw`B_q((x,g),(x',g'))=g(x')+_{\mathbb{C}}g'(x)`), " である。", math(String.raw`k`), " と ",
        math(String.raw`l`), " の形で四つの場合に分ける（", math(String.raw`m,m'\in\{1,\dots,M\}`), "）。",
      ]),
      paragraph(["（", math(String.raw`k=m`), "、", math(String.raw`l=m'`), "、", math(String.raw`m\neq m'`), " の場合）"]),
      displayMath(String.raw`\begin{aligned}
B_q(u_m,u_{m'})
&=B_q\bigl((w_m,\ f_m),\ (w_{m'},\ f_{m'})\bigr)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&=f_m(w_{m'})+_{\mathbb{C}}f_{m'}(w_m)
&&\left(\because\ \blkref{claim_value_of_polarization_of_split_quadratic_form}\right)\\
&=\delta_{m,m'}+_{\mathbb{C}}\delta_{m',m}
&&\left(\because\ \blkref{def_dual_basis}\ \text{を二か所に適用}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ m\neq m'\text{。}\blkref{def_kronecker_delta}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph(["（", math(String.raw`k=m`), "、", math(String.raw`l=M+m'`), " の場合）"]),
      displayMath(String.raw`\begin{aligned}
B_q(u_m,u_{M+m'})
&=B_q\Bigl((w_m,\ f_m),\ \bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_{m'},\ \mathrm{i}\cdot_{W^{*}}f_{m'}\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&=f_m\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_{m'}\bigr)+_{\mathbb{C}}\bigl(\mathrm{i}\cdot_{W^{*}}f_{m'}\bigr)(w_m)
&&\left(\because\ \blkref{claim_value_of_polarization_of_split_quadratic_form}\right)\\
&=(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}f_m(w_{m'})+_{\mathbb{C}}\bigl(\mathrm{i}\cdot_{W^{*}}f_{m'}\bigr)(w_m)
&&\left(\because\ f_m\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}f_m(w_{m'})+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}f_{m'}(w_m)
&&\left(\because\ \cdot_{W^{*}}\ \text{は各点ごとのスカラー倍。}\blkref{def_dual_space}\text{、}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\delta_{m,m'}+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\delta_{m',m}
&&\left(\because\ \blkref{def_dual_basis}\ \text{を二か所に適用}\right)\\
&=(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\delta_{m,m'}+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\delta_{m,m'}
&&\left(\because\ \delta_{m',m}=\delta_{m,m'}\right)\\
&=\bigl((-_{\mathbb{C}}\mathrm{i})+_{\mathbb{C}}\mathrm{i}\bigr)\cdot_{\mathbb{C}}\delta_{m,m'}
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{m,m'}
&&\left(\because\ -_{\mathbb{C}}\mathrm{i}\ \text{は}\ \mathrm{i}\ \text{の加法の逆元}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}z=0_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "（", math(String.raw`k=M+m`), "、", math(String.raw`l=m'`), " の場合）", math(String.raw`B_q`), " は二つの引数の入れ替えで変わらないので（",
        ref("claim_polarization_is_symmetric"), "）、", math(String.raw`B_q(u_{M+m},u_{m'})=B_q(u_{m'},u_{M+m})`), " であり、これは一つ前の場合で ",
        math(String.raw`m`), " と ", math(String.raw`m'`), " を入れ替えたものなので ", math(String.raw`0_{\mathbb{C}}`), " である。",
      ]),
      paragraph(["（", math(String.raw`k=M+m`), "、", math(String.raw`l=M+m'`), "、", math(String.raw`m\neq m'`), " の場合）"]),
      displayMath(String.raw`\begin{aligned}
&B_q(u_{M+m},u_{M+m'})\\
&\quad=B_q\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m,\ \mathrm{i}\cdot_{W^{*}}f_m\bigr),\ \bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_{m'},\ \mathrm{i}\cdot_{W^{*}}f_{m'}\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&\quad=\bigl(\mathrm{i}\cdot_{W^{*}}f_m\bigr)\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_{m'}\bigr)+_{\mathbb{C}}\bigl(\mathrm{i}\cdot_{W^{*}}f_{m'}\bigr)\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m\bigr)
&&\left(\because\ \blkref{claim_value_of_polarization_of_split_quadratic_form}\right)\\
&\quad=\mathrm{i}\cdot_{\mathbb{C}}f_m\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_{m'}\bigr)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}f_{m'}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m\bigr)
&&\left(\because\ \cdot_{W^{*}}\ \text{は各点ごとのスカラー倍（二か所に適用）。}\blkref{def_dual_space}\text{、}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&\quad=\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}f_m(w_{m'})\bigr)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}f_{m'}(w_m)\bigr)
&&\left(\because\ f_m,\ f_{m'}\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&\quad=\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\delta_{m,m'}\bigr)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\delta_{m',m}\bigr)
&&\left(\because\ \blkref{def_dual_basis}\ \text{を二か所に適用}\right)\\
&\quad=\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ m\neq m'\text{。}\blkref{def_kronecker_delta}\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ z\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\ \text{と加法の単位元}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`k\neq l`), " である組 ", math(String.raw`(k,l)`), " はこの四つの場合のどれか一つに入るので、主張が成り立つ。",
      ]),
    ],
  },
  {
    id: "isomorphism_definition_map_to_split_quadratic_space",
    kind: "definition",
    title: { text: "一般の非退化な二次空間から分裂した二次空間への写像" },
    labels: ["def_map_to_split_quadratic_space"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`V`), "、", math(String.raw`Y`), "、", math(String.raw`e`), " を ", ref("def_setting_of_general_even_dimensional_corollary"),
        " のもの、", math(String.raw`u`), " を ", ref("def_family_in_split_space_for_isometry"), " の族とする。写像 ", math(String.raw`\theta:Y\to V`), " を、基底 ",
        math(String.raw`e`), " の座標を係数にした族 ", math(String.raw`u`), " の線型結合の写像 ", math(String.raw`\theta:=L_{e,u}`), "（", ref("def_map_by_coordinates_and_family"),
        "）とする。すなわち、", math(String.raw`\beta^{e}_k`), " を ", math(String.raw`e`), " についての第 ", math(String.raw`k`), " 座標の写像（",
        ref("claim_coordinate_map_is_linear_form"), "）として次である。",
      ]),
      displayMath(String.raw`\theta(x)=\sum_{k=1}^{2M}\beta^{e}_k(x)\cdot_V u_k\qquad(x\in Y)`),
    ],
  },
  {
    id: "isomorphism_claim_map_to_split_quadratic_space_is_isometry",
    kind: "claim",
    title: { text: "一般の非退化な二次空間から分裂した二次空間への写像は等長写像である" },
    labels: ["claim_map_to_split_quadratic_space_is_isometry"],
    statement: [
      paragraph([
        math(String.raw`Y`), "、", math(String.raw`Q`), "、", math(String.raw`V`), "、", math(String.raw`q`), " を ", ref("def_setting_of_general_even_dimensional_corollary"),
        " のもの、", math(String.raw`\theta`), " を ", ref("def_map_to_split_quadratic_space"), " の写像とする。", math(String.raw`\theta`), " は ", math(String.raw`(Y,Q)`),
        " から ", math(String.raw`(V,q)`), " への等長写像（", ref("def_isometry_of_quadratic_spaces"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta`), " は線型写像である（", ref("claim_map_by_coordinates_and_family_is_linear_map"), "）。", math(String.raw`x\in Y`), " を任意に取り、",
        math(String.raw`\nu_k:=\beta^{e}_k(x)\in\mathbb{C}`), " と置く。", math(String.raw`u`), " の異なる二元は ", math(String.raw`B_q`), " について直交し（",
        ref("claim_family_in_split_space_is_orthogonal"), "）、", math(String.raw`e`), " の異なる二元は ", math(String.raw`B_Q`), " について直交する（",
        ref("def_setting_of_general_even_dimensional_corollary"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
q\bigl(\theta(x)\bigr)
&=q\left(\sum_{k=1}^{2M}\nu_k\cdot_V u_k\right)
&&\left(\because\ \blkref{def_map_to_split_quadratic_space}\right)\\
&=\sum_{\mathbb{C},\,k=1}^{2M}\nu_k\cdot_{\mathbb{C}}\bigl(\nu_k\cdot_{\mathbb{C}}q(u_k)\bigr)
&&\left(\because\ \blkref{claim_quadratic_form_of_linear_combination_of_orthogonal_family}\right)\\
&=\sum_{\mathbb{C},\,k=1}^{2M}\nu_k\cdot_{\mathbb{C}}\bigl(\nu_k\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \blkref{claim_quadratic_form_on_family_in_split_space_is_one}\ \text{を各項に適用}\right)\\
&=\sum_{\mathbb{C},\,k=1}^{2M}\nu_k\cdot_{\mathbb{C}}\bigl(\nu_k\cdot_{\mathbb{C}}Q(e_k)\bigr)
&&\left(\because\ Q(e_k)=1_{\mathbb{C}}\ \text{を各項に適用。}\blkref{def_setting_of_general_even_dimensional_corollary}\right)\\
&=Q\left(\sum_{k=1}^{2M}\nu_k\cdot_Y e_k\right)
&&\left(\because\ \blkref{claim_quadratic_form_of_linear_combination_of_orthogonal_family}\right)\\
&=Q(x)
&&\left(\because\ \text{座標の写像の性質。}\blkref{claim_coordinate_map_is_linear_form}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_family_in_general_space_for_inverse_isometry",
    kind: "definition",
    title: { text: "逆写像で行き先にする、一般の非退化な二次空間の元の族" },
    labels: ["def_family_in_general_space_for_inverse_isometry"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`Y`), "、", math(String.raw`e`), "、", math(String.raw`\mathrm{i}`), "、", math(String.raw`h`), " を ",
        ref("def_setting_of_general_even_dimensional_corollary"), " のものとする。", math(String.raw`Y`), " の元の番号付けた族 ", math(String.raw`v:\{1,\dots,2M\}\to Y`),
        "（", math(String.raw`v_k:=v(k)`), "）を次で定める（", math(String.raw`m\in\{1,\dots,M\}`), "）。",
      ]),
      displayMath(String.raw`v_m:=h\cdot_Y\bigl(e_m+_Y\mathrm{i}\cdot_Y e_{M+m}\bigr),\qquad v_{M+m}:=h\cdot_Y\bigl(e_m+_Y(-_{\mathbb{C}}\mathrm{i})\cdot_Y e_{M+m}\bigr)`),
    ],
  },
  {
    id: "isomorphism_definition_map_from_split_quadratic_space",
    kind: "definition",
    title: { text: "分裂した二次空間から一般の非退化な二次空間への写像" },
    labels: ["def_map_from_split_quadratic_space"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`V`), "、", math(String.raw`d`), "、", math(String.raw`Y`), " を ", ref("def_setting_of_general_even_dimensional_corollary"),
        " のもの、", math(String.raw`v`), " を ", ref("def_family_in_general_space_for_inverse_isometry"), " の族とする。", math(String.raw`d`), " は ", math(String.raw`V`),
        " の基底である（", ref("claim_basis_of_direct_sum_of_two_vector_spaces"), "）。写像 ", math(String.raw`\theta':V\to Y`), " を、基底 ", math(String.raw`d`),
        " の座標を係数にした族 ", math(String.raw`v`), " の線型結合の写像 ", math(String.raw`\theta':=L_{d,v}`), "（", ref("def_map_by_coordinates_and_family"),
        "）とする。すなわち、", math(String.raw`\beta^{d}_l`), " を ", math(String.raw`d`), " についての第 ", math(String.raw`l`), " 座標の写像（",
        ref("claim_coordinate_map_is_linear_form"), "）として次である。",
      ]),
      displayMath(String.raw`\theta'(y)=\sum_{l=1}^{2M}\beta^{d}_l(y)\cdot_Y v_l\qquad(y\in V)`),
    ],
  },
  {
    id: "isomorphism_claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis",
    kind: "claim",
    title: { text: "分裂した二次空間からの写像は、族 u の各元を直交基底の同じ番号の元へ移す" },
    labels: ["claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis"],
    statement: [
      paragraph([
        math(String.raw`e`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " の基底、", math(String.raw`u`), " を ", ref("def_family_in_split_space_for_isometry"),
        " の族、", math(String.raw`\theta'`), " を ", ref("def_map_from_split_quadratic_space"), " の写像とする。すべての ", math(String.raw`k\in\{1,\dots,2M\}`), " について ",
        math(String.raw`\theta'(u_k)=e_k`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta'`), " は線型写像であり（", ref("claim_map_by_coordinates_and_family_is_linear_map"), "）、すべての ", math(String.raw`l`), " について ",
        math(String.raw`\theta'(d_l)=v_l`), " である（", ref("claim_map_by_coordinates_and_family_sends_basis_member_to_family_member"), "）。", math(String.raw`m\in\{1,\dots,M\}`),
        " を固定し、", math(String.raw`e':=e_{M+m}`), " と書く。準備として、", math(String.raw`\mathbb{C}`), " の中の次の四つの等式を置く。一つ目は ",
        math(String.raw`(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\mathrm{i}=1_{\mathbb{C}}`), "（", ref("claim_negative_imaginary_unit_times_imaginary_unit_is_one"), "）、二つ目は ",
        math(String.raw`\mathrm{i}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})=1_{\mathbb{C}}`), "（一つ目と ", math(String.raw`\mathbb{C}`), " の乗法の交換法則）である。三つ目と四つ目は次である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}h
&=\bigl((-_{\mathbb{C}}\mathrm{i})+_{\mathbb{C}}\mathrm{i}\bigr)\cdot_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}h
&&\left(\because\ -_{\mathbb{C}}\mathrm{i}\ \text{は}\ \mathrm{i}\ \text{の加法の逆元}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}z=0_{\mathbb{C}}\right),
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h\bigr)\cdot_{\mathbb{C}}\mathrm{i}+_{\mathbb{C}}(\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})
&=\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\mathrm{i}\bigr)\cdot_{\mathbb{C}}h+_{\mathbb{C}}\bigl(\mathrm{i}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)\cdot_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則と交換法則}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}h+_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}h
&&\left(\because\ \text{一つ目と二つ目の準備の等式}\right)\\
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ h=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\text{。}\blkref{def_setting_of_general_even_dimensional_corollary}\right).
\end{aligned}`),
      paragraph(["（", math(String.raw`k=m`), " の場合）"]),
      displayMath(String.raw`\begin{aligned}
u_m
&=(w_m,\ f_m)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&=\mathrm{in}_1(w_m)+_V\mathrm{in}_2(f_m)
&&\left(\because\ \blkref{claim_direct_sum_element_is_sum_of_embedded_components}\right)\\
&=d_m+_V d_{M+m}
&&\left(\because\ \blkref{def_setting_of_general_even_dimensional_corollary}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\theta'(u_m)
&=\theta'(d_m+_V d_{M+m})
&&\left(\because\ \text{上の}\ u_m\ \text{の表示}\right)\\
&=\theta'(d_m)+_Y\theta'(d_{M+m})
&&\left(\because\ \theta'\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=v_m+_Y v_{M+m}
&&\left(\because\ \theta'(d_l)=v_l\ \text{を二か所に適用}\right)\\
&=h\cdot_Y\bigl(e_m+_Y\mathrm{i}\cdot_Y e'\bigr)+_Y h\cdot_Y\bigl(e_m+_Y(-_{\mathbb{C}}\mathrm{i})\cdot_Y e'\bigr)
&&\left(\because\ \blkref{def_family_in_general_space_for_inverse_isometry}\right)\\
&=h\cdot_Y\Bigl(\bigl(e_m+_Y\mathrm{i}\cdot_Y e'\bigr)+_Y\bigl(e_m+_Y(-_{\mathbb{C}}\mathrm{i})\cdot_Y e'\bigr)\Bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=h\cdot_Y\Bigl(\bigl(e_m+_Y e_m\bigr)+_Y\bigl(\mathrm{i}\cdot_Y e'+_Y(-_{\mathbb{C}}\mathrm{i})\cdot_Y e'\bigr)\Bigr)
&&\left(\because\ \blkref{claim_rearranging_sum_of_two_sums_in_vector_space}\right)\\
&=h\cdot_Y\Bigl(\bigl(1_{\mathbb{C}}\cdot_Y e_m+_Y 1_{\mathbb{C}}\cdot_Y e_m\bigr)+_Y\bigl(\mathrm{i}\cdot_Y e'+_Y(-_{\mathbb{C}}\mathrm{i})\cdot_Y e'\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍の単位元（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&=h\cdot_Y\Bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_Y e_m+_Y\bigl(\mathrm{i}+_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)\cdot_Y e'\Bigr)
&&\left(\because\ \text{スカラーの加法についての分配法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&=h\cdot_Y\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_Y e_m+_Y 0_{\mathbb{C}}\cdot_Y e'\bigr)
&&\left(\because\ -_{\mathbb{C}}\mathrm{i}\ \text{は}\ \mathrm{i}\ \text{の加法の逆元}\right)\\
&=h\cdot_Y\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_Y e_m+_Y 0_Y\bigr)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=h\cdot_Y\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_Y e_m\bigr)
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\bigr)\cdot_Y e_m
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\cdot_Y e_m
&&\left(\because\ h=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\right)\\
&=e_m
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "（", math(String.raw`k=M+m`), " の場合）", math(String.raw`\mathrm{in}_1`), " と ", math(String.raw`\mathrm{in}_2`), " は線型写像なので（",
        ref("claim_embedding_into_first_component_is_linear_map"), "、", ref("claim_embedding_into_second_component_is_linear_map"), "）、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
u_{M+m}
&=\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m,\ \mathrm{i}\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&=\mathrm{in}_1\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m\bigr)+_V\mathrm{in}_2\bigl(\mathrm{i}\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \blkref{claim_direct_sum_element_is_sum_of_embedded_components}\right)\\
&=(-_{\mathbb{C}}\mathrm{i})\cdot_V\mathrm{in}_1(w_m)+_V\mathrm{i}\cdot_V\mathrm{in}_2(f_m)
&&\left(\because\ \mathrm{in}_1,\ \mathrm{in}_2\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=(-_{\mathbb{C}}\mathrm{i})\cdot_V d_m+_V\mathrm{i}\cdot_V d_{M+m}
&&\left(\because\ \blkref{def_setting_of_general_even_dimensional_corollary}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
&\theta'(u_{M+m})\\
&\quad=\theta'\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_V d_m+_V\mathrm{i}\cdot_V d_{M+m}\bigr)
&&\left(\because\ \text{上の}\ u_{M+m}\ \text{の表示}\right)\\
&\quad=(-_{\mathbb{C}}\mathrm{i})\cdot_Y\theta'(d_m)+_Y\mathrm{i}\cdot_Y\theta'(d_{M+m})
&&\left(\because\ \theta'\ \text{は加法とスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&\quad=(-_{\mathbb{C}}\mathrm{i})\cdot_Y v_m+_Y\mathrm{i}\cdot_Y v_{M+m}
&&\left(\because\ \theta'(d_l)=v_l\ \text{を二か所に適用}\right)\\
&\quad=(-_{\mathbb{C}}\mathrm{i})\cdot_Y\Bigl(h\cdot_Y\bigl(e_m+_Y\mathrm{i}\cdot_Y e'\bigr)\Bigr)+_Y\mathrm{i}\cdot_Y\Bigl(h\cdot_Y\bigl(e_m+_Y(-_{\mathbb{C}}\mathrm{i})\cdot_Y e'\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_general_space_for_inverse_isometry}\right)\\
&\quad=\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h\bigr)\cdot_Y\bigl(e_m+_Y\mathrm{i}\cdot_Y e'\bigr)+_Y(\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_Y\bigl(e_m+_Y(-_{\mathbb{C}}\mathrm{i})\cdot_Y e'\bigr)
&&\left(\because\ \text{スカラー倍の結合法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h\bigr)\cdot_Y e_m+_Y\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h\bigr)\cdot_Y(\mathrm{i}\cdot_Y e')\Bigr)
+_Y\Bigl((\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_Y e_m+_Y(\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_Y\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_Y e'\bigr)\Bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h\bigr)\cdot_Y e_m+_Y\bigl(((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h)\cdot_{\mathbb{C}}\mathrm{i}\bigr)\cdot_Y e'\Bigr)
+_Y\Bigl((\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_Y e_m+_Y\bigl((\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)\cdot_Y e'\Bigr)
&&\left(\because\ \text{スカラー倍の結合法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h\bigr)\cdot_Y e_m+_Y(\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_Y e_m\Bigr)
+_Y\Bigl(\bigl(((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h)\cdot_{\mathbb{C}}\mathrm{i}\bigr)\cdot_Y e'+_Y\bigl((\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)\cdot_Y e'\Bigr)
&&\left(\because\ \blkref{claim_rearranging_sum_of_two_sums_in_vector_space}\right)\\
&\quad=\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h+_{\mathbb{C}}\mathrm{i}\cdot_{\mathbb{C}}h\bigr)\cdot_Y e_m
+_Y\bigl(((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}h)\cdot_{\mathbb{C}}\mathrm{i}+_{\mathbb{C}}(\mathrm{i}\cdot_{\mathbb{C}}h)\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)\cdot_Y e'
&&\left(\because\ \text{スカラーの加法についての分配法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=0_{\mathbb{C}}\cdot_Y e_m+_Y 1_{\mathbb{C}}\cdot_Y e'
&&\left(\because\ \text{三つ目と四つ目の準備の等式}\right)\\
&\quad=0_Y+_Y 1_{\mathbb{C}}\cdot_Y e'
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&\quad=0_Y+_Y e'
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&\quad=e'+_Y 0_Y
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&\quad=e'
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`e'=e_{M+m}`), " なので、", math(String.raw`\theta'(u_{M+m})=e_{M+m}`), " である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_map_to_split_quadratic_space_sends_family_to_basis",
    kind: "claim",
    title: { text: "分裂した二次空間への写像は、族 v の各元を基底 d の同じ番号の元へ移す" },
    labels: ["claim_map_to_split_quadratic_space_sends_family_to_basis"],
    statement: [
      paragraph([
        math(String.raw`d`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " の基底、", math(String.raw`v`), " を ",
        ref("def_family_in_general_space_for_inverse_isometry"), " の族、", math(String.raw`\theta`), " を ", ref("def_map_to_split_quadratic_space"),
        " の写像とする。すべての ", math(String.raw`l\in\{1,\dots,2M\}`), " について ", math(String.raw`\theta(v_l)=d_l`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta`), " は線型写像であり（", ref("claim_map_by_coordinates_and_family_is_linear_map"), "）、すべての ", math(String.raw`k`), " について ",
        math(String.raw`\theta(e_k)=u_k`), " である（", ref("claim_map_by_coordinates_and_family_sends_basis_member_to_family_member"), "）。", math(String.raw`m\in\{1,\dots,M\}`),
        " を固定し、", math(String.raw`e':=e_{M+m}`), " と書く。", math(String.raw`\mathbb{C}`), " の中で ", math(String.raw`(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\mathrm{i}=1_{\mathbb{C}}`),
        " であり（", ref("claim_negative_imaginary_unit_times_imaginary_unit_is_one"), "）、", math(String.raw`\mathbb{C}`), " の乗法の交換法則により ",
        math(String.raw`\mathrm{i}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})=1_{\mathbb{C}}`), " である。また次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
(-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})
&=-_{\mathbb{C}}\bigl(\mathrm{i}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の中で}\ (-_{\mathbb{C}}z)\cdot_{\mathbb{C}}z'=-_{\mathbb{C}}(z\cdot_{\mathbb{C}}z')\right)\\
&=-_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathrm{i}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})=1_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph(["（", math(String.raw`l=m`), " の場合）"]),
      displayMath(String.raw`\begin{aligned}
&\theta(v_m)\\
&\quad=\theta\Bigl(h\cdot_Y\bigl(e_m+_Y\mathrm{i}\cdot_Y e'\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_general_space_for_inverse_isometry}\right)\\
&\quad=h\cdot_V\bigl(\theta(e_m)+_V\mathrm{i}\cdot_V\theta(e')\bigr)
&&\left(\because\ \theta\ \text{はスカラー倍と加法を保つ。}\blkref{def_linear_map}\right)\\
&\quad=h\cdot_V\bigl(u_m+_V\mathrm{i}\cdot_V u_{M+m}\bigr)
&&\left(\because\ \theta(e_k)=u_k\ \text{を二か所に適用}\right)\\
&\quad=h\cdot_V\Bigl((w_m,\ f_m)+_V\mathrm{i}\cdot_V\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m,\ \mathrm{i}\cdot_{W^{*}}f_m\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&\quad=h\cdot_V\Bigl((w_m,\ f_m)+_V\bigl(\mathrm{i}\cdot_W((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m),\ \mathrm{i}\cdot_{W^{*}}(\mathrm{i}\cdot_{W^{*}}f_m)\bigr)\Bigr)
&&\left(\because\ \text{直和のスカラー倍。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&\quad=h\cdot_V\bigl(w_m+_W\mathrm{i}\cdot_W((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m),\ f_m+_{W^{*}}\mathrm{i}\cdot_{W^{*}}(\mathrm{i}\cdot_{W^{*}}f_m)\bigr)
&&\left(\because\ \text{直和の加法。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&\quad=h\cdot_V\Bigl(w_m+_W\bigl(\mathrm{i}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)\cdot_W w_m,\ f_m+_{W^{*}}(\mathrm{i}\cdot_{\mathbb{C}}\mathrm{i})\cdot_{W^{*}}f_m\Bigr)
&&\left(\because\ \text{スカラー倍の結合法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=h\cdot_V\bigl(w_m+_W 1_{\mathbb{C}}\cdot_W w_m,\ f_m+_{W^{*}}(\mathrm{i}\cdot_{\mathbb{C}}\mathrm{i})\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \mathrm{i}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})=1_{\mathbb{C}}\right)\\
&\quad=h\cdot_V\bigl(w_m+_W 1_{\mathbb{C}}\cdot_W w_m,\ f_m+_{W^{*}}(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \mathrm{i}\cdot_{\mathbb{C}}\mathrm{i}=-_{\mathbb{C}}1_{\mathbb{C}}\right)\\
&\quad=h\cdot_V\bigl(1_{\mathbb{C}}\cdot_W w_m+_W 1_{\mathbb{C}}\cdot_W w_m,\ 1_{\mathbb{C}}\cdot_{W^{*}}f_m+_{W^{*}}(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \text{スカラー倍の単位元（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=h\cdot_V\Bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_W w_m,\ \bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)\cdot_{W^{*}}f_m\Bigr)
&&\left(\because\ \text{スカラーの加法についての分配法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=h\cdot_V\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_W w_m,\ 0_{\mathbb{C}}\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ -_{\mathbb{C}}1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元}\right)\\
&\quad=h\cdot_V\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_W w_m,\ 0_{W^{*}}\bigr)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&\quad=\bigl(h\cdot_W((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_W w_m),\ h\cdot_{W^{*}}0_{W^{*}}\bigr)
&&\left(\because\ \text{直和のスカラー倍。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&\quad=\bigl((h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}))\cdot_W w_m,\ h\cdot_{W^{*}}0_{W^{*}}\bigr)
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&\quad=\bigl((h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}))\cdot_W w_m,\ 0_{W^{*}}\bigr)
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&\quad=\bigl(1_{\mathbb{C}}\cdot_W w_m,\ 0_{W^{*}}\bigr)
&&\left(\because\ h=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\text{。}\blkref{def_setting_of_general_even_dimensional_corollary}\right)\\
&\quad=(w_m,\ 0_{W^{*}})
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&\quad=\mathrm{in}_1(w_m)
&&\left(\because\ \blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&\quad=d_m
&&\left(\because\ \blkref{def_setting_of_general_even_dimensional_corollary}\right).
\end{aligned}`),
      paragraph(["（", math(String.raw`l=M+m`), " の場合）"]),
      displayMath(String.raw`\begin{aligned}
&\theta(v_{M+m})\\
&\quad=\theta\Bigl(h\cdot_Y\bigl(e_m+_Y(-_{\mathbb{C}}\mathrm{i})\cdot_Y e'\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_general_space_for_inverse_isometry}\right)\\
&\quad=h\cdot_V\bigl(\theta(e_m)+_V(-_{\mathbb{C}}\mathrm{i})\cdot_V\theta(e')\bigr)
&&\left(\because\ \theta\ \text{はスカラー倍と加法を保つ。}\blkref{def_linear_map}\right)\\
&\quad=h\cdot_V\bigl(u_m+_V(-_{\mathbb{C}}\mathrm{i})\cdot_V u_{M+m}\bigr)
&&\left(\because\ \theta(e_k)=u_k\ \text{を二か所に適用}\right)\\
&\quad=h\cdot_V\Bigl((w_m,\ f_m)+_V(-_{\mathbb{C}}\mathrm{i})\cdot_V\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m,\ \mathrm{i}\cdot_{W^{*}}f_m\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&\quad=h\cdot_V\Bigl((w_m,\ f_m)+_V\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m),\ (-_{\mathbb{C}}\mathrm{i})\cdot_{W^{*}}(\mathrm{i}\cdot_{W^{*}}f_m)\bigr)\Bigr)
&&\left(\because\ \text{直和のスカラー倍。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&\quad=h\cdot_V\bigl(w_m+_W(-_{\mathbb{C}}\mathrm{i})\cdot_W((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m),\ f_m+_{W^{*}}(-_{\mathbb{C}}\mathrm{i})\cdot_{W^{*}}(\mathrm{i}\cdot_{W^{*}}f_m)\bigr)
&&\left(\because\ \text{直和の加法。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&\quad=h\cdot_V\Bigl(w_m+_W\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)\cdot_W w_m,\ f_m+_{W^{*}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\mathrm{i}\bigr)\cdot_{W^{*}}f_m\Bigr)
&&\left(\because\ \text{スカラー倍の結合法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=h\cdot_V\Bigl(w_m+_W(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_W w_m,\ f_m+_{W^{*}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}\mathrm{i}\bigr)\cdot_{W^{*}}f_m\Bigr)
&&\left(\because\ \text{上の等式}\right)\\
&\quad=h\cdot_V\bigl(w_m+_W(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_W w_m,\ f_m+_{W^{*}}1_{\mathbb{C}}\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \blkref{claim_negative_imaginary_unit_times_imaginary_unit_is_one}\right)\\
&\quad=h\cdot_V\bigl(1_{\mathbb{C}}\cdot_W w_m+_W(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_W w_m,\ 1_{\mathbb{C}}\cdot_{W^{*}}f_m+_{W^{*}}1_{\mathbb{C}}\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \text{スカラー倍の単位元（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=h\cdot_V\Bigl(\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)\cdot_W w_m,\ (1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{W^{*}}f_m\Bigr)
&&\left(\because\ \text{スカラーの加法についての分配法則（二か所に適用）。}\blkref{def_complex_vector_space}\right)\\
&\quad=h\cdot_V\bigl(0_{\mathbb{C}}\cdot_W w_m,\ (1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ -_{\mathbb{C}}1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元}\right)\\
&\quad=h\cdot_V\bigl(0_W,\ (1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&\quad=\bigl(h\cdot_W 0_W,\ h\cdot_{W^{*}}((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{W^{*}}f_m)\bigr)
&&\left(\because\ \text{直和のスカラー倍。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&\quad=\bigl(0_W,\ h\cdot_{W^{*}}((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{W^{*}}f_m)\bigr)
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&\quad=\bigl(0_W,\ (h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}))\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&\quad=\bigl(0_W,\ 1_{\mathbb{C}}\cdot_{W^{*}}f_m\bigr)
&&\left(\because\ h=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\text{。}\blkref{def_setting_of_general_even_dimensional_corollary}\right)\\
&\quad=(0_W,\ f_m)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&\quad=\mathrm{in}_2(f_m)
&&\left(\because\ \blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&\quad=d_{M+m}
&&\left(\because\ \blkref{def_setting_of_general_even_dimensional_corollary}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_map_from_split_after_map_to_split_is_identity",
    kind: "claim",
    title: { text: "分裂した二次空間へ移してから戻すと、一般の非退化な二次空間のどの元も変わらない" },
    labels: ["claim_map_from_split_after_map_to_split_is_identity"],
    statement: [
      paragraph([
        math(String.raw`Y`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " のもの、", math(String.raw`\theta`), " を ", ref("def_map_to_split_quadratic_space"),
        "、", math(String.raw`\theta'`), " を ", ref("def_map_from_split_quadratic_space"), " の写像とする。すべての ", math(String.raw`x\in Y`), " について ",
        math(String.raw`\theta'(\theta(x))=x`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta`), " と ", math(String.raw`\theta'`), " は線型写像なので（", ref("claim_map_by_coordinates_and_family_is_linear_map"), "）、合成 ",
        math(String.raw`\theta'\circ\theta:Y\to Y`), " は線型写像である（", ref("claim_composition_of_linear_maps_is_linear_map"), "）。", math(String.raw`k\in\{1,\dots,2M\}`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\theta'\circ\theta)(e_k)
&=\theta'\bigl(\theta(e_k)\bigr)
&&\left(\because\ \text{合成の定義}\right)\\
&=\theta'(u_k)
&&\left(\because\ \blkref{claim_map_by_coordinates_and_family_sends_basis_member_to_family_member}\right)\\
&=e_k
&&\left(\because\ \blkref{claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`e`), " は ", math(String.raw`Y`), " の基底なので（", ref("def_setting_of_general_even_dimensional_corollary"), "）、",
        ref("claim_linear_map_fixing_basis_members_is_identity"), " により、すべての ", math(String.raw`x\in Y`), " について ", math(String.raw`\theta'(\theta(x))=x`),
        " である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_map_to_split_after_map_from_split_is_identity",
    kind: "claim",
    title: { text: "一般の非退化な二次空間へ移してから戻すと、分裂した二次空間のどの元も変わらない" },
    labels: ["claim_map_to_split_after_map_from_split_is_identity"],
    statement: [
      paragraph([
        math(String.raw`V`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " のもの、", math(String.raw`\theta`), " を ", ref("def_map_to_split_quadratic_space"),
        "、", math(String.raw`\theta'`), " を ", ref("def_map_from_split_quadratic_space"), " の写像とする。すべての ", math(String.raw`y\in V`), " について ",
        math(String.raw`\theta(\theta'(y))=y`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta`), " と ", math(String.raw`\theta'`), " は線型写像なので（", ref("claim_map_by_coordinates_and_family_is_linear_map"), "）、合成 ",
        math(String.raw`\theta\circ\theta':V\to V`), " は線型写像である（", ref("claim_composition_of_linear_maps_is_linear_map"), "）。", math(String.raw`l\in\{1,\dots,2M\}`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\theta\circ\theta')(d_l)
&=\theta\bigl(\theta'(d_l)\bigr)
&&\left(\because\ \text{合成の定義}\right)\\
&=\theta(v_l)
&&\left(\because\ \blkref{claim_map_by_coordinates_and_family_sends_basis_member_to_family_member}\right)\\
&=d_l
&&\left(\because\ \blkref{claim_map_to_split_quadratic_space_sends_family_to_basis}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`d`), " は ", math(String.raw`V`), " の基底なので（", ref("claim_basis_of_direct_sum_of_two_vector_spaces"), "）、",
        ref("claim_linear_map_fixing_basis_members_is_identity"), " により、すべての ", math(String.raw`y\in V`), " について ", math(String.raw`\theta(\theta'(y))=y`),
        " である。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_map_from_split_quadratic_space_is_isometry",
    kind: "claim",
    title: { text: "分裂した二次空間から一般の非退化な二次空間への写像は等長写像である" },
    labels: ["claim_map_from_split_quadratic_space_is_isometry"],
    statement: [
      paragraph([
        math(String.raw`Y`), "、", math(String.raw`Q`), "、", math(String.raw`V`), "、", math(String.raw`q`), " を ", ref("def_setting_of_general_even_dimensional_corollary"),
        " のもの、", math(String.raw`\theta'`), " を ", ref("def_map_from_split_quadratic_space"), " の写像とする。", math(String.raw`\theta'`), " は ", math(String.raw`(V,q)`),
        " から ", math(String.raw`(Y,Q)`), " への等長写像（", ref("def_isometry_of_quadratic_spaces"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta`), " は ", math(String.raw`(Y,Q)`), " から ", math(String.raw`(V,q)`), " への等長写像であり（", ref("claim_map_to_split_quadratic_space_is_isometry"),
        "）、", math(String.raw`\theta'`), " は線型写像であり（", ref("claim_map_by_coordinates_and_family_is_linear_map"), "）、すべての ", math(String.raw`y\in V`),
        " について ", math(String.raw`\theta(\theta'(y))=y`), " である（", ref("claim_map_to_split_after_map_from_split_is_identity"), "）。",
        ref("claim_linear_right_inverse_of_isometry_is_isometry"), " により、", math(String.raw`\theta'`), " は ", math(String.raw`(V,q)`), " から ", math(String.raw`(Y,Q)`),
        " への等長写像である。",
      ]),
    ],
  },
  {
    id: "isomorphism_theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra",
    kind: "theorem",
    title: { text: "系：一般の偶数次元の非退化な二次空間のクリフォード代数と行列環の同型" },
    labels: ["theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`(Y,+_Y,\cdot_Y,0_Y)`), " を ", math(String.raw`2M`), " 個の元からなる基底 ", math(String.raw`b^{Y}`),
        " をもつ ℂ-線型空間、", math(String.raw`Q`), " を ", math(String.raw`Y`), " 上の非退化な二次形式、", math(String.raw`\mathrm{Cl}(Y,Q)`), " を基底 ", math(String.raw`b^{Y}`),
        " で構成したクリフォード代数とし、", math(String.raw`W`), " を ", math(String.raw`M`), " 個の元からなる基底 ", math(String.raw`w`), " をもつ ℂ-線型空間、",
        math(String.raw`V:=W\oplus W^{*}`), "、", math(String.raw`q:=q_W`), " とする。これらと ", math(String.raw`e`), " を ", ref("def_setting_of_general_even_dimensional_corollary"),
        " のものとし、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と書く。",
      ]),
      paragraph([
        math(String.raw`\Phi:\mathrm{Cl}(V,q)\to B`), " と ", math(String.raw`\Psi:B\to\mathrm{Cl}(V,q)`), " を主定理（",
        ref("theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra"), "）の互いに逆な ℂ-代数の準同型（", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"),
        "、", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), "）とする。", math(String.raw`\theta:Y\to V`), " を ", ref("def_map_to_split_quadratic_space"), "、",
        math(String.raw`\theta':V\to Y`), " を ", ref("def_map_from_split_quadratic_space"), " の写像とする。これらは等長写像なので（",
        ref("claim_map_to_split_quadratic_space_is_isometry"), "、", ref("claim_map_from_split_quadratic_space_is_isometry"), "）、誘導する準同型 ",
        math(String.raw`\mathrm{Cl}(\theta):\mathrm{Cl}(Y,Q)\to\mathrm{Cl}(V,q)`), " と ", math(String.raw`\mathrm{Cl}(\theta'):\mathrm{Cl}(V,q)\to\mathrm{Cl}(Y,Q)`), " が定まる（",
        ref("def_homomorphism_of_clifford_algebras_induced_by_isometry"), "）。写像 ", math(String.raw`\Phi_Y:\mathrm{Cl}(Y,Q)\to B`), " と ",
        math(String.raw`\Psi_Y:B\to\mathrm{Cl}(Y,Q)`), " を次で定める。",
      ]),
      displayMath(String.raw`\Phi_Y:=\Phi\circ\mathrm{Cl}(\theta),\qquad\Psi_Y:=\mathrm{Cl}(\theta')\circ\Psi`),
      paragraph(["このとき次が成り立つ。"]),
      list([
        [math(String.raw`\Phi_Y`), " と ", math(String.raw`\Psi_Y`), " はどちらも ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。"],
        [
          "すべての ", math(String.raw`a\in\mathrm{Cl}(Y,Q)`), " について ", math(String.raw`\Psi_Y(\Phi_Y(a))=a`), " であり、すべての ", math(String.raw`F\in B`), " について ",
          math(String.raw`\Phi_Y(\Psi_Y(F))=F`), " である。",
        ],
      ]),
      paragraph([
        "したがって ", math(String.raw`\Phi_Y`), " は全単射であり、その逆写像は ", math(String.raw`\Psi_Y`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\Phi`), "・", math(String.raw`\Psi`), "・", math(String.raw`\mathrm{Cl}(\theta)`), "・", math(String.raw`\mathrm{Cl}(\theta')`), " は ℂ-代数の準同型なので（",
        ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "、", ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism"), "、",
        ref("def_homomorphism_of_clifford_algebras_induced_by_isometry"), "）、その合成 ", math(String.raw`\Phi_Y`), " と ", math(String.raw`\Psi_Y`), " は ℂ-代数の準同型である（",
        ref("claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism"), "）。",
      ]),
      paragraph([
        math(String.raw`\theta'(\theta(x))=x`), "（", math(String.raw`x\in Y`), "。", ref("claim_map_from_split_after_map_to_split_is_identity"), "）と ",
        math(String.raw`\theta(\theta'(y))=y`), "（", math(String.raw`y\in V`), "。", ref("claim_map_to_split_after_map_from_split_is_identity"), "）から、次の二つの等式が出る。一つ目は、",
        ref("claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity"), " の二つの空間に ", math(String.raw`(Y,Q)`), " と ", math(String.raw`(V,q)`), " をこの順に、",
        math(String.raw`\sigma`), " に ", math(String.raw`\theta`), "、", math(String.raw`\tau`), " に ", math(String.raw`\theta'`), " を当てて得る、すべての ",
        math(String.raw`a\in\mathrm{Cl}(Y,Q)`), " についての ", math(String.raw`\mathrm{Cl}(\theta')(\mathrm{Cl}(\theta)(a))=a`), " である。二つ目は、同じ主張の二つの空間に ",
        math(String.raw`(V,q)`), " と ", math(String.raw`(Y,Q)`), " をこの順に、", math(String.raw`\sigma`), " に ", math(String.raw`\theta'`), "、", math(String.raw`\tau`), " に ",
        math(String.raw`\theta`), " を当てて得る、すべての ", math(String.raw`X\in\mathrm{Cl}(V,q)`), " についての ", math(String.raw`\mathrm{Cl}(\theta)(\mathrm{Cl}(\theta')(X))=X`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi_Y\bigl(\Phi_Y(a)\bigr)
&=\mathrm{Cl}(\theta')\Bigl(\Psi\Bigl(\Phi\bigl(\mathrm{Cl}(\theta)(a)\bigr)\Bigr)\Bigr)
&&\left(\because\ \Phi_Y,\ \Psi_Y\ \text{の定義}\right)\\
&=\mathrm{Cl}(\theta')\bigl(\mathrm{Cl}(\theta)(a)\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right)\\
&=a
&&\left(\because\ \text{上の一つ目の等式}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Phi_Y\bigl(\Psi_Y(F)\bigr)
&=\Phi\Bigl(\mathrm{Cl}(\theta)\Bigl(\mathrm{Cl}(\theta')\bigl(\Psi(F)\bigr)\Bigr)\Bigr)
&&\left(\because\ \Phi_Y,\ \Psi_Y\ \text{の定義}\right)\\
&=\Phi\bigl(\Psi(F)\bigr)
&&\left(\because\ \text{上の二つ目の等式で}\ X:=\Psi(F)\right)\\
&=F
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity}\right).
\end{aligned}`),
      paragraph([
        "単射であること。", math(String.raw`a,a'\in\mathrm{Cl}(Y,Q)`), " が ", math(String.raw`\Phi_Y(a)=\Phi_Y(a')`), " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
a
&=\Psi_Y\bigl(\Phi_Y(a)\bigr)
&&\left(\because\ \text{一つ目の式変形}\right)\\
&=\Psi_Y\bigl(\Phi_Y(a')\bigr)
&&\left(\because\ \Phi_Y(a)=\Phi_Y(a')\right)\\
&=a'
&&\left(\because\ \text{一つ目の式変形}\right).
\end{aligned}`),
      paragraph([
        "全射であること。", math(String.raw`F\in B`), " について ", math(String.raw`\Psi_Y(F)`), " は ", math(String.raw`\Phi_Y(\Psi_Y(F))=F`), " を満たす。したがって ",
        math(String.raw`\Phi_Y`), " は全単射である。", math(String.raw`\Phi_Y`), " の逆写像を ", math(String.raw`\Phi_Y^{-1}:B\to\mathrm{Cl}(Y,Q)`), "（", math(String.raw`F`), " に ",
        math(String.raw`\Phi_Y(a)=F`), " を満たすただ一つの ", math(String.raw`a`), " を与える写像）とすると、", math(String.raw`\Psi_Y(F)`), " はこの条件を満たすので、",
        math(String.raw`\Phi_Y^{-1}(F)=\Psi_Y(F)`), " である。",
      ]),
    ],
  },
  {
    id: "isomorphism_odd_dimensional_quadratic_space_heading",
    kind: "heading",
    level: 2,
    title: { text: "系：奇数次元の二次空間" },
    labels: [],
  },
  {
    id: "isomorphism_definition_odd_dimensional_extension_of_split_quadratic_space",
    kind: "definition",
    title: { text: "分裂した二次空間に一つの次元を足した空間と、その上の二次の写像" },
    labels: ["def_odd_dimensional_extension_of_split_quadratic_space"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`W`), "、", math(String.raw`w`), "、", math(String.raw`f`), "、", math(String.raw`V=W\oplus W^{*}`), "、", math(String.raw`q=q_W`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のものとし、", math(String.raw`\mathbb{C}^{\mathrm{vec}}`), " を ℂ に ℂ-線型空間の構造を与える組（", ref("def_complex_numbers_as_complex_vector_space"), "、", ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"), "）とする。", math(String.raw`V`), " と ", math(String.raw`\mathbb{C}^{\mathrm{vec}}`), " の直和（", ref("def_direct_sum_of_two_vector_spaces"), "、", ref("claim_direct_sum_of_two_vector_spaces_is_complex_vector_space"), "）を ", math(String.raw`V':=V\oplus\mathbb{C}^{\mathrm{vec}}`), " と書き、直和の第一成分への埋め込み写像（", ref("def_embedding_into_first_component_of_direct_sum"), "）を ", math(String.raw`\mathrm{in}'_1:V\to V'`), "、第二成分への埋め込み写像（", ref("def_embedding_into_second_component_of_direct_sum"), "）を ", math(String.raw`\mathrm{in}'_2:\mathbb{C}^{\mathrm{vec}}\to V'`), " と書く。写像 ", math(String.raw`q':V'\to\mathbb{C}`), " を次で定める。"]),
      displayMath(String.raw`q'\bigl((v,t)\bigr):=q(v)+_{\mathbb{C}}(t\cdot_{\mathbb{C}}t)\qquad(v\in V,\ t\in\mathbb{C})`),
      paragraph([math(String.raw`V'`), " の元は ", math(String.raw`v\in V`), " と ", math(String.raw`t\in\mathbb{C}`), " の順序対 ", math(String.raw`(v,t)`), " であり（", ref("def_direct_sum_of_two_vector_spaces"), "）、", math(String.raw`q(v)`), " と ", math(String.raw`t\cdot_{\mathbb{C}}t`), " は ℂ の元なので、", math(String.raw`q'`), " は値域を ℂ とする写像として定まる。", math(String.raw`\mathrm{in}_1,\mathrm{in}_2`), " は ", math(String.raw`V=W\oplus W^{*}`), " の埋め込み写像、", math(String.raw`\mathrm{in}'_1,\mathrm{in}'_2`), " は ", math(String.raw`V'`), " の埋め込み写像であり、別の写像である。", math(String.raw`q'`), " が二次形式であることは、この定義では主張しない。"]),
    ],
  },
  {
    id: "isomorphism_claim_family_of_unit_is_basis_of_complex_numbers",
    kind: "claim",
    title: { text: "ℂ の乗法の単位元一つからなる族は、ℂ に線型空間の構造を与えた組の基底である" },
    labels: ["claim_family_of_unit_is_basis_of_complex_numbers"],
    statement: [
      paragraph(["写像 ", math(String.raw`o:\{1\}\to\mathbb{C}`), " を ", math(String.raw`o(1):=1_{\mathbb{C}}`), " で定め、", math(String.raw`o_1:=o(1)`), " と書く。このとき ", math(String.raw`o`), " は ", math(String.raw`\mathbb{C}^{\mathrm{vec}}`), "（", ref("def_complex_numbers_as_complex_vector_space"), "、", ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"), "）の基底（", ref("def_basis"), "）である。"]),
    ],
    proof: [
      paragraph(["準備として、", math(String.raw`\lambda_1\in\mathbb{C}`), " について ", math(String.raw`\mathbb{C}^{\mathrm{vec}}`), " の中の線型結合（", ref("def_linear_combination"), "）を計算する。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{1}\lambda_k\cdot_{\mathbb{C}^{\mathrm{vec}}}o_k
&=0_{\mathbb{C}^{\mathrm{vec}}}+_{\mathbb{C}^{\mathrm{vec}}}\bigl(\lambda_1\cdot_{\mathbb{C}^{\mathrm{vec}}}o_1\bigr)
&&\left(\because\ \blkref{def_linear_combination}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}\bigl(\lambda_1\cdot_{\mathbb{C}}o_1\bigr)
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}},\ \cdot_{\mathbb{C}^{\mathrm{vec}}},\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義}\text{。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}\bigl(\lambda_1\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ o\ \text{の定義}\right)\\
&=\lambda_1
&&\left(\because\ \mathbb{C}\ \text{の四則}\right).
\end{aligned}`),
      paragraph(["一次独立であること。", math(String.raw`\sum_{k=1}^{1}\lambda_k\cdot_{\mathbb{C}^{\mathrm{vec}}}o_k=0_{\mathbb{C}^{\mathrm{vec}}}`), " とする。", math(String.raw`0_{\mathbb{C}^{\mathrm{vec}}}=0_{\mathbb{C}}`), "（", ref("def_complex_numbers_as_complex_vector_space"), "）と準備の式から ", math(String.raw`\lambda_1=0_{\mathbb{C}}`), " である。したがって ", math(String.raw`o`), " は一次独立である（", ref("def_linear_independence"), "）。"]),
      paragraph(["張ること。", math(String.raw`t\in\mathbb{C}`), " を任意に取り、", math(String.raw`\lambda_1:=t`), " とすると、準備の式から ", math(String.raw`\sum_{k=1}^{1}\lambda_k\cdot_{\mathbb{C}^{\mathrm{vec}}}o_k=t`), " である。したがって ", math(String.raw`o`), " は ", math(String.raw`\mathbb{C}^{\mathrm{vec}}`), " を線型結合で張る（", ref("def_spanning_family"), "）。二つの条件から ", math(String.raw`o`), " は基底である（", ref("def_basis"), "）。"]),
    ],
  },
  {
    id: "isomorphism_claim_polarization_of_odd_extension_quadratic_form",
    kind: "claim",
    title: { text: "一つの次元を足した空間の上の二次の写像の偏極" },
    labels: ["claim_polarization_of_odd_extension_quadratic_form"],
    statement: [
      paragraph([math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`V'`), "、", math(String.raw`q'`), " を ", ref("def_odd_dimensional_extension_of_split_quadratic_space"), " のもの、", math(String.raw`B_q`), " と ", math(String.raw`B_{q'}`), " を ", math(String.raw`q`), " と ", math(String.raw`q'`), " の偏極（", ref("def_polarization_of_map_to_complex_numbers"), "）とし、ℂ の元 ", math(String.raw`a`), " の加法の逆元を ", math(String.raw`-_{\mathbb{C}}a`), " と書く。すべての ", math(String.raw`v,v'\in V`), " と ", math(String.raw`t,t'\in\mathbb{C}`), " について次が成り立つ。"]),
      displayMath(String.raw`B_{q'}\bigl((v,t),(v',t')\bigr)=B_q(v,v')+_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}t\bigr)`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
B_{q'}\bigl((v,t),(v',t')\bigr)
&=\Bigl(q'\bigl((v,t)+_{V'}(v',t')\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q'((v,t))\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q'((v',t'))\bigr)
&&\left(\because\ \blkref{def_polarization_of_map_to_complex_numbers}\right)\\
&=\Bigl(q'\bigl((v+_V v',\ t+_{\mathbb{C}^{\mathrm{vec}}}t')\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q'((v,t))\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q'((v',t'))\bigr)
&&\left(\because\ +_{V'}\ \text{の定義}\text{。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\Bigl(q'\bigl((v+_V v',\ t+_{\mathbb{C}}t')\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q'((v,t))\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q'((v',t'))\bigr)
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義}\text{。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\Bigl(\bigl(q(v+_V v')+_{\mathbb{C}}(t+_{\mathbb{C}}t')\cdot_{\mathbb{C}}(t+_{\mathbb{C}}t')\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}(q(v)+_{\mathbb{C}}t\cdot_{\mathbb{C}}t)\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}(q(v')+_{\mathbb{C}}t'\cdot_{\mathbb{C}}t')\bigr)
&&\left(\because\ q'\ \text{の定義を三か所に}\text{。}\blkref{def_odd_dimensional_extension_of_split_quadratic_space}\right)\\
&=\Bigl(\bigl(q(v+_V v')+_{\mathbb{C}}(-_{\mathbb{C}}q(v))\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(v')\bigr)\Bigr)+_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}t\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=B_q(v,v')+_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}t\bigr)
&&\left(\because\ \blkref{def_polarization_of_map_to_complex_numbers}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_odd_extension_quadratic_form_is_quadratic_form",
    kind: "claim",
    title: { text: "一つの次元を足した空間の上の二次の写像は二次形式である" },
    labels: ["claim_odd_extension_quadratic_form_is_quadratic_form"],
    statement: [
      paragraph([math(String.raw`V'`), " と ", math(String.raw`q'`), " を ", ref("def_odd_dimensional_extension_of_split_quadratic_space"), " のものとする。", math(String.raw`V'`), " は ℂ-線型空間であり（", ref("claim_direct_sum_of_two_vector_spaces_is_complex_vector_space"), "）、", math(String.raw`q'`), " は ", math(String.raw`V'`), " 上の二次形式（", ref("def_quadratic_form"), "）である。"]),
    ],
    proof: [
      paragraph([math(String.raw`q=q_W`), " は ", math(String.raw`V`), " 上の二次形式である（", ref("claim_split_quadratic_form_is_quadratic_form"), "）。", math(String.raw`V'`), " の元は順序対なので、", math(String.raw`v,v'',v'\in V`), "、", math(String.raw`t,t'',t'\in\mathbb{C}`), " として ", math(String.raw`(v,t)`), "、", math(String.raw`(v'',t'')`), "、", math(String.raw`(v',t')`), " と書き、", math(String.raw`\lambda\in\mathbb{C}`), " とする。一つ目の条件は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
q'\bigl(\lambda\cdot_{V'}(v,t)\bigr)
&=q'\bigl((\lambda\cdot_V v,\ \lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}t)\bigr)
&&\left(\because\ \cdot_{V'}\ \text{の定義}\text{。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=q'\bigl((\lambda\cdot_V v,\ \lambda\cdot_{\mathbb{C}}t)\bigr)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義}\text{。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=q(\lambda\cdot_V v)+_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}t)\cdot_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}t)
&&\left(\because\ q'\ \text{の定義}\text{。}\blkref{def_odd_dimensional_extension_of_split_quadratic_space}\right)\\
&=\lambda\cdot_{\mathbb{C}}\bigl(\lambda\cdot_{\mathbb{C}}q(v)\bigr)+_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}t)\cdot_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}t)
&&\left(\because\ q\ \text{は二次形式}\text{。}\blkref{def_quadratic_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}\Bigl(\lambda\cdot_{\mathbb{C}}\bigl(q(v)+_{\mathbb{C}}t\cdot_{\mathbb{C}}t\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\lambda\cdot_{\mathbb{C}}\Bigl(\lambda\cdot_{\mathbb{C}}q'\bigl((v,t)\bigr)\Bigr)
&&\left(\because\ q'\ \text{の定義}\text{。}\blkref{def_odd_dimensional_extension_of_split_quadratic_space}\right).
\end{aligned}`),
      paragraph(["二つ目の条件。", math(String.raw`y:=(v',t')`), " を固定し、写像 ", math(String.raw`x\mapsto B_{q'}(x,y)`), " が ", math(String.raw`V'`), " 上の線型形式（", ref("def_linear_form"), "）であることを示す。写像 ", math(String.raw`x'\mapsto B_q(x',v')`), " は ", math(String.raw`V`), " 上の線型形式である（", math(String.raw`q`), " は二次形式。", ref("def_quadratic_form"), "）。加法を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
B_{q'}\bigl((v,t)+_{V'}(v'',t''),\ y\bigr)
&=B_{q'}\bigl((v+_V v'',\ t+_{\mathbb{C}}t''),\ y\bigr)
&&\left(\because\ +_{V'}\ \text{と}\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\text{、}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=B_q(v+_V v'',v')+_{\mathbb{C}}\bigl((t+_{\mathbb{C}}t'')\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}(t+_{\mathbb{C}}t'')\bigr)
&&\left(\because\ \blkref{claim_polarization_of_odd_extension_quadratic_form}\right)\\
&=\bigl(B_q(v,v')+_{\mathbb{C}}B_q(v'',v')\bigr)+_{\mathbb{C}}\bigl((t+_{\mathbb{C}}t'')\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}(t+_{\mathbb{C}}t'')\bigr)
&&\left(\because\ x'\mapsto B_q(x',v')\ \text{は加法を保つ}\text{。}\blkref{def_linear_form}\right)\\
&=\Bigl(B_q(v,v')+_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}t\bigr)\Bigr)+_{\mathbb{C}}\Bigl(B_q(v'',v')+_{\mathbb{C}}\bigl(t''\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}t''\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=B_{q'}\bigl((v,t),y\bigr)+_{\mathbb{C}}B_{q'}\bigl((v'',t''),y\bigr)
&&\left(\because\ \blkref{claim_polarization_of_odd_extension_quadratic_form}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
B_{q'}\bigl(\lambda\cdot_{V'}(v,t),\ y\bigr)
&=B_{q'}\bigl((\lambda\cdot_V v,\ \lambda\cdot_{\mathbb{C}}t),\ y\bigr)
&&\left(\because\ \cdot_{V'}\ \text{と}\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\text{、}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=B_q(\lambda\cdot_V v,v')+_{\mathbb{C}}\bigl((\lambda\cdot_{\mathbb{C}}t)\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}t)\bigr)
&&\left(\because\ \blkref{claim_polarization_of_odd_extension_quadratic_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}B_q(v,v')+_{\mathbb{C}}\bigl((\lambda\cdot_{\mathbb{C}}t)\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}t)\bigr)
&&\left(\because\ x'\mapsto B_q(x',v')\ \text{はスカラー倍を保つ}\text{。}\blkref{def_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}\Bigl(B_q(v,v')+_{\mathbb{C}}\bigl(t\cdot_{\mathbb{C}}t'+_{\mathbb{C}}t'\cdot_{\mathbb{C}}t\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\lambda\cdot_{\mathbb{C}}B_{q'}\bigl((v,t),y\bigr)
&&\left(\because\ \blkref{claim_polarization_of_odd_extension_quadratic_form}\right).
\end{aligned}`),
      paragraph(["二つの条件が満たされたので、", math(String.raw`q'`), " は ", math(String.raw`V'`), " 上の二次形式である（", ref("def_quadratic_form"), "）。"]),
    ],
  },
  {
    id: "isomorphism_claim_embedding_into_first_component_of_odd_extension_is_isometry",
    kind: "claim",
    title: { text: "一つの次元を足した空間の第一成分への埋め込み写像は等長写像である" },
    labels: ["claim_embedding_into_first_component_of_odd_extension_is_isometry"],
    statement: [
      paragraph([math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`V'`), "、", math(String.raw`q'`), "、", math(String.raw`\mathrm{in}'_1`), " を ", ref("def_odd_dimensional_extension_of_split_quadratic_space"), " のものとする。", math(String.raw`\mathrm{in}'_1`), " は ", math(String.raw`(V,q)`), " から ", math(String.raw`(V',q')`), " への等長写像（", ref("def_isometry_of_quadratic_spaces"), "）である。"]),
    ],
    proof: [
      paragraph([math(String.raw`q`), " は ", math(String.raw`V`), " 上の二次形式（", ref("claim_split_quadratic_form_is_quadratic_form"), "）、", math(String.raw`q'`), " は ", math(String.raw`V'`), " 上の二次形式（", ref("claim_odd_extension_quadratic_form_is_quadratic_form"), "）であり、", math(String.raw`\mathrm{in}'_1`), " は線型写像である（", ref("claim_embedding_into_first_component_is_linear_map"), "）。", math(String.raw`v\in V`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
q'\bigl(\mathrm{in}'_1(v)\bigr)
&=q'\bigl((v,\ 0_{\mathbb{C}^{\mathrm{vec}}})\bigr)
&&\left(\because\ \blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&=q'\bigl((v,\ 0_{\mathbb{C}})\bigr)
&&\left(\because\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義}\text{。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=q(v)+_{\mathbb{C}}0_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ q'\ \text{の定義}\text{。}\blkref{def_odd_dimensional_extension_of_split_quadratic_space}\right)\\
&=q(v)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right).
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`\mathrm{in}'_1`), " は等長写像である（", ref("def_isometry_of_quadratic_spaces"), "）。"]),
    ],
  },
  {
    id: "isomorphism_claim_odd_extension_quadratic_form_at_added_unit_vector_is_one",
    kind: "claim",
    title: { text: "足した次元の単位の元での二次形式の値は 1 である" },
    labels: ["claim_odd_extension_quadratic_form_at_added_unit_vector_is_one"],
    statement: [
      paragraph([math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`q'`), "、", math(String.raw`\mathrm{in}'_2`), " を ", ref("def_odd_dimensional_extension_of_split_quadratic_space"), " のものとする。", math(String.raw`q'\bigl(\mathrm{in}'_2(1_{\mathbb{C}})\bigr)=1_{\mathbb{C}}`), " である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
q'\bigl(\mathrm{in}'_2(1_{\mathbb{C}})\bigr)
&=q'\bigl((0_V,\ 1_{\mathbb{C}})\bigr)
&&\left(\because\ \blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&=q(0_V)+_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ q'\ \text{の定義}\text{。}\blkref{def_odd_dimensional_extension_of_split_quadratic_space}\right)\\
&=q(0_{\mathbb{C}}\cdot_V 0_V)+_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \lambda:=0_{\mathbb{C}}\ \text{とした}\text{。}\blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}q(0_V)\bigr)+_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ q\ \text{は二次形式。}\blkref{def_quadratic_form}\text{。}\blkref{claim_split_quadratic_form_is_quadratic_form}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_polarization_of_odd_extension_between_first_component_and_added_unit_vector_is_zero",
    kind: "claim",
    title: { text: "第一成分の元と足した次元の単位の元の偏極は 0 である" },
    labels: ["claim_polarization_of_odd_extension_between_first_component_and_added_unit_vector_is_zero"],
    statement: [
      paragraph([math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`q'`), "、", math(String.raw`\mathrm{in}'_1`), "、", math(String.raw`\mathrm{in}'_2`), " を ", ref("def_odd_dimensional_extension_of_split_quadratic_space"), " のもの、", math(String.raw`B_q`), " と ", math(String.raw`B_{q'}`), " を ", math(String.raw`q`), " と ", math(String.raw`q'`), " の偏極（", ref("def_polarization_of_map_to_complex_numbers"), "）とする。すべての ", math(String.raw`v\in V`), " について ", math(String.raw`B_{q'}\bigl(\mathrm{in}'_1(v),\mathrm{in}'_2(1_{\mathbb{C}})\bigr)=0_{\mathbb{C}}`), " である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
B_{q'}\bigl(\mathrm{in}'_1(v),\mathrm{in}'_2(1_{\mathbb{C}})\bigr)
&=B_{q'}\bigl((v,0_{\mathbb{C}^{\mathrm{vec}}}),\ (0_V,1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathrm{in}'_1,\ \mathrm{in}'_2\ \text{の定義。}\blkref{def_embedding_into_first_component_of_direct_sum}\text{、}\blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&=B_{q'}\bigl((v,0_{\mathbb{C}}),\ (0_V,1_{\mathbb{C}})\bigr)
&&\left(\because\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義}\text{。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=B_q(v,0_V)+_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ \blkref{claim_polarization_of_odd_extension_quadratic_form}\right)\\
&=B_q(v,0_V)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ y\mapsto B_q(v,y)\ \text{は線型形式。}\blkref{claim_polarization_of_quadratic_form_is_linear_in_second_argument}\text{、}\blkref{claim_split_quadratic_form_is_quadratic_form}\text{。}\blkref{claim_linear_form_sends_zero_vector_to_zero}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_setting_of_odd_dimensional_corollary",
    kind: "definition",
    title: { text: "奇数次元の系で固定する記号" },
    labels: ["def_setting_of_odd_dimensional_corollary"],
    statement: [
      paragraph([math(String.raw`M`), "、", math(String.raw`W`), "、", math(String.raw`w`), "、", math(String.raw`f`), "、", math(String.raw`V`), "、", math(String.raw`q`), "、", math(String.raw`\mathrm{Cl}(V,q)`), "、", math(String.raw`\gamma`), "、", math(String.raw`\mathrm{in}_1`), "、", math(String.raw`\mathrm{in}_2`), " を ", ref("def_clifford_algebra_of_split_quadratic_space"), " のもの、", math(String.raw`a^{\dagger}_i`), " を ", ref("def_creation_generator_of_split_clifford_algebra"), "、", math(String.raw`a_i`), " を ", ref("def_annihilation_generator_of_split_clifford_algebra"), " の元とし、", math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書く。同じ定義が基底 ", math(String.raw`c`), " と呼ぶ ", math(String.raw`V`), " の基底を、生成作用素の行列との区別のため、ここでは ", math(String.raw`d:\{1,\dots,2M\}\to V`), " と書く。", math(String.raw`V'`), "、", math(String.raw`\mathrm{in}'_1`), "、", math(String.raw`\mathrm{in}'_2`), "、", math(String.raw`q'`), " を ", ref("def_odd_dimensional_extension_of_split_quadratic_space"), " のもの、", math(String.raw`o`), " を ", ref("claim_family_of_unit_is_basis_of_complex_numbers"), " の ", math(String.raw`\mathbb{C}^{\mathrm{vec}}`), " の基底とする。"]),
      paragraph([math(String.raw`d':\{1,\dots,2M+1\}\to V'`), " を、", ref("claim_basis_of_direct_sum_of_two_vector_spaces"), " で ", math(String.raw`V_1:=V`), "、", math(String.raw`V_2:=\mathbb{C}^{\mathrm{vec}}`), "、", math(String.raw`n:=2M`), "、", math(String.raw`n':=1`), "、", math(String.raw`b:=d`), "、", math(String.raw`b':=o`), " としたときの ", math(String.raw`V'`), " の基底とする。", math(String.raw`q'`), " は ", math(String.raw`V'`), " 上の二次形式なので（", ref("claim_odd_extension_quadratic_form_is_quadratic_form"), "）、基底 ", math(String.raw`d'`), " で構成した ", math(String.raw`(V',q')`), " のクリフォード代数（", ref("def_clifford_ideal"), "、", ref("def_clifford_algebra"), "）を ", math(String.raw`A':=\mathrm{Cl}(V',q')`), " と書き、", math(String.raw`\gamma':V'\to A'`), " を ", ref("def_clifford_generator_map"), " の写像とする。"]),
      paragraph([math(String.raw`\mathrm{in}'_1`), " は ", math(String.raw`(V,q)`), " から ", math(String.raw`(V',q')`), " への等長写像なので（", ref("claim_embedding_into_first_component_of_odd_extension_is_isometry"), "）、それが誘導する準同型（", ref("def_homomorphism_of_clifford_algebras_induced_by_isometry"), "）を ", math(String.raw`j:=\mathrm{Cl}(\mathrm{in}'_1):A\to A'`), " と書く。", math(String.raw`j`), " は ℂ-代数の準同型で、", math(String.raw`V`), " から ", math(String.raw`A'`), " への写像として ", math(String.raw`j\circ\gamma=\gamma'\circ\mathrm{in}'_1`), " を満たす。", math(String.raw`V'`), " の元 ", math(String.raw`u`), " と ", math(String.raw`A'`), " の元 ", math(String.raw`g`), " を次で定める。"]),
      displayMath(String.raw`u:=\mathrm{in}'_2(1_{\mathbb{C}})\in V',\qquad g:=\gamma'(u)\in A'`),
      paragraph([math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), "（", ref("def_matrices_indexed_by_finite_set"), "、", ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"), "）と書き、", math(String.raw`\Phi:A\to B`), " を ", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "、", math(String.raw`\Psi:B\to A`), " を ", ref("def_homomorphism_from_matrix_algebra_to_clifford_algebra"), " の写像とする。ℂ の元 ", math(String.raw`a`), " の加法の逆元を ", math(String.raw`-_{\mathbb{C}}a`), " と書き、", math(String.raw`-1_{\mathbb{C}}:=-_{\mathbb{C}}1_{\mathbb{C}}`), " とする。ℂ の中で ", math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}\neq 0_{\mathbb{C}}`), " なので、その乗法の逆元を ", math(String.raw`h:=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\in\mathbb{C}`), " と書く。"]),
    ],
  },
  {
    id: "isomorphism_claim_square_of_added_generator_is_one",
    kind: "claim",
    title: { text: "足した次元の単位の元の像の平方は 1 である" },
    labels: ["claim_square_of_added_generator_is_one"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`g\cdot_{A'}g=1_{A'}`), " である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
g\cdot_{A'}g
&=\gamma'(u)\cdot_{A'}\gamma'(u)
&&\left(\because\ g\ \text{の定義}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=q'(u)\ast_{A'}1_{A'}
&&\left(\because\ \blkref{claim_square_of_clifford_generator}\right)\\
&=q'\bigl(\mathrm{in}'_2(1_{\mathbb{C}})\bigr)\ast_{A'}1_{A'}
&&\left(\because\ u\ \text{の定義}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=1_{\mathbb{C}}\ast_{A'}1_{A'}
&&\left(\because\ \blkref{claim_odd_extension_quadratic_form_at_added_unit_vector_is_one}\right)\\
&=1_{A'}
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_added_generator_anticommutes_with_image_of_split_space",
    kind: "claim",
    title: { text: "足した次元の単位の元の像は、分裂した二次空間の元の像と反交換する" },
    labels: ["claim_added_generator_anticommutes_with_image_of_split_space"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。すべての ", math(String.raw`v\in V`), " について次が成り立つ。"]),
      displayMath(String.raw`g\cdot_{A'}j\bigl(\gamma(v)\bigr)+_{A'}j\bigl(\gamma(v)\bigr)\cdot_{A'}g=0_{A'}`),
    ],
    proof: [
      paragraph([math(String.raw`B_{q'}`), " を ", math(String.raw`q'`), " の偏極（", ref("def_polarization_of_map_to_complex_numbers"), "）とする。"]),
      displayMath(String.raw`\begin{aligned}
g\cdot_{A'}j\bigl(\gamma(v)\bigr)+_{A'}j\bigl(\gamma(v)\bigr)\cdot_{A'}g
&=g\cdot_{A'}\gamma'\bigl(\mathrm{in}'_1(v)\bigr)+_{A'}\gamma'\bigl(\mathrm{in}'_1(v)\bigr)\cdot_{A'}g
&&\left(\because\ j\circ\gamma=\gamma'\circ\mathrm{in}'_1\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=\gamma'(u)\cdot_{A'}\gamma'\bigl(\mathrm{in}'_1(v)\bigr)+_{A'}\gamma'\bigl(\mathrm{in}'_1(v)\bigr)\cdot_{A'}\gamma'(u)
&&\left(\because\ g\ \text{の定義}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=B_{q'}\bigl(u,\mathrm{in}'_1(v)\bigr)\ast_{A'}1_{A'}
&&\left(\because\ \blkref{claim_anticommutator_of_clifford_generator_images_is_polarization}\right)\\
&=B_{q'}\bigl(\mathrm{in}'_1(v),u\bigr)\ast_{A'}1_{A'}
&&\left(\because\ \blkref{claim_polarization_is_symmetric}\right)\\
&=B_{q'}\bigl(\mathrm{in}'_1(v),\mathrm{in}'_2(1_{\mathbb{C}})\bigr)\ast_{A'}1_{A'}
&&\left(\because\ u\ \text{の定義}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=0_{\mathbb{C}}\ast_{A'}1_{A'}
&&\left(\because\ \blkref{claim_polarization_of_odd_extension_between_first_component_and_added_unit_vector_is_zero}\right)\\
&=0_{A'}
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_parity_factor_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "番号ごとの符号の因子" },
    labels: ["def_parity_factor_of_split_clifford_algebra"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`i\in\{1,\dots,M\}`), " について、", math(String.raw`A`), " の元 ", math(String.raw`\chi_i`), " を次で定める。"]),
      displayMath(String.raw`\chi_i:=a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_i\cdot_A a_i\bigr)`),
    ],
  },
  {
    id: "isomorphism_definition_parity_element_of_split_clifford_algebra",
    kind: "definition",
    title: { text: "符号の因子の番号順の積" },
    labels: ["def_parity_element_of_split_clifford_algebra"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), " のものとする。", math(String.raw`A`), " の元 ", math(String.raw`\varepsilon`), " を、", math(String.raw`A`), " の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で次のように定める。"]),
      displayMath(String.raw`\varepsilon:=\prod_{A,\,i=1}^{M}\chi_i`),
    ],
  },
  {
    id: "isomorphism_claim_parity_factor_times_annihilation_generator",
    kind: "claim",
    title: { text: "符号の因子に同じ番号の消滅作用素にあたる元を右から掛けると、その元になる" },
    labels: ["claim_parity_factor_times_annihilation_generator"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), " は ", ref("def_vacuum_factor_of_split_clifford_algebra"), " の元、", math(String.raw`\chi_i`), " は ", ref("def_parity_factor_of_split_clifford_algebra"), " の元である。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\chi_i\cdot_A a_i=a_i`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\chi_i\cdot_A a_i
&=\bigl(a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a_i
&&\left(\because\ \blkref{def_parity_factor_of_split_clifford_algebra}\right)\\
&=(a_i\cdot_A a^{\dagger}_i)\cdot_A a_i+_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=x_i\cdot_A a_i+_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a_i
&&\left(\because\ \blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=a_i+_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a_i
&&\left(\because\ \blkref{claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator}\right)\\
&=a_i+_A(-1_{\mathbb{C}})\ast_A\bigl((a^{\dagger}_i\cdot_A a_i)\cdot_A a_i\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=a_i+_A(-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_i\cdot_A(a_i\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i+_A(-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_i\cdot_A 0_A\bigr)
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=a_i+_A(-1_{\mathbb{C}})\ast_A0_A
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=a_i+_A 0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_annihilation_generator_anticommutes_with_parity_factor",
    kind: "claim",
    title: { text: "消滅作用素にあたる元は、同じ番号の符号の因子と反交換する" },
    labels: ["claim_annihilation_generator_anticommutes_with_parity_factor"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), " は ", ref("def_vacuum_factor_of_split_clifford_algebra"), " の元、", math(String.raw`\chi_i`), " は ", ref("def_parity_factor_of_split_clifford_algebra"), " の元である。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a_i\cdot_A\chi_i=(-1_{\mathbb{C}})\ast_A(\chi_i\cdot_A a_i)`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a_i\cdot_A\chi_i
&=a_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{def_parity_factor_of_split_clifford_algebra}\right)\\
&=a_i\cdot_A(a_i\cdot_A a^{\dagger}_i)+_A a_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=(a_i\cdot_A a_i)\cdot_A a^{\dagger}_i+_A a_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=0_A\cdot_A a^{\dagger}_i+_A a_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{claim_square_of_annihilation_generator_is_zero}\right)\\
&=0_A+_A a_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=a_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)+_A 0_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(a_i\cdot_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((a_i\cdot_A a^{\dagger}_i)\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A(x_i\cdot_A a_i)
&&\left(\because\ \blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_Aa_i
&&\left(\because\ \blkref{claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator}\right)\\
&=(-1_{\mathbb{C}})\ast_A(\chi_i\cdot_A a_i)
&&\left(\because\ \blkref{claim_parity_factor_times_annihilation_generator}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_parity_factor_times_creation_generator",
    kind: "claim",
    title: { text: "符号の因子に同じ番号の生成作用素にあたる元を右から掛けると、その元の (-1) 倍になる" },
    labels: ["claim_parity_factor_times_creation_generator"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), " は ", ref("def_vacuum_factor_of_split_clifford_algebra"), " の元、", math(String.raw`\chi_i`), " は ", ref("def_parity_factor_of_split_clifford_algebra"), " の元である。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\chi_i\cdot_A a^{\dagger}_i=(-1_{\mathbb{C}})\ast_A a^{\dagger}_i`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\chi_i\cdot_A a^{\dagger}_i
&=\bigl(a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ \blkref{def_parity_factor_of_split_clifford_algebra}\right)\\
&=(a_i\cdot_A a^{\dagger}_i)\cdot_A a^{\dagger}_i+_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A(a^{\dagger}_i\cdot_A a^{\dagger}_i)+_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A 0_A+_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=0_A+_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_i+_A 0_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)\cdot_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((a^{\dagger}_i\cdot_A a_i)\cdot_A a^{\dagger}_i\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_i\cdot_A(a_i\cdot_A a^{\dagger}_i)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A x_i)
&&\left(\because\ \blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_Aa^{\dagger}_i
&&\left(\because\ \blkref{claim_creation_generator_times_vacuum_factor_is_creation_generator}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_generator_anticommutes_with_parity_factor",
    kind: "claim",
    title: { text: "生成作用素にあたる元は、同じ番号の符号の因子と反交換する" },
    labels: ["claim_creation_generator_anticommutes_with_parity_factor"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), " は ", ref("def_vacuum_factor_of_split_clifford_algebra"), " の元、", math(String.raw`\chi_i`), " は ", ref("def_parity_factor_of_split_clifford_algebra"), " の元である。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`a^{\dagger}_i\cdot_A\chi_i=(-1_{\mathbb{C}})\ast_A(\chi_i\cdot_A a^{\dagger}_i)`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_i\cdot_A\chi_i
&=a^{\dagger}_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{def_parity_factor_of_split_clifford_algebra}\right)\\
&=a^{\dagger}_i\cdot_A(a_i\cdot_A a^{\dagger}_i)+_A a^{\dagger}_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=a^{\dagger}_i\cdot_A x_i+_A a^{\dagger}_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{def_vacuum_factor_of_split_clifford_algebra}\right)\\
&=a^{\dagger}_i+_A a^{\dagger}_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{claim_creation_generator_times_vacuum_factor_is_creation_generator}\right)\\
&=a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A\bigl(a^{\dagger}_i\cdot_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A\bigl((a^{\dagger}_i\cdot_A a^{\dagger}_i)\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(0_A\cdot_A a_i)
&&\left(\because\ \blkref{claim_square_of_creation_generator_is_zero}\right)\\
&=a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A0_A
&&\left(\because\ \blkref{claim_zero_times_element_in_algebra_is_zero}\right)\\
&=a^{\dagger}_i+_A 0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=a^{\dagger}_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_{\mathbb{C}}\ast_A a^{\dagger}_i
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A a^{\dagger}_i
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((-1_{\mathbb{C}})\ast_Aa^{\dagger}_i\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(-1_{\mathbb{C}})\ast_A(\chi_i\cdot_A a^{\dagger}_i)
&&\left(\because\ \blkref{claim_parity_factor_times_creation_generator}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_square_of_parity_factor_is_one",
    kind: "claim",
    title: { text: "符号の因子の平方は 1 である" },
    labels: ["claim_square_of_parity_factor_is_one"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`x_i:=a_i\cdot_A a^{\dagger}_i`), " は ", ref("def_vacuum_factor_of_split_clifford_algebra"), " の元、", math(String.raw`\chi_i`), " は ", ref("def_parity_factor_of_split_clifford_algebra"), " の元である。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\chi_i\cdot_A\chi_i=1_A`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\chi_i\cdot_A\chi_i
&=\chi_i\cdot_A\bigl(a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{def_parity_factor_of_split_clifford_algebra}\right)\\
&=\chi_i\cdot_A(a_i\cdot_A a^{\dagger}_i)+_A\chi_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=(\chi_i\cdot_A a_i)\cdot_A a^{\dagger}_i+_A\chi_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A a^{\dagger}_i+_A\chi_i\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{claim_parity_factor_times_annihilation_generator}\right)\\
&=a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A\bigl(\chi_i\cdot_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A\bigl((\chi_i\cdot_A a^{\dagger}_i)\cdot_A a_i\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A\Bigl(\bigl((-1_{\mathbb{C}})\ast_Aa^{\dagger}_i\bigr)\cdot_A a_i\Bigr)
&&\left(\because\ \blkref{claim_parity_factor_times_creation_generator}\right)\\
&=a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=a_i\cdot_A a^{\dagger}_i+_A\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A(a^{\dagger}_i\cdot_A a_i)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=a_i\cdot_A a^{\dagger}_i+_A 1_{\mathbb{C}}\ast_A(a^{\dagger}_i\cdot_A a_i)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=a_i\cdot_A a^{\dagger}_i+_A a^{\dagger}_i\cdot_A a_i
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\delta_{i,i}\ast_A 1_A
&&\left(\because\ j:=i\ \text{とした}\text{。}\blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=1_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=1_A
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_element_anticommuting_with_two_elements_commutes_with_their_product",
    kind: "claim",
    title: { text: "二つの元のどちらとも反交換する代数の元は、その二つの積と交換する" },
    labels: ["claim_element_anticommuting_with_two_elements_commutes_with_their_product"],
    statement: [
      paragraph([math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）とし、", math(String.raw`-1_{\mathbb{C}}`), " を ", math(String.raw`1_{\mathbb{C}}`), " の ℂ の加法の逆元とする。", math(String.raw`y,p,r\in A`), " が ", math(String.raw`y\cdot_A p+_A p\cdot_A y=0_A`), " と ", math(String.raw`y\cdot_A r+_A r\cdot_A y=0_A`), " を満たすとき、次が成り立つ。"]),
      displayMath(String.raw`y\cdot_A(p\cdot_A r)=(p\cdot_A r)\cdot_A y`),
    ],
    proof: [
      paragraph(["仮定に ", ref("claim_anticommuting_elements_swap_with_sign"), " を当てると、", math(String.raw`y\cdot_A p=(-1_{\mathbb{C}})\ast_A(p\cdot_A y)`), " と ", math(String.raw`y\cdot_A r=(-1_{\mathbb{C}})\ast_A(r\cdot_A y)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
y\cdot_A(p\cdot_A r)
&=(y\cdot_A p)\cdot_A r
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A(p\cdot_A y)\bigr)\cdot_A r
&&\left(\because\ \text{一つ目の反交換の仮定から得た等式}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl((p\cdot_A y)\cdot_A r\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\bigl(p\cdot_A(y\cdot_A r)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(p\cdot_A\bigl((-1_{\mathbb{C}})\ast_A(r\cdot_A y)\bigr)\Bigr)
&&\left(\because\ \text{二つ目の反交換の仮定から得た等式}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl(p\cdot_A(r\cdot_A y)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A\bigl(p\cdot_A(r\cdot_A y)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_A\bigl(p\cdot_A(r\cdot_A y)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=p\cdot_A(r\cdot_A y)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=(p\cdot_A r)\cdot_A y
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_elements_commuting_with_fixed_element_form_subalgebra",
    kind: "claim",
    title: { text: "固定した元と交換する元の全体は部分代数である" },
    labels: ["claim_elements_commuting_with_fixed_element_form_subalgebra"],
    statement: [
      paragraph([math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`y\in A`), " とし、", math(String.raw`A`), " の部分集合 ", math(String.raw`C_y`), " を次で定める。"]),
      displayMath(String.raw`C_y:=\{\,a\in A:\ y\cdot_A a=a\cdot_A y\,\}`),
      paragraph(["このとき ", math(String.raw`C_y`), " は ", math(String.raw`A`), " の部分代数（", ref("def_subalgebra"), "）である。"]),
    ],
    proof: [
      paragraph([ref("def_subalgebra"), " の四条件を示す。", math(String.raw`a,b`), " を ", math(String.raw`C_y`), " の任意の元、", math(String.raw`\lambda`), " を ℂ の任意の元とする。", math(String.raw`a\in C_y`), " と ", math(String.raw`b\in C_y`), " は ", math(String.raw`y\cdot_A a=a\cdot_A y`), " と ", math(String.raw`y\cdot_A b=b\cdot_A y`), " のことである。乗法の単位元を含むこと。"]),
      displayMath(String.raw`\begin{aligned}
y\cdot_A 1_A
&=y
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A\cdot_A y
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph(["加法で閉じていること。"]),
      displayMath(String.raw`\begin{aligned}
y\cdot_A(a+_A b)
&=y\cdot_A a+_A y\cdot_A b
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=a\cdot_A y+_A y\cdot_A b
&&\left(\because\ a\in C_y\right)\\
&=a\cdot_A y+_A b\cdot_A y
&&\left(\because\ b\in C_y\right)\\
&=(a+_A b)\cdot_A y
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph(["乗法で閉じていること。"]),
      displayMath(String.raw`\begin{aligned}
y\cdot_A(a\cdot_A b)
&=(y\cdot_A a)\cdot_A b
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(a\cdot_A y)\cdot_A b
&&\left(\because\ a\in C_y\right)\\
&=a\cdot_A(y\cdot_A b)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=a\cdot_A(b\cdot_A y)
&&\left(\because\ b\in C_y\right)\\
&=(a\cdot_A b)\cdot_A y
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph(["スカラー倍で閉じていること。"]),
      displayMath(String.raw`\begin{aligned}
y\cdot_A(\lambda\ast_A a)
&=\lambda\ast_A(y\cdot_A a)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\lambda\ast_A(a\cdot_A y)
&&\left(\because\ a\in C_y\right)\\
&=(\lambda\ast_A a)\cdot_A y
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right).
\end{aligned}`),
      paragraph(["四条件が満たされたので、", math(String.raw`C_y`), " は部分代数である。"]),
    ],
  },
  {
    id: "isomorphism_claim_element_commuting_with_generating_subset_commutes_with_every_element",
    kind: "claim",
    title: { text: "生成する部分集合のどの元とも交換する元は、代数のすべての元と交換する" },
    labels: ["claim_element_commuting_with_generating_subset_commutes_with_every_element"],
    statement: [
      paragraph([math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`X`), " を ", math(String.raw`A`), " を生成する ", math(String.raw`A`), " の部分集合（", ref("def_subset_generates_algebra"), "）、", math(String.raw`y\in A`), " とし、すべての ", math(String.raw`x\in X`), " について ", math(String.raw`y\cdot_A x=x\cdot_A y`), " であるとする。このとき、すべての ", math(String.raw`a\in A`), " について ", math(String.raw`y\cdot_A a=a\cdot_A y`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`C_y`), " を ", ref("claim_elements_commuting_with_fixed_element_form_subalgebra"), " の部分集合とする。", math(String.raw`C_y`), " は ", math(String.raw`A`), " の部分代数であり、仮定から ", math(String.raw`X\subseteq C_y`), " である。", math(String.raw`X`), " は ", math(String.raw`A`), " を生成するので ", math(String.raw`C_y=A`), " である（", ref("def_subset_generates_algebra"), "）。", math(String.raw`a\in A=C_y`), " は ", math(String.raw`y\cdot_A a=a\cdot_A y`), " のことである。"]),
    ],
  },
  {
    id: "isomorphism_claim_generators_commute_with_parity_factor_of_other_number",
    kind: "claim",
    title: { text: "生成・消滅作用素にあたる元は、番号の違う符号の因子と交換する" },
    labels: ["claim_generators_commute_with_parity_factor_of_other_number"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), " の元とする。", math(String.raw`i\neq k`), " であるすべての ", math(String.raw`i,k\in\{1,\dots,M\}`), " と、", math(String.raw`y=a_k`), " と ", math(String.raw`y=a^{\dagger}_k`), " のそれぞれについて次が成り立つ。"]),
      displayMath(String.raw`y\cdot_A\chi_i=\chi_i\cdot_A y`),
    ],
    proof: [
      paragraph(["準備として、", math(String.raw`y`), " が ", math(String.raw`a_i`), " とも ", math(String.raw`a^{\dagger}_i`), " とも反交換することを示す。", math(String.raw`i\neq k`), " なので ", math(String.raw`\delta_{k,i}=\delta_{i,k}=0_{\mathbb{C}}`), " である（", ref("def_kronecker_delta"), "）。", math(String.raw`y=a_k`), " のとき、", math(String.raw`a_k\cdot_A a_i+_A a_i\cdot_A a_k=0_A`), " である（", ref("claim_annihilation_generators_anticommute"), "）。また次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a_k\cdot_A a^{\dagger}_i+_A a^{\dagger}_i\cdot_A a_k
&=\delta_{k,i}\ast_A 1_A
&&\left(\because\ \blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph([math(String.raw`y=a^{\dagger}_k`), " のとき、", math(String.raw`a^{\dagger}_k\cdot_A a^{\dagger}_i+_A a^{\dagger}_i\cdot_A a^{\dagger}_k=0_A`), " である（", ref("claim_creation_generators_anticommute"), "）。また次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
a^{\dagger}_k\cdot_A a_i+_A a_i\cdot_A a^{\dagger}_k
&=a_i\cdot_A a^{\dagger}_k+_A a^{\dagger}_k\cdot_A a_i
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\delta_{i,k}\ast_A 1_A
&&\left(\because\ \blkref{claim_annihilation_and_creation_generators_anticommute}\right)\\
&=0_{\mathbb{C}}\ast_A 1_A
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph(["どちらの場合も ", math(String.raw`y\cdot_A a_i+_A a_i\cdot_A y=0_A`), " かつ ", math(String.raw`y\cdot_A a^{\dagger}_i+_A a^{\dagger}_i\cdot_A y=0_A`), " である。", ref("claim_element_anticommuting_with_two_elements_commutes_with_their_product"), " を ", math(String.raw`(p,r):=(a_i,a^{\dagger}_i)`), " と ", math(String.raw`(p,r):=(a^{\dagger}_i,a_i)`), " に当てると、", math(String.raw`a_i\cdot_A a^{\dagger}_i`), " と ", math(String.raw`a^{\dagger}_i\cdot_A a_i`), " はどちらも ", ref("claim_elements_commuting_with_fixed_element_form_subalgebra"), " の部分代数 ", math(String.raw`C_y`), " に属する。", math(String.raw`C_y`), " はスカラー倍と加法で閉じているので（", ref("def_subalgebra"), "）、", math(String.raw`(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\in C_y`), "、さらに ", math(String.raw`\chi_i=a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\in C_y`), " である（", ref("def_parity_factor_of_split_clifford_algebra"), "）。これは主張の等式である。"]),
    ],
  },
  {
    id: "isomorphism_claim_parity_factors_with_different_numbers_commute",
    kind: "claim",
    title: { text: "番号の違う符号の因子どうしは交換する" },
    labels: ["claim_parity_factors_with_different_numbers_commute"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), " の元とする。", math(String.raw`i\neq k`), " であるすべての ", math(String.raw`i,k\in\{1,\dots,M\}`), " について ", math(String.raw`\chi_k\cdot_A\chi_i=\chi_i\cdot_A\chi_k`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`C_{\chi_k}`), " を ", ref("claim_elements_commuting_with_fixed_element_form_subalgebra"), " の部分代数とする。", ref("claim_generators_commute_with_parity_factor_of_other_number"), " を二つの番号を入れ替えて（", math(String.raw`i`), " と ", math(String.raw`k`), " の役を替えて）当てると、", math(String.raw`a_i\cdot_A\chi_k=\chi_k\cdot_A a_i`), " と ", math(String.raw`a^{\dagger}_i\cdot_A\chi_k=\chi_k\cdot_A a^{\dagger}_i`), " なので、", math(String.raw`a_i,a^{\dagger}_i\in C_{\chi_k}`), " である。", math(String.raw`C_{\chi_k}`), " は乗法・スカラー倍・加法で閉じているので（", ref("def_subalgebra"), "）、", math(String.raw`a_i\cdot_A a^{\dagger}_i`), "、", math(String.raw`a^{\dagger}_i\cdot_A a_i`), "、", math(String.raw`(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)`), "、", math(String.raw`\chi_i`), " が順に ", math(String.raw`C_{\chi_k}`), " に属する（", ref("def_parity_factor_of_split_clifford_algebra"), "）。", math(String.raw`\chi_i\in C_{\chi_k}`), " は主張の等式である。"]),
    ],
  },
  {
    id: "isomorphism_claim_square_of_parity_element_is_one",
    kind: "claim",
    title: { text: "符号の因子の番号順の積の平方は 1 である" },
    labels: ["claim_square_of_parity_element_is_one"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。", math(String.raw`\varepsilon\cdot_A\varepsilon=1_A`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`\Pi_m`), "（", math(String.raw`m\in\{0,1,\dots,M\}`), "）を、族 ", math(String.raw`\chi_1,\dots,\chi_M`), "（", ref("def_parity_factor_of_split_clifford_algebra"), "）について ", ref("def_ordered_product_in_algebra"), " で帰納的に定めた部分積とする（", math(String.raw`\Pi_0=1_A`), "、", math(String.raw`\Pi_m=\Pi_{m-1}\cdot_A\chi_m`), "）。すべての ", math(String.raw`m`), " について ", math(String.raw`\Pi_m\cdot_A\Pi_m=1_A`), " を ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=0`), " のとき ", math(String.raw`\Pi_0\cdot_A\Pi_0=1_A\cdot_A 1_A=1_A`), " である（", ref("def_ordered_product_in_algebra"), "、", ref("def_unital_ring"), " の乗法の単位元）。"]),
      paragraph([math(String.raw`1\le m\le M`), " とし、", math(String.raw`\Pi_{m-1}\cdot_A\Pi_{m-1}=1_A`), " を仮定する（帰納法の仮定）。", math(String.raw`\Pi_{m-1}`), " は族を ", math(String.raw`\{1,\dots,m-1\}`), " に制限した番号順の積 ", math(String.raw`\prod_{A,\,i=1}^{m-1}\chi_i`), " に等しく（", ref("claim_partial_product_is_ordered_product_of_restricted_family"), "）、", math(String.raw`i\le m-1`), " なら ", math(String.raw`i\neq m`), " なので ", math(String.raw`\chi_m\cdot_A\chi_i=\chi_i\cdot_A\chi_m`), " である（", ref("claim_parity_factors_with_different_numbers_commute"), "）。したがって ", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " により ", math(String.raw`\chi_m\cdot_A\Pi_{m-1}=\Pi_{m-1}\cdot_A\chi_m`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\Pi_m\cdot_A\Pi_m
&=(\Pi_{m-1}\cdot_A\chi_m)\cdot_A(\Pi_{m-1}\cdot_A\chi_m)
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi_{m-1}\cdot_A\bigl(\chi_m\cdot_A(\Pi_{m-1}\cdot_A\chi_m)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Pi_{m-1}\cdot_A\bigl((\chi_m\cdot_A\Pi_{m-1})\cdot_A\chi_m\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Pi_{m-1}\cdot_A\bigl((\Pi_{m-1}\cdot_A\chi_m)\cdot_A\chi_m\bigr)
&&\left(\because\ \chi_m\cdot_A\Pi_{m-1}=\Pi_{m-1}\cdot_A\chi_m\right)\\
&=\Pi_{m-1}\cdot_A\bigl(\Pi_{m-1}\cdot_A(\chi_m\cdot_A\chi_m)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\Pi_{m-1}\cdot_A(\Pi_{m-1}\cdot_A 1_A)
&&\left(\because\ \blkref{claim_square_of_parity_factor_is_one}\right)\\
&=\Pi_{m-1}\cdot_A\Pi_{m-1}
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_A
&&\left(\because\ \text{帰納法の仮定}\right).
\end{aligned}`),
      paragraph([math(String.raw`m=M`), " のとき ", math(String.raw`\Pi_M=\varepsilon`), " なので（", ref("def_ordered_product_in_algebra"), "、", ref("def_parity_element_of_split_clifford_algebra"), "）、", math(String.raw`\varepsilon\cdot_A\varepsilon=1_A`), " である。"]),
    ],
  },
  {
    id: "isomorphism_claim_generators_anticommute_with_parity_element",
    kind: "claim",
    title: { text: "生成・消滅作用素にあたる元は、符号の因子の番号順の積と反交換する" },
    labels: ["claim_generators_anticommute_with_parity_element"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), " の元とする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。すべての ", math(String.raw`k\in\{1,\dots,M\}`), " と、", math(String.raw`y=a_k`), " と ", math(String.raw`y=a^{\dagger}_k`), " のそれぞれについて次が成り立つ。"]),
      displayMath(String.raw`y\cdot_A\varepsilon=(-1_{\mathbb{C}})\ast_A(\varepsilon\cdot_A y)`),
    ],
    proof: [
      paragraph([math(String.raw`A`), " の元 ", math(String.raw`L`), " と ", math(String.raw`R`), " を、", math(String.raw`A`), " の中の番号順の積（", ref("def_ordered_product_in_algebra"), "）で ", math(String.raw`L:=\prod_{A,\,s=1}^{k-1}\chi_s`), "、", math(String.raw`R:=\prod_{A,\,r=1}^{M-k}\chi_{k+r}`), " と置く。", ref("claim_ordered_product_in_algebra_with_one_factor_singled_out"), " を ", math(String.raw`n:=M`), "、", math(String.raw`p:=k`), " に当てると ", math(String.raw`\varepsilon=L\cdot_A(\chi_k\cdot_A R)`), " である（", ref("def_parity_element_of_split_clifford_algebra"), "）。", math(String.raw`L`), " の因子 ", math(String.raw`\chi_s`), " は ", math(String.raw`s\neq k`), "、", math(String.raw`R`), " の因子 ", math(String.raw`\chi_{k+r}`), " は ", math(String.raw`k+r\neq k`), " を満たすので、", math(String.raw`y`), " はそのどれとも交換する（", ref("claim_generators_commute_with_parity_factor_of_other_number"), "）。したがって ", math(String.raw`y\cdot_A L=L\cdot_A y`), "、", math(String.raw`y\cdot_A R=R\cdot_A y`), " である（", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), "）。また ", math(String.raw`y\cdot_A\chi_k=(-1_{\mathbb{C}})\ast_A(\chi_k\cdot_A y)`), " である（", math(String.raw`y=a_k`), " なら ", ref("claim_annihilation_generator_anticommutes_with_parity_factor"), "、", math(String.raw`y=a^{\dagger}_k`), " なら ", ref("claim_creation_generator_anticommutes_with_parity_factor"), "）。"]),
      displayMath(String.raw`\begin{aligned}
y\cdot_A\varepsilon
&=y\cdot_A\bigl(L\cdot_A(\chi_k\cdot_A R)\bigr)
&&\left(\because\ \blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right)\\
&=(y\cdot_A L)\cdot_A(\chi_k\cdot_A R)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(L\cdot_A y)\cdot_A(\chi_k\cdot_A R)
&&\left(\because\ y\cdot_A L=L\cdot_A y\right)\\
&=L\cdot_A\bigl(y\cdot_A(\chi_k\cdot_A R)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\bigl((y\cdot_A\chi_k)\cdot_A R\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=L\cdot_A\Bigl(\bigl((-1_{\mathbb{C}})\ast_A(\chi_k\cdot_A y)\bigr)\cdot_A R\Bigr)
&&\left(\because\ y\cdot_A\chi_k=(-1_{\mathbb{C}})\ast_A(\chi_k\cdot_A y)\right)\\
&=L\cdot_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl((\chi_k\cdot_A y)\cdot_A R\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(L\cdot_A\bigl((\chi_k\cdot_A y)\cdot_A R\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(L\cdot_A\bigl(\chi_k\cdot_A(y\cdot_A R)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(L\cdot_A\bigl(\chi_k\cdot_A(R\cdot_A y)\bigr)\Bigr)
&&\left(\because\ y\cdot_A R=R\cdot_A y\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(L\cdot_A\bigl((\chi_k\cdot_A R)\cdot_A y\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(\bigl(L\cdot_A(\chi_k\cdot_A R)\bigr)\cdot_A y\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_A(\varepsilon\cdot_A y)
&&\left(\because\ \blkref{claim_ordered_product_in_algebra_with_one_factor_singled_out}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_image_of_split_space_anticommutes_with_parity_element",
    kind: "claim",
    title: { text: "分裂した二次空間の元の像は、符号の因子の番号順の積と反交換する" },
    labels: ["claim_image_of_split_space_anticommutes_with_parity_element"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。すべての ", math(String.raw`v\in V`), " について次が成り立つ。"]),
      displayMath(String.raw`\gamma(v)\cdot_A\varepsilon+_A\varepsilon\cdot_A\gamma(v)=0_A`),
    ],
    proof: [
      paragraph(["準備として、", math(String.raw`k\in\{1,\dots,M\}`), " と ", math(String.raw`y\in\{a_k,a^{\dagger}_k\}`), " について ", math(String.raw`y\cdot_A\varepsilon+_A\varepsilon\cdot_A y=0_A`), " を示す。"]),
      displayMath(String.raw`\begin{aligned}
y\cdot_A\varepsilon+_A\varepsilon\cdot_A y
&=(-1_{\mathbb{C}})\ast_A(\varepsilon\cdot_A y)+_A\varepsilon\cdot_A y
&&\left(\because\ \blkref{claim_generators_anticommute_with_parity_element}\right)\\
&=(-1_{\mathbb{C}})\ast_A(\varepsilon\cdot_A y)+_A 1_{\mathbb{C}}\ast_A(\varepsilon\cdot_A y)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)\ast_A(\varepsilon\cdot_A y)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\ast_A(\varepsilon\cdot_A y)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph([math(String.raw`V`), " の元は順序対なので ", math(String.raw`v=(x,\xi)`), "（", math(String.raw`x\in W`), "、", math(String.raw`\xi\in W^{*}`), "）と書く。", math(String.raw`\beta^{w}_k`), " を ", math(String.raw`w`), " についての第 ", math(String.raw`k`), " 座標の写像（", ref("claim_coordinate_map_is_linear_form"), "）とし、", math(String.raw`U_{\mathrm{vec}}(A)`), " の中の線型結合（", ref("def_linear_combination"), "）で ", math(String.raw`R_1:=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A a^{\dagger}_k`), "、", math(String.raw`R_2:=\sum_{k=1}^{M}\xi(w_k)\ast_A a_k`), " と置く。", math(String.raw`\gamma(v)=R_1+_A R_2`), " である（", ref("claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators"), "）。"]),
      displayMath(String.raw`\begin{aligned}
R_1\cdot_A\varepsilon+_A\varepsilon\cdot_A R_1
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A\bigl(a^{\dagger}_k\cdot_A\varepsilon+_A\varepsilon\cdot_A a^{\dagger}_k\bigr)
&&\left(\because\ a:=\varepsilon\ \text{とした}\text{。}\blkref{claim_anticommutator_with_linear_combination_in_algebra}\right)\\
&=\sum_{k=1}^{M}\beta^{w}_k(x)\ast_A 0_A
&&\left(\because\ \text{準備の等式を各項に}\right)\\
&=0_A
&&\left(\because\ \text{各項は}\ \beta^{w}_k(x)\ast_A 0_A=0_A\text{。}\blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\text{。}\blkref{claim_linear_combination_of_zero_terms_is_zero}\right).
\end{aligned}`),
      paragraph(["同じ式変形を ", math(String.raw`R_2`), " について行うと（係数を ", math(String.raw`\xi(w_k)`), "、項を ", math(String.raw`a_k`), " に替える）、", math(String.raw`R_2\cdot_A\varepsilon+_A\varepsilon\cdot_A R_2=0_A`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\gamma(v)\cdot_A\varepsilon+_A\varepsilon\cdot_A\gamma(v)
&=(R_1+_A R_2)\cdot_A\varepsilon+_A\varepsilon\cdot_A(R_1+_A R_2)
&&\left(\because\ \blkref{claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators}\right)\\
&=(R_1\cdot_A\varepsilon+_A R_2\cdot_A\varepsilon)+_A(\varepsilon\cdot_A R_1+_A\varepsilon\cdot_A R_2)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=(R_1\cdot_A\varepsilon+_A\varepsilon\cdot_A R_1)+_A(R_2\cdot_A\varepsilon+_A\varepsilon\cdot_A R_2)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{に当てる}\text{。}\blkref{claim_rearranging_sum_of_two_sums_in_vector_space}\right)\\
&=0_A+_A 0_A
&&\left(\because\ \text{上の二つの等式}\right)\\
&=0_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_added_generator_commutes_with_image_of_parity_factor",
    kind: "claim",
    title: { text: "足した次元の単位の元の像は、符号の因子の像と交換する" },
    labels: ["claim_added_generator_commutes_with_image_of_parity_factor"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), "、", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。すべての ", math(String.raw`i\in\{1,\dots,M\}`), " について ", math(String.raw`g\cdot_{A'}j(\chi_i)=j(\chi_i)\cdot_{A'}g`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`a_i=\gamma(\mathrm{in}_2(f_i))`), "、", math(String.raw`a^{\dagger}_i=\gamma(\mathrm{in}_1(w_i))`), " なので（", ref("def_annihilation_generator_of_split_clifford_algebra"), "、", ref("def_creation_generator_of_split_clifford_algebra"), "）、", ref("claim_added_generator_anticommutes_with_image_of_split_space"), " を ", math(String.raw`v:=\mathrm{in}_2(f_i)`), " と ", math(String.raw`v:=\mathrm{in}_1(w_i)`), " に当てると、", math(String.raw`g\cdot_{A'}j(a_i)+_{A'}j(a_i)\cdot_{A'}g=0_{A'}`), " と ", math(String.raw`g\cdot_{A'}j(a^{\dagger}_i)+_{A'}j(a^{\dagger}_i)\cdot_{A'}g=0_{A'}`), " である。", math(String.raw`A'`), " で ", ref("claim_element_anticommuting_with_two_elements_commutes_with_their_product"), " を ", math(String.raw`y:=g`), "、", math(String.raw`(p,r):=(j(a_i),j(a^{\dagger}_i))`), " と ", math(String.raw`(p,r):=(j(a^{\dagger}_i),j(a_i))`), " に当てると、", math(String.raw`j(a_i)\cdot_{A'}j(a^{\dagger}_i)`), " と ", math(String.raw`j(a^{\dagger}_i)\cdot_{A'}j(a_i)`), " は ", math(String.raw`A'`), " の部分代数 ", math(String.raw`C_g`), "（", ref("claim_elements_commuting_with_fixed_element_form_subalgebra"), "）に属する。", math(String.raw`j`), " は ℂ-代数の準同型なので（", ref("def_setting_of_odd_dimensional_corollary"), "）、次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
j(\chi_i)
&=j\bigl(a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ \blkref{def_parity_factor_of_split_clifford_algebra}\right)\\
&=j(a_i\cdot_A a^{\dagger}_i)+_{A'}j\bigl((-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i)\bigr)
&&\left(\because\ j\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=j(a_i\cdot_A a^{\dagger}_i)+_{A'}(-1_{\mathbb{C}})\ast_{A'}j(a^{\dagger}_i\cdot_A a_i)
&&\left(\because\ j\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=j(a_i)\cdot_{A'}j(a^{\dagger}_i)+_{A'}(-1_{\mathbb{C}})\ast_{A'}\bigl(j(a^{\dagger}_i)\cdot_{A'}j(a_i)\bigr)
&&\left(\because\ j\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
\end{aligned}`),
      paragraph([math(String.raw`C_g`), " はスカラー倍と加法で閉じているので（", ref("def_subalgebra"), "）、右辺は ", math(String.raw`C_g`), " に属する。したがって ", math(String.raw`j(\chi_i)\in C_g`), " であり、これは主張の等式である。"]),
    ],
  },
  {
    id: "isomorphism_claim_added_generator_commutes_with_image_of_parity_element",
    kind: "claim",
    title: { text: "足した次元の単位の元の像は、符号の因子の番号順の積の像と交換する" },
    labels: ["claim_added_generator_commutes_with_image_of_parity_element"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), "、", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。", math(String.raw`g\cdot_{A'}j(\varepsilon)=j(\varepsilon)\cdot_{A'}g`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`j`), " は ℂ-代数の準同型なので、", math(String.raw`j(\varepsilon)=\prod_{A',\,i=1}^{M}j(\chi_i)`), " である（", ref("def_parity_element_of_split_clifford_algebra"), "、", ref("claim_algebra_homomorphism_maps_ordered_product_to_ordered_product"), "）。", math(String.raw`g`), " は各因子 ", math(String.raw`j(\chi_i)`), " と交換するので（", ref("claim_added_generator_commutes_with_image_of_parity_factor"), "）、", ref("claim_element_commuting_with_each_factor_commutes_with_ordered_product"), " を ", math(String.raw`u:=g`), " に当てて ", math(String.raw`g\cdot_{A'}j(\varepsilon)=j(\varepsilon)\cdot_{A'}g`), " を得る。"]),
    ],
  },
  {
    id: "isomorphism_definition_central_element_of_odd_dimensional_clifford_algebra",
    kind: "definition",
    title: { text: "奇数次元のクリフォード代数の中心の元" },
    labels: ["def_central_element_of_odd_dimensional_clifford_algebra"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), "、", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。", math(String.raw`A'`), " の元 ", math(String.raw`z`), " を次で定める。"]),
      displayMath(String.raw`z:=j(\varepsilon)\cdot_{A'}g`),
    ],
  },
  {
    id: "isomorphism_claim_square_of_central_element_is_one",
    kind: "claim",
    title: { text: "中心の元の平方は 1 である" },
    labels: ["claim_square_of_central_element_is_one"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), "、", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), " の元とする。", math(String.raw`z\cdot_{A'}z=1_{A'}`), " である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
z\cdot_{A'}z
&=\bigl(j(\varepsilon)\cdot_{A'}g\bigr)\cdot_{A'}\bigl(j(\varepsilon)\cdot_{A'}g\bigr)
&&\left(\because\ \blkref{def_central_element_of_odd_dimensional_clifford_algebra}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl(g\cdot_{A'}(j(\varepsilon)\cdot_{A'}g)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl((g\cdot_{A'}j(\varepsilon))\cdot_{A'}g\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl((j(\varepsilon)\cdot_{A'}g)\cdot_{A'}g\bigr)
&&\left(\because\ \blkref{claim_added_generator_commutes_with_image_of_parity_element}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl(j(\varepsilon)\cdot_{A'}(g\cdot_{A'}g)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl(j(\varepsilon)\cdot_{A'}1_{A'}\bigr)
&&\left(\because\ \blkref{claim_square_of_added_generator_is_one}\right)\\
&=j(\varepsilon)\cdot_{A'}j(\varepsilon)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=j(\varepsilon\cdot_A\varepsilon)
&&\left(\because\ j\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=j(1_A)
&&\left(\because\ \blkref{claim_square_of_parity_element_is_one}\right)\\
&=1_{A'}
&&\left(\because\ j\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_central_element_commutes_with_image_of_split_space",
    kind: "claim",
    title: { text: "中心の元は、分裂した二次空間の元の像と交換する" },
    labels: ["claim_central_element_commutes_with_image_of_split_space"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), "、", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), " の元とする。すべての ", math(String.raw`v\in V`), " について ", math(String.raw`z\cdot_{A'}j(\gamma(v))=j(\gamma(v))\cdot_{A'}z`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`y:=\gamma(v)\in A`), " と置く。", ref("claim_added_generator_anticommutes_with_image_of_split_space"), " に ", ref("claim_anticommuting_elements_swap_with_sign"), " を当てると ", math(String.raw`g\cdot_{A'}j(y)=(-1_{\mathbb{C}})\ast_{A'}(j(y)\cdot_{A'}g)`), " である。", ref("claim_image_of_split_space_anticommutes_with_parity_element"), " の等式の左辺の二項を加法の交換法則で入れ替えて ", ref("claim_anticommuting_elements_swap_with_sign"), " を当てると ", math(String.raw`\varepsilon\cdot_A y=(-1_{\mathbb{C}})\ast_A(y\cdot_A\varepsilon)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
z\cdot_{A'}j(y)
&=\bigl(j(\varepsilon)\cdot_{A'}g\bigr)\cdot_{A'}j(y)
&&\left(\because\ \blkref{def_central_element_of_odd_dimensional_clifford_algebra}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl(g\cdot_{A'}j(y)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl((-1_{\mathbb{C}})\ast_{A'}(j(y)\cdot_{A'}g)\bigr)
&&\left(\because\ g\cdot_{A^{\prime}}j(y)=(-1_{\mathbb{C}})\ast_{A^{\prime}}(j(y)\cdot_{A^{\prime}}g)\right)\\
&=(-1_{\mathbb{C}})\ast_{A'}\bigl(j(\varepsilon)\cdot_{A'}(j(y)\cdot_{A'}g)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=(-1_{\mathbb{C}})\ast_{A'}\bigl((j(\varepsilon)\cdot_{A'}j(y))\cdot_{A'}g\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(-1_{\mathbb{C}})\ast_{A'}\bigl(j(\varepsilon\cdot_A y)\cdot_{A'}g\bigr)
&&\left(\because\ j\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=(-1_{\mathbb{C}})\ast_{A'}\Bigl(j\bigl((-1_{\mathbb{C}})\ast_A(y\cdot_A\varepsilon)\bigr)\cdot_{A'}g\Bigr)
&&\left(\because\ \varepsilon\cdot_A y=(-1_{\mathbb{C}})\ast_A(y\cdot_A\varepsilon)\right)\\
&=(-1_{\mathbb{C}})\ast_{A'}\Bigl(\bigl((-1_{\mathbb{C}})\ast_{A'}j(y\cdot_A\varepsilon)\bigr)\cdot_{A'}g\Bigr)
&&\left(\because\ j\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=(-1_{\mathbb{C}})\ast_{A'}\Bigl((-1_{\mathbb{C}})\ast_{A'}\bigl(j(y\cdot_A\varepsilon)\cdot_{A'}g\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_{A'}\bigl(j(y\cdot_A\varepsilon)\cdot_{A'}g\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_{A'}\bigl(j(y\cdot_A\varepsilon)\cdot_{A'}g\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=j(y\cdot_A\varepsilon)\cdot_{A'}g
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(j(y)\cdot_{A'}j(\varepsilon)\bigr)\cdot_{A'}g
&&\left(\because\ j\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=j(y)\cdot_{A'}\bigl(j(\varepsilon)\cdot_{A'}g\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=j(y)\cdot_{A'}z
&&\left(\because\ \blkref{def_central_element_of_odd_dimensional_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_central_element_commutes_with_added_generator",
    kind: "claim",
    title: { text: "中心の元は、足した次元の単位の元の像と交換する" },
    labels: ["claim_central_element_commutes_with_added_generator"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), "、", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), " の元とする。", math(String.raw`g\cdot_{A'}z=z\cdot_{A'}g`), " である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
g\cdot_{A'}z
&=g\cdot_{A'}\bigl(j(\varepsilon)\cdot_{A'}g\bigr)
&&\left(\because\ \blkref{def_central_element_of_odd_dimensional_clifford_algebra}\right)\\
&=\bigl(g\cdot_{A'}j(\varepsilon)\bigr)\cdot_{A'}g
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(j(\varepsilon)\cdot_{A'}g\bigr)\cdot_{A'}g
&&\left(\because\ \blkref{claim_added_generator_commutes_with_image_of_parity_element}\right)\\
&=z\cdot_{A'}g
&&\left(\because\ \blkref{def_central_element_of_odd_dimensional_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_image_of_odd_extension_element_is_sum_of_images",
    kind: "claim",
    title: { text: "一つの次元を足した空間の元の像は、第一成分の像と足した次元の単位の元の像の倍の和である" },
    labels: ["claim_image_of_odd_extension_element_is_sum_of_images"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。すべての ", math(String.raw`v\in V`), " と ", math(String.raw`t\in\mathbb{C}`), " について次が成り立つ。"]),
      displayMath(String.raw`\gamma'\bigl((v,t)\bigr)=j\bigl(\gamma(v)\bigr)+_{A'}t\ast_{A'}g`),
    ],
    proof: [
      paragraph([math(String.raw`\gamma'`), " は ", math(String.raw`V'`), " から ", math(String.raw`U_{\mathrm{vec}}(A')`), " への線型写像（", ref("claim_clifford_generator_map_is_linear_map"), "）、", math(String.raw`\mathrm{in}'_2`), " は線型写像である（", ref("claim_embedding_into_second_component_is_linear_map"), "）。"]),
      displayMath(String.raw`\begin{aligned}
\gamma'\bigl((v,t)\bigr)
&=\gamma'\bigl(\mathrm{in}'_1(v)+_{V'}\mathrm{in}'_2(t)\bigr)
&&\left(\because\ \blkref{claim_direct_sum_element_is_sum_of_embedded_components}\right)\\
&=\gamma'\bigl(\mathrm{in}'_1(v)+_{V'}\mathrm{in}'_2(t\cdot_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\gamma'\bigl(\mathrm{in}'_1(v)+_{V'}\mathrm{in}'_2(t\cdot_{\mathbb{C}^{\mathrm{vec}}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義}\text{。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\gamma'\bigl(\mathrm{in}'_1(v)+_{V'}t\cdot_{V'}\mathrm{in}'_2(1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathrm{in}'_2\ \text{はスカラー倍を保つ}\text{。}\blkref{claim_embedding_into_second_component_is_linear_map}\right)\\
&=\gamma'\bigl(\mathrm{in}'_1(v)+_{V'}t\cdot_{V'}u\bigr)
&&\left(\because\ u\ \text{の定義}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=\gamma'\bigl(\mathrm{in}'_1(v)\bigr)+_{A'}\gamma'(t\cdot_{V'}u)
&&\left(\because\ \gamma'\ \text{は加法を保つ}\text{。}\blkref{claim_clifford_generator_map_is_linear_map}\right)\\
&=\gamma'\bigl(\mathrm{in}'_1(v)\bigr)+_{A'}t\ast_{A'}\gamma'(u)
&&\left(\because\ \gamma'\ \text{はスカラー倍を保つ}\text{。}\blkref{claim_clifford_generator_map_is_linear_map}\right)\\
&=j\bigl(\gamma(v)\bigr)+_{A'}t\ast_{A'}\gamma'(u)
&&\left(\because\ j\circ\gamma=\gamma'\circ\mathrm{in}'_1\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=j\bigl(\gamma(v)\bigr)+_{A'}t\ast_{A'}g
&&\left(\because\ g\ \text{の定義}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_central_element_commutes_with_every_element",
    kind: "claim",
    title: { text: "中心の元は、奇数次元のクリフォード代数のすべての元と交換する" },
    labels: ["claim_central_element_commutes_with_every_element"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\chi_i`), " を ", ref("def_parity_factor_of_split_clifford_algebra"), "、", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元とする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), " の元とする。すべての ", math(String.raw`a\in A'`), " について ", math(String.raw`z\cdot_{A'}a=a\cdot_{A'}z`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`x\in V'`), " を任意に取る。", math(String.raw`V'`), " の元は順序対なので ", math(String.raw`x=(v,t)`), "（", math(String.raw`v\in V`), "、", math(String.raw`t\in\mathbb{C}`), "）と書く。"]),
      displayMath(String.raw`\begin{aligned}
z\cdot_{A'}\gamma'(x)
&=z\cdot_{A'}\bigl(j(\gamma(v))+_{A'}t\ast_{A'}g\bigr)
&&\left(\because\ \blkref{claim_image_of_odd_extension_element_is_sum_of_images}\right)\\
&=z\cdot_{A'}j(\gamma(v))+_{A'}z\cdot_{A'}(t\ast_{A'}g)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=z\cdot_{A'}j(\gamma(v))+_{A'}t\ast_{A'}(z\cdot_{A'}g)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=j(\gamma(v))\cdot_{A'}z+_{A'}t\ast_{A'}(z\cdot_{A'}g)
&&\left(\because\ \blkref{claim_central_element_commutes_with_image_of_split_space}\right)\\
&=j(\gamma(v))\cdot_{A'}z+_{A'}t\ast_{A'}(g\cdot_{A'}z)
&&\left(\because\ \blkref{claim_central_element_commutes_with_added_generator}\right)\\
&=j(\gamma(v))\cdot_{A'}z+_{A'}(t\ast_{A'}g)\cdot_{A'}z
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(j(\gamma(v))+_{A'}t\ast_{A'}g\bigr)\cdot_{A'}z
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\gamma'(x)\cdot_{A'}z
&&\left(\because\ \blkref{claim_image_of_odd_extension_element_is_sum_of_images}\right).
\end{aligned}`),
      paragraph([math(String.raw`\gamma'(V')`), " は ", math(String.raw`A'`), " を生成するので（", ref("claim_image_of_clifford_generator_map_generates_clifford_algebra"), "）、", ref("claim_element_commuting_with_generating_subset_commutes_with_every_element"), " を ", math(String.raw`X:=\gamma'(V')`), "、", math(String.raw`y:=z`), " に当てて主張を得る。"]),
    ],
  },
  {
    id: "isomorphism_definition_product_of_two_complex_algebras",
    kind: "definition",
    title: { text: "二つの ℂ-代数の直積" },
    labels: ["def_product_of_two_complex_algebras"],
    statement: [
      paragraph([math(String.raw`(A_1,+_{A_1},\cdot_{A_1},\ast_{A_1},0_{A_1},1_{A_1})`), " と ", math(String.raw`(A_2,+_{A_2},\cdot_{A_2},\ast_{A_2},0_{A_2},1_{A_2})`), " を ℂ-代数（", ref("def_complex_algebra"), "）とする。", math(String.raw`A_1`), " の元 ", math(String.raw`x_1`), " と ", math(String.raw`A_2`), " の元 ", math(String.raw`x_2`), " の順序対 ", math(String.raw`(x_1,x_2)`), " 全体の集合を ", math(String.raw`A_1\times A_2`), " と書く。写像 ", math(String.raw`+_{A_1\times A_2}`), "、", math(String.raw`\cdot_{A_1\times A_2}`), "、", math(String.raw`\ast_{A_1\times A_2}`), " と元 ", math(String.raw`0_{A_1\times A_2}`), "、", math(String.raw`1_{A_1\times A_2}`), " を次で定める。以下、", math(String.raw`x_1,y_1\in A_1`), "、", math(String.raw`x_2,y_2\in A_2`), "、", math(String.raw`\lambda\in\mathbb{C}`), " である。"]),
      list([[math(String.raw`(x_1,x_2)+_{A_1\times A_2}(y_1,y_2):=(x_1+_{A_1}y_1,\ x_2+_{A_2}y_2)`)], [math(String.raw`(x_1,x_2)\cdot_{A_1\times A_2}(y_1,y_2):=(x_1\cdot_{A_1}y_1,\ x_2\cdot_{A_2}y_2)`)], [math(String.raw`\lambda\ast_{A_1\times A_2}(x_1,x_2):=(\lambda\ast_{A_1}x_1,\ \lambda\ast_{A_2}x_2)`)], [math(String.raw`0_{A_1\times A_2}:=(0_{A_1},0_{A_2})`), "、", math(String.raw`1_{A_1\times A_2}:=(1_{A_1},1_{A_2})`)]]),
      paragraph(["右辺の順序対の第一成分は ", math(String.raw`A_1`), " の元、第二成分は ", math(String.raw`A_2`), " の元なので、各写像の値と二つの元は ", math(String.raw`A_1\times A_2`), " に入る。組 ", math(String.raw`(A_1\times A_2,+_{A_1\times A_2},\cdot_{A_1\times A_2},\ast_{A_1\times A_2},0_{A_1\times A_2},1_{A_1\times A_2})`), " を ", math(String.raw`A_1`), " と ", math(String.raw`A_2`), " の直積と呼ぶ。二つの元が等しいとは、第一成分どうしと第二成分どうしがそれぞれ等しいことである。"]),
    ],
  },
  {
    id: "isomorphism_claim_product_of_two_complex_algebras_is_complex_algebra",
    kind: "claim",
    title: { text: "二つの ℂ-代数の直積は ℂ-代数である" },
    labels: ["claim_product_of_two_complex_algebras_is_complex_algebra"],
    statement: [
      paragraph([math(String.raw`A_1`), "、", math(String.raw`A_2`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`A_1\times A_2`), " をその直積（", ref("def_product_of_two_complex_algebras"), "）とする。", math(String.raw`A_1\times A_2`), " は ℂ-代数である。"]),
    ],
    proof: [
      paragraph([math(String.raw`A_1\times A_2`), " の任意の三元を ", math(String.raw`(x_1,x_2)`), "、", math(String.raw`(y_1,y_2)`), "、", math(String.raw`(z_1,z_2)`), "（", math(String.raw`x_1,y_1,z_1\in A_1`), "、", math(String.raw`x_2,y_2,z_2\in A_2`), "）、ℂ の任意の元を ", math(String.raw`\lambda`), " と書く。「各成分に適用」と書いた行は、第一成分に ", math(String.raw`A_1`), " の、第二成分に ", math(String.raw`A_2`), " の同じ名前の法則を当てる行である。"]),
      paragraph(["線型空間の条件。", math(String.raw`U_{\mathrm{vec}}(A_1)`), " と ", math(String.raw`U_{\mathrm{vec}}(A_2)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の直和（", ref("def_direct_sum_of_two_vector_spaces"), "）は、台集合が ", math(String.raw`A_1\times A_2`), " で、加法・スカラー倍・零元が ", math(String.raw`+_{A_1\times A_2}`), "・", math(String.raw`\ast_{A_1\times A_2}`), "・", math(String.raw`0_{A_1\times A_2}`), " と同じ式で定まる組である。したがって組 ", math(String.raw`(A_1\times A_2,+_{A_1\times A_2},\ast_{A_1\times A_2},0_{A_1\times A_2})`), " はこの直和そのものであり、ℂ-線型空間である（", ref("claim_direct_sum_of_two_vector_spaces_is_complex_vector_space"), "）。"]),
      paragraph(["環の条件（", ref("def_unital_ring"), "）のうち、加法の結合法則・交換法則・単位元・逆元の四つは、ℂ-線型空間の条件（", ref("def_complex_vector_space"), "）の最初の四つと同じ式なので、上で満たされている。乗法の結合法則は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((x_1,x_2)\cdot_{A_1\times A_2}(y_1,y_2)\bigr)\cdot_{A_1\times A_2}(z_1,z_2)
&=(x_1\cdot_{A_1}y_1,\ x_2\cdot_{A_2}y_2)\cdot_{A_1\times A_2}(z_1,z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=((x_1\cdot_{A_1}y_1)\cdot_{A_1}z_1,\ (x_2\cdot_{A_2}y_2)\cdot_{A_2}z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1\cdot_{A_1}(y_1\cdot_{A_1}z_1),\ x_2\cdot_{A_2}(y_2\cdot_{A_2}z_2))
&&\left(\because\ \text{乗法の結合法則を各成分に適用。}\blkref{def_unital_ring}\right)\\
&=(x_1,x_2)\cdot_{A_1\times A_2}(y_1\cdot_{A_1}z_1,\ y_2\cdot_{A_2}z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1,x_2)\cdot_{A_1\times A_2}\bigl((y_1,y_2)\cdot_{A_1\times A_2}(z_1,z_2)\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right).
\end{aligned}`),
      paragraph(["乗法の単位元は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(x_1,x_2)\cdot_{A_1\times A_2}1_{A_1\times A_2}
&=(x_1,x_2)\cdot_{A_1\times A_2}(1_{A_1},1_{A_2})
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1\cdot_{A_1}1_{A_1},\ x_2\cdot_{A_2}1_{A_2})
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1,x_2)
&&\left(\because\ \text{乗法の単位元を各成分に適用。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
1_{A_1\times A_2}\cdot_{A_1\times A_2}(x_1,x_2)
&=(1_{A_1},1_{A_2})\cdot_{A_1\times A_2}(x_1,x_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(1_{A_1}\cdot_{A_1}x_1,\ 1_{A_2}\cdot_{A_2}x_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1,x_2)
&&\left(\because\ \text{乗法の単位元を各成分に適用。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph(["分配法則は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(x_1,x_2)\cdot_{A_1\times A_2}\bigl((y_1,y_2)+_{A_1\times A_2}(z_1,z_2)\bigr)
&=(x_1,x_2)\cdot_{A_1\times A_2}(y_1+_{A_1}z_1,\ y_2+_{A_2}z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1\cdot_{A_1}(y_1+_{A_1}z_1),\ x_2\cdot_{A_2}(y_2+_{A_2}z_2))
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1\cdot_{A_1}y_1+_{A_1}x_1\cdot_{A_1}z_1,\ x_2\cdot_{A_2}y_2+_{A_2}x_2\cdot_{A_2}z_2)
&&\left(\because\ \text{分配法則を各成分に適用。}\blkref{def_unital_ring}\right)\\
&=(x_1\cdot_{A_1}y_1,\ x_2\cdot_{A_2}y_2)+_{A_1\times A_2}(x_1\cdot_{A_1}z_1,\ x_2\cdot_{A_2}z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1,x_2)\cdot_{A_1\times A_2}(y_1,y_2)+_{A_1\times A_2}(x_1,x_2)\cdot_{A_1\times A_2}(z_1,z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl((x_1,x_2)+_{A_1\times A_2}(y_1,y_2)\bigr)\cdot_{A_1\times A_2}(z_1,z_2)
&=(x_1+_{A_1}y_1,\ x_2+_{A_2}y_2)\cdot_{A_1\times A_2}(z_1,z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=((x_1+_{A_1}y_1)\cdot_{A_1}z_1,\ (x_2+_{A_2}y_2)\cdot_{A_2}z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1\cdot_{A_1}z_1+_{A_1}y_1\cdot_{A_1}z_1,\ x_2\cdot_{A_2}z_2+_{A_2}y_2\cdot_{A_2}z_2)
&&\left(\because\ \text{分配法則を各成分に適用。}\blkref{def_unital_ring}\right)\\
&=(x_1\cdot_{A_1}z_1,\ x_2\cdot_{A_2}z_2)+_{A_1\times A_2}(y_1\cdot_{A_1}z_1,\ y_2\cdot_{A_2}z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1,x_2)\cdot_{A_1\times A_2}(z_1,z_2)+_{A_1\times A_2}(y_1,y_2)\cdot_{A_1\times A_2}(z_1,z_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right).
\end{aligned}`),
      paragraph(["スカラー倍と乗法の両立は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\lambda\ast_{A_1\times A_2}\bigl((x_1,x_2)\cdot_{A_1\times A_2}(y_1,y_2)\bigr)
&=\lambda\ast_{A_1\times A_2}(x_1\cdot_{A_1}y_1,\ x_2\cdot_{A_2}y_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(\lambda\ast_{A_1}(x_1\cdot_{A_1}y_1),\ \lambda\ast_{A_2}(x_2\cdot_{A_2}y_2))
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=((\lambda\ast_{A_1}x_1)\cdot_{A_1}y_1,\ (\lambda\ast_{A_2}x_2)\cdot_{A_2}y_2)
&&\left(\because\ \text{スカラー倍と乗法の両立（左の因子）を各成分に適用。}\blkref{def_complex_algebra}\right)\\
&=(\lambda\ast_{A_1}x_1,\ \lambda\ast_{A_2}x_2)\cdot_{A_1\times A_2}(y_1,y_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\bigl(\lambda\ast_{A_1\times A_2}(x_1,x_2)\bigr)\cdot_{A_1\times A_2}(y_1,y_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\lambda\ast_{A_1\times A_2}\bigl((x_1,x_2)\cdot_{A_1\times A_2}(y_1,y_2)\bigr)
&=(\lambda\ast_{A_1}(x_1\cdot_{A_1}y_1),\ \lambda\ast_{A_2}(x_2\cdot_{A_2}y_2))
&&\left(\because\ \text{上の式変形の初めの二行}\right)\\
&=(x_1\cdot_{A_1}(\lambda\ast_{A_1}y_1),\ x_2\cdot_{A_2}(\lambda\ast_{A_2}y_2))
&&\left(\because\ \text{スカラー倍と乗法の両立（右の因子）を各成分に適用。}\blkref{def_complex_algebra}\right)\\
&=(x_1,x_2)\cdot_{A_1\times A_2}(\lambda\ast_{A_1}y_1,\ \lambda\ast_{A_2}y_2)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(x_1,x_2)\cdot_{A_1\times A_2}\bigl(\lambda\ast_{A_1\times A_2}(y_1,y_2)\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right).
\end{aligned}`),
      paragraph(["ℂ-代数の四つの条件（", ref("def_complex_algebra"), "）がすべて満たされた。"]),
    ],
  },
  {
    id: "isomorphism_claim_pair_of_algebra_homomorphisms_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "二つの準同型を並べた写像は、直積への準同型である" },
    labels: ["claim_pair_of_algebra_homomorphisms_is_algebra_homomorphism"],
    statement: [
      paragraph([math(String.raw`(C,+_C,\cdot_C,\ast_C,0_C,1_C)`), "、", math(String.raw`A_1`), "、", math(String.raw`A_2`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`\varphi_1:C\to A_1`), " と ", math(String.raw`\varphi_2:C\to A_2`), " を ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）とし、", math(String.raw`A_1\times A_2`), " を直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。写像 ", math(String.raw`\langle\varphi_1,\varphi_2\rangle:C\to A_1\times A_2`), " を ", math(String.raw`\langle\varphi_1,\varphi_2\rangle(c):=(\varphi_1(c),\varphi_2(c))`), " で定める。", math(String.raw`\langle\varphi_1,\varphi_2\rangle`), " は ℂ-代数の準同型である。"]),
    ],
    proof: [
      paragraph([math(String.raw`c,c'\in C`), "、", math(String.raw`\lambda\in\mathbb{C}`), " とする。「各成分に適用」と書いた行は、第一成分に ", math(String.raw`\varphi_1`), "、第二成分に ", math(String.raw`\varphi_2`), " の同じ名前の性質を当てる行である。"]),
      displayMath(String.raw`\begin{aligned}
\langle\varphi_1,\varphi_2\rangle(c+_C c')
&=(\varphi_1(c+_C c'),\ \varphi_2(c+_C c'))
&&\left(\because\ \langle\varphi_1,\varphi_2\rangle\ \text{の定義}\right)\\
&=(\varphi_1(c)+_{A_1}\varphi_1(c'),\ \varphi_2(c)+_{A_2}\varphi_2(c'))
&&\left(\because\ \text{加法を保つことをを各成分に適用。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\bigl(\varphi_1(c),\varphi_2(c)\bigr)+_{A_1\times A_2}\bigl(\varphi_1(c'),\varphi_2(c')\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\langle\varphi_1,\varphi_2\rangle(c)+_{A_1\times A_2}\langle\varphi_1,\varphi_2\rangle(c')
&&\left(\because\ \langle\varphi_1,\varphi_2\rangle\ \text{の定義}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\langle\varphi_1,\varphi_2\rangle(c\cdot_C c')
&=(\varphi_1(c\cdot_C c'),\ \varphi_2(c\cdot_C c'))
&&\left(\because\ \langle\varphi_1,\varphi_2\rangle\ \text{の定義}\right)\\
&=(\varphi_1(c)\cdot_{A_1}\varphi_1(c'),\ \varphi_2(c)\cdot_{A_2}\varphi_2(c'))
&&\left(\because\ \text{乗法を保つことをを各成分に適用。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\bigl(\varphi_1(c),\varphi_2(c)\bigr)\cdot_{A_1\times A_2}\bigl(\varphi_1(c'),\varphi_2(c')\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\langle\varphi_1,\varphi_2\rangle(c)\cdot_{A_1\times A_2}\langle\varphi_1,\varphi_2\rangle(c')
&&\left(\because\ \langle\varphi_1,\varphi_2\rangle\ \text{の定義}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\langle\varphi_1,\varphi_2\rangle(1_C)
&=(\varphi_1(1_C),\ \varphi_2(1_C))
&&\left(\because\ \langle\varphi_1,\varphi_2\rangle\ \text{の定義}\right)\\
&=(1_{A_1},1_{A_2})
&&\left(\because\ \text{乗法の単位元を保つことをを各成分に適用。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=1_{A_1\times A_2}
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\langle\varphi_1,\varphi_2\rangle(\lambda\ast_C c)
&=(\varphi_1(\lambda\ast_C c),\ \varphi_2(\lambda\ast_C c))
&&\left(\because\ \langle\varphi_1,\varphi_2\rangle\ \text{の定義}\right)\\
&=(\lambda\ast_{A_1}\varphi_1(c),\ \lambda\ast_{A_2}\varphi_2(c))
&&\left(\because\ \text{スカラー倍を保つことをを各成分に適用。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\lambda\ast_{A_1\times A_2}\bigl(\varphi_1(c),\varphi_2(c)\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\lambda\ast_{A_1\times A_2}\langle\varphi_1,\varphi_2\rangle(c)
&&\left(\because\ \langle\varphi_1,\varphi_2\rangle\ \text{の定義}\right).
\end{aligned}`),
      paragraph(["四つの等式から、", math(String.raw`\langle\varphi_1,\varphi_2\rangle`), " は ℂ-代数の準同型である（", ref("def_complex_algebra_homomorphism"), "）。"]),
    ],
  },
  {
    id: "isomorphism_definition_map_from_odd_extension_to_pair_of_matrices",
    kind: "definition",
    title: { text: "一つの次元を足した空間から行列の組への写像" },
    labels: ["def_map_from_odd_extension_to_pair_of_matrices"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。写像 ", math(String.raw`\varphi':V'\to B\times B`), " を次で定める。"]),
      displayMath(String.raw`\varphi'\bigl((v,t)\bigr):=\Bigl(\Phi(\gamma(v))+_B t\ast_B\Phi(\varepsilon),\ \ \Phi(\gamma(v))+_B(-_{\mathbb{C}}t)\ast_B\Phi(\varepsilon)\Bigr)\qquad(v\in V,\ t\in\mathbb{C})`),
    ],
  },
  {
    id: "isomorphism_claim_map_from_odd_extension_to_pair_of_matrices_is_linear_map",
    kind: "claim",
    title: { text: "一つの次元を足した空間から行列の組への写像は線型写像である" },
    labels: ["claim_map_from_odd_extension_to_pair_of_matrices_is_linear_map"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像とする。", math(String.raw`\varphi'`), " は ", math(String.raw`V'`), " から ", math(String.raw`U_{\mathrm{vec}}(B\times B)`), " への線型写像（", ref("def_linear_map"), "）である。"]),
    ],
    proof: [
      paragraph([math(String.raw`\Xi:=\Phi\circ\gamma:V\to B`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(B)`), " への線型写像である（", ref("claim_clifford_generator_map_is_linear_map"), "、", ref("def_complex_algebra_homomorphism"), "、", ref("claim_composition_of_linear_maps_is_linear_map"), "）。", math(String.raw`\eta:=\Phi(\varepsilon)\in B`), " と置く。", math(String.raw`v,v'\in V`), "、", math(String.raw`t,t',\lambda\in\mathbb{C}`), " とする。「各成分に」と書いた行は、二つの成分に同じ法則を当てる行である。加法を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\varphi'\bigl((v,t)+_{V'}(v',t')\bigr)
&=\varphi'\bigl((v+_V v',\ t+_{\mathbb{C}}t')\bigr)
&&\left(\because\ +_{V'}\ \text{と}\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\text{、}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\Bigl(\Xi(v+_V v')+_B(t+_{\mathbb{C}}t')\ast_B\eta,\ \Xi(v+_V v')+_B\bigl(-_{\mathbb{C}}(t+_{\mathbb{C}}t')\bigr)\ast_B\eta\Bigr)
&&\left(\because\ \blkref{def_map_from_odd_extension_to_pair_of_matrices}\right)\\
&=\Bigl((\Xi(v)+_B\Xi(v'))+_B(t+_{\mathbb{C}}t')\ast_B\eta,\ (\Xi(v)+_B\Xi(v'))+_B\bigl(-_{\mathbb{C}}(t+_{\mathbb{C}}t')\bigr)\ast_B\eta\Bigr)
&&\left(\because\ \Xi\ \text{は加法を保つ。各成分に}\right)\\
&=\Bigl((\Xi(v)+_B\Xi(v'))+_B(t+_{\mathbb{C}}t')\ast_B\eta,\ (\Xi(v)+_B\Xi(v'))+_B\bigl((-_{\mathbb{C}}t)+_{\mathbb{C}}(-_{\mathbb{C}}t')\bigr)\ast_B\eta\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\Bigl((\Xi(v)+_B\Xi(v'))+_B(t\ast_B\eta+_B t'\ast_B\eta),\ (\Xi(v)+_B\Xi(v'))+_B\bigl((-_{\mathbb{C}}t)\ast_B\eta+_B(-_{\mathbb{C}}t')\ast_B\eta\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラーの加法についての分配法則。各成分に。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl((\Xi(v)+_B t\ast_B\eta)+_B(\Xi(v')+_B t'\ast_B\eta),\ \bigl(\Xi(v)+_B(-_{\mathbb{C}}t)\ast_B\eta\bigr)+_B\bigl(\Xi(v')+_B(-_{\mathbb{C}}t')\ast_B\eta\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{に当てる。各成分に}\text{。}\blkref{claim_rearranging_sum_of_two_sums_in_vector_space}\right)\\
&=\Bigl(\Xi(v)+_B t\ast_B\eta,\ \Xi(v)+_B(-_{\mathbb{C}}t)\ast_B\eta\Bigr)+_{B\times B}\Bigl(\Xi(v')+_B t'\ast_B\eta,\ \Xi(v')+_B(-_{\mathbb{C}}t')\ast_B\eta\Bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\varphi'\bigl((v,t)\bigr)+_{B\times B}\varphi'\bigl((v',t')\bigr)
&&\left(\because\ \blkref{def_map_from_odd_extension_to_pair_of_matrices}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\varphi'\bigl(\lambda\cdot_{V'}(v,t)\bigr)
&=\varphi'\bigl((\lambda\cdot_V v,\ \lambda\cdot_{\mathbb{C}}t)\bigr)
&&\left(\because\ \cdot_{V'}\ \text{と}\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\text{、}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\Bigl(\Xi(\lambda\cdot_V v)+_B(\lambda\cdot_{\mathbb{C}}t)\ast_B\eta,\ \Xi(\lambda\cdot_V v)+_B\bigl(-_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}t)\bigr)\ast_B\eta\Bigr)
&&\left(\because\ \blkref{def_map_from_odd_extension_to_pair_of_matrices}\right)\\
&=\Bigl(\lambda\ast_B\Xi(v)+_B(\lambda\cdot_{\mathbb{C}}t)\ast_B\eta,\ \lambda\ast_B\Xi(v)+_B\bigl(-_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}t)\bigr)\ast_B\eta\Bigr)
&&\left(\because\ \Xi\ \text{はスカラー倍を保つ。各成分に}\right)\\
&=\Bigl(\lambda\ast_B\Xi(v)+_B(\lambda\cdot_{\mathbb{C}}t)\ast_B\eta,\ \lambda\ast_B\Xi(v)+_B\bigl(\lambda\cdot_{\mathbb{C}}(-_{\mathbb{C}}t)\bigr)\ast_B\eta\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\Bigl(\lambda\ast_B\Xi(v)+_B\lambda\ast_B(t\ast_B\eta),\ \lambda\ast_B\Xi(v)+_B\lambda\ast_B\bigl((-_{\mathbb{C}}t)\ast_B\eta\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の結合法則。各成分に。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(\lambda\ast_B\bigl(\Xi(v)+_B t\ast_B\eta\bigr),\ \lambda\ast_B\bigl(\Xi(v)+_B(-_{\mathbb{C}}t)\ast_B\eta\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のベクトルの加法についての分配法則。各成分に。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\ast_{B\times B}\Bigl(\Xi(v)+_B t\ast_B\eta,\ \Xi(v)+_B(-_{\mathbb{C}}t)\ast_B\eta\Bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\lambda\ast_{B\times B}\varphi'\bigl((v,t)\bigr)
&&\left(\because\ \blkref{def_map_from_odd_extension_to_pair_of_matrices}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity",
    kind: "claim",
    title: { text: "平方が単位元の倍である元に、それと反交換し平方が 1 の元の倍を足した元の平方" },
    labels: ["claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity"],
    statement: [
      paragraph([math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）とする。", math(String.raw`X,Y\in A`), " と ", math(String.raw`\alpha\in\mathbb{C}`), " が ", math(String.raw`X\cdot_A X=\alpha\ast_A 1_A`), "、", math(String.raw`Y\cdot_A Y=1_A`), "、", math(String.raw`X\cdot_A Y+_A Y\cdot_A X=0_A`), " を満たすとき、すべての ", math(String.raw`s\in\mathbb{C}`), " について次が成り立つ。"]),
      displayMath(String.raw`(X+_A s\ast_A Y)\cdot_A(X+_A s\ast_A Y)=(\alpha+_{\mathbb{C}}s\cdot_{\mathbb{C}}s)\ast_A 1_A`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(X+_A s\ast_A Y)\cdot_A(X+_A s\ast_A Y)
&=X\cdot_A(X+_A s\ast_A Y)+_A(s\ast_A Y)\cdot_A(X+_A s\ast_A Y)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(X\cdot_A X+_A X\cdot_A(s\ast_A Y)\bigr)+_A\bigl((s\ast_A Y)\cdot_A X+_A(s\ast_A Y)\cdot_A(s\ast_A Y)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(X\cdot_A X+_A s\ast_A(X\cdot_A Y)\bigr)+_A\bigl((s\ast_A Y)\cdot_A X+_A(s\ast_A Y)\cdot_A(s\ast_A Y)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(X\cdot_A X+_A s\ast_A(X\cdot_A Y)\bigr)+_A\bigl(s\ast_A(Y\cdot_A X)+_A(s\ast_A Y)\cdot_A(s\ast_A Y)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(X\cdot_A X+_A s\ast_A(X\cdot_A Y)\bigr)+_A\bigl(s\ast_A(Y\cdot_A X)+_A s\ast_A(Y\cdot_A(s\ast_A Y))\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(X\cdot_A X+_A s\ast_A(X\cdot_A Y)\bigr)+_A\bigl(s\ast_A(Y\cdot_A X)+_A s\ast_A(s\ast_A(Y\cdot_A Y))\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bigl(X\cdot_A X+_A s\ast_A(X\cdot_A Y)\bigr)+_A\bigl(s\ast_A(Y\cdot_A X)+_A(s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=X\cdot_A X+_A\Bigl(s\ast_A(X\cdot_A Y)+_A\bigl(s\ast_A(Y\cdot_A X)+_A(s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の結合法則。}\blkref{def_unital_ring}\right)\\
&=X\cdot_A X+_A\Bigl(\bigl(s\ast_A(X\cdot_A Y)+_A s\ast_A(Y\cdot_A X)\bigr)+_A(s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)\Bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の結合法則。}\blkref{def_unital_ring}\right)\\
&=X\cdot_A X+_A\bigl(s\ast_A(X\cdot_A Y+_A Y\cdot_A X)+_A(s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=X\cdot_A X+_A\bigl(s\ast_A 0_A+_A(s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)\bigr)
&&\left(\because\ X\cdot_A Y+_A Y\cdot_A X=0_A\right)\\
&=X\cdot_A X+_A\bigl(0_A+_A(s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)\bigr)
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=X\cdot_A X+_A\bigl((s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)+_A 0_A\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=X\cdot_A X+_A(s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=\alpha\ast_A 1_A+_A(s\cdot_{\mathbb{C}}s)\ast_A(Y\cdot_A Y)
&&\left(\because\ X\cdot_A X=\alpha\ast_A 1_A\right)\\
&=\alpha\ast_A 1_A+_A(s\cdot_{\mathbb{C}}s)\ast_A 1_A
&&\left(\because\ Y\cdot_A Y=1_A\right)\\
&=(\alpha+_{\mathbb{C}}s\cdot_{\mathbb{C}}s)\ast_A 1_A
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_square_of_map_from_odd_extension_to_pair_of_matrices",
    kind: "claim",
    title: { text: "一つの次元を足した空間から行列の組への写像の値の平方" },
    labels: ["claim_square_of_map_from_odd_extension_to_pair_of_matrices"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像とする。すべての ", math(String.raw`x\in V'`), " について次が成り立つ。"]),
      displayMath(String.raw`\varphi'(x)\cdot_{B\times B}\varphi'(x)=q'(x)\ast_{B\times B}1_{B\times B}`),
    ],
    proof: [
      paragraph([math(String.raw`x=(v,t)`), "（", math(String.raw`v\in V`), "、", math(String.raw`t\in\mathbb{C}`), "）と書き、", math(String.raw`X:=\Phi(\gamma(v))\in B`), "、", math(String.raw`Y:=\Phi(\varepsilon)\in B`), " と置く。", math(String.raw`\Phi`), " は ℂ-代数の準同型である（", ref("def_homomorphism_from_clifford_algebra_to_matrix_algebra"), "）。三つの等式を準備する。"]),
      displayMath(String.raw`\begin{aligned}
X\cdot_B X
&=\Phi\bigl(\gamma(v)\cdot_A\gamma(v)\bigr)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Phi\bigl(q(v)\ast_A 1_A\bigr)
&&\left(\because\ \blkref{claim_square_of_clifford_generator}\right)\\
&=q(v)\ast_B\Phi(1_A)
&&\left(\because\ \Phi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=q(v)\ast_B 1_B
&&\left(\because\ \Phi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Y\cdot_B Y
&=\Phi(\varepsilon\cdot_A\varepsilon)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Phi(1_A)
&&\left(\because\ \blkref{claim_square_of_parity_element_is_one}\right)\\
&=1_B
&&\left(\because\ \Phi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
X\cdot_B Y+_B Y\cdot_B X
&=\Phi\bigl(\gamma(v)\cdot_A\varepsilon\bigr)+_B\Phi\bigl(\varepsilon\cdot_A\gamma(v)\bigr)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Phi\bigl(\gamma(v)\cdot_A\varepsilon+_A\varepsilon\cdot_A\gamma(v)\bigr)
&&\left(\because\ \Phi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Phi(0_A)
&&\left(\because\ \blkref{claim_image_of_split_space_anticommutes_with_parity_element}\right)\\
&=0_B
&&\left(\because\ \Phi\ \text{は線型写像}\text{。}\blkref{claim_linear_map_sends_zero_to_zero}\right).
\end{aligned}`),
      paragraph(["三つの等式は ", ref("claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity"), " の仮定を ", math(String.raw`\alpha:=q(v)`), " として満たす。"]),
      displayMath(String.raw`\begin{aligned}
\varphi'(x)\cdot_{B\times B}\varphi'(x)
&=(X+_B t\ast_B Y,\ X+_B(-_{\mathbb{C}}t)\ast_B Y)\cdot_{B\times B}(X+_B t\ast_B Y,\ X+_B(-_{\mathbb{C}}t)\ast_B Y)
&&\left(\because\ \blkref{def_map_from_odd_extension_to_pair_of_matrices}\right)\\
&=\Bigl((X+_B t\ast_B Y)\cdot_B(X+_B t\ast_B Y),\ \bigl(X+_B(-_{\mathbb{C}}t)\ast_B Y\bigr)\cdot_B\bigl(X+_B(-_{\mathbb{C}}t)\ast_B Y\bigr)\Bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\Bigl((q(v)+_{\mathbb{C}}t\cdot_{\mathbb{C}}t)\ast_B 1_B,\ \bigl(q(v)+_{\mathbb{C}}(-_{\mathbb{C}}t)\cdot_{\mathbb{C}}(-_{\mathbb{C}}t)\bigr)\ast_B 1_B\Bigr)
&&\left(\because\ s:=t\ \text{と}\ s:=-_{\mathbb{C}}t\ \text{で各成分に}\text{。}\blkref{claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity}\right)\\
&=\Bigl((q(v)+_{\mathbb{C}}t\cdot_{\mathbb{C}}t)\ast_B 1_B,\ (q(v)+_{\mathbb{C}}t\cdot_{\mathbb{C}}t)\ast_B 1_B\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=(q(v)+_{\mathbb{C}}t\cdot_{\mathbb{C}}t)\ast_{B\times B}(1_B,1_B)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(q(v)+_{\mathbb{C}}t\cdot_{\mathbb{C}}t)\ast_{B\times B}1_{B\times B}
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=q'(x)\ast_{B\times B}1_{B\times B}
&&\left(\because\ q'\ \text{の定義}\text{。}\blkref{def_odd_dimensional_extension_of_split_quadratic_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras",
    kind: "claim",
    title: { text: "奇数次元のクリフォード代数から行列環の直積への準同型の存在と一意性" },
    labels: ["claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像とする。", math(String.raw`A'`), " から ", math(String.raw`B\times B`), " への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）", math(String.raw`\Theta`), " で、", math(String.raw`V'`), " から ", math(String.raw`B\times B`), " への写像として ", math(String.raw`\Theta\circ\gamma'=\varphi'`), " を満たすものが、ただ一つ存在する。"]),
    ],
    proof: [
      paragraph(["クリフォード代数の普遍性（", ref("claim_universal_property_of_clifford_algebra"), "）の代数に ", math(String.raw`B\times B`), "、線型写像に ", math(String.raw`f:=\varphi'`), " を当てる。", math(String.raw`B\times B`), " は ℂ-代数であり（", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）、", math(String.raw`\varphi'`), " は ", math(String.raw`V'`), " から ", math(String.raw`U_{\mathrm{vec}}(B\times B)`), " への線型写像であり（", ref("claim_map_from_odd_extension_to_pair_of_matrices_is_linear_map"), "）、すべての ", math(String.raw`x\in V'`), " について ", math(String.raw`\varphi'(x)\cdot_{B\times B}\varphi'(x)=q'(x)\ast_{B\times B}1_{B\times B}`), " である（", ref("claim_square_of_map_from_odd_extension_to_pair_of_matrices"), "）。普遍性の仮定がすべて満たされたので、主張の準同型がただ一つ存在する。"]),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras",
    kind: "definition",
    title: { text: "奇数次元のクリフォード代数から行列環の直積への準同型" },
    labels: ["def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"],
    statement: [
      paragraph([ref("claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), " のただ一つの ℂ-代数の準同型を ", math(String.raw`\Phi':A'\to B\times B`), " と書く。", math(String.raw`\Phi'`), " は ", math(String.raw`\Phi'\circ\gamma'=\varphi'`), " を満たす。"]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism",
    kind: "claim",
    title: { text: "誘導された準同型のあとに行列の組への準同型を合成すると、同じ行列を二つ並べた組になる" },
    labels: ["claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像、", math(String.raw`\Phi'`), " を ", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), " の準同型とする。すべての ", math(String.raw`a\in A`), " について ", math(String.raw`\Phi'(j(a))=(\Phi(a),\Phi(a))`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`\Delta:=\langle\Phi,\Phi\rangle:A\to B\times B`), "（", math(String.raw`\Delta(a)=(\Phi(a),\Phi(a))`), "）は ℂ-代数の準同型である（", ref("claim_pair_of_algebra_homomorphisms_is_algebra_homomorphism"), "）。", math(String.raw`\Phi'\circ j`), " も ℂ-代数の準同型である（", ref("def_setting_of_odd_dimensional_corollary"), "、", ref("claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism"), "）。", math(String.raw`v\in V`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Phi'\bigl(j(\gamma(v))\bigr)
&=\Phi'\bigl(\gamma'(\mathrm{in}'_1(v))\bigr)
&&\left(\because\ j\circ\gamma=\gamma'\circ\mathrm{in}'_1\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=\varphi'\bigl(\mathrm{in}'_1(v)\bigr)
&&\left(\because\ \blkref{def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras}\right)\\
&=\varphi'\bigl((v,0_{\mathbb{C}^{\mathrm{vec}}})\bigr)
&&\left(\because\ \blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&=\varphi'\bigl((v,0_{\mathbb{C}})\bigr)
&&\left(\because\ \blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\Bigl(\Phi(\gamma(v))+_B 0_{\mathbb{C}}\ast_B\Phi(\varepsilon),\ \Phi(\gamma(v))+_B(-_{\mathbb{C}}0_{\mathbb{C}})\ast_B\Phi(\varepsilon)\Bigr)
&&\left(\because\ \blkref{def_map_from_odd_extension_to_pair_of_matrices}\right)\\
&=\Bigl(\Phi(\gamma(v))+_B 0_{\mathbb{C}}\ast_B\Phi(\varepsilon),\ \Phi(\gamma(v))+_B 0_{\mathbb{C}}\ast_B\Phi(\varepsilon)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\Bigl(\Phi(\gamma(v))+_B 0_B,\ \Phi(\gamma(v))+_B 0_B\Bigr)
&&\left(\because\ \text{各成分に}\text{。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=\Bigl(\Phi(\gamma(v)),\ \Phi(\gamma(v))\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の単位元。各成分に。}\blkref{def_complex_vector_space}\right)\\
&=\Delta\bigl(\gamma(v)\bigr)
&&\left(\because\ \Delta\ \text{の定義}\right).
\end{aligned}`),
      paragraph([math(String.raw`\gamma(V)`), " は ", math(String.raw`A`), " を生成するので（", ref("claim_image_of_clifford_generator_map_generates_clifford_algebra"), "）、", ref("claim_homomorphisms_agreeing_on_generators_are_equal"), " により ", math(String.raw`\Phi'\circ j=\Delta`), " である。これは主張の等式である。"]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_pair_of_matrices_on_added_generator",
    kind: "claim",
    title: { text: "行列の組への準同型による、足した次元の単位の元の像の値" },
    labels: ["claim_homomorphism_to_pair_of_matrices_on_added_generator"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像、", math(String.raw`\Phi'`), " を ", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), " の準同型とする。", math(String.raw`\Phi'(g)=\bigl(\Phi(\varepsilon),\ (-1_{\mathbb{C}})\ast_B\Phi(\varepsilon)\bigr)`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`\Phi\circ\gamma`), " は ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(B)`), " への線型写像なので（", ref("claim_clifford_generator_map_is_linear_map"), "、", ref("def_complex_algebra_homomorphism"), "、", ref("claim_composition_of_linear_maps_is_linear_map"), "）、", math(String.raw`\Phi(\gamma(0_V))=0_B`), " である（", ref("claim_linear_map_sends_zero_to_zero"), "）。"]),
      displayMath(String.raw`\begin{aligned}
\Phi'(g)
&=\Phi'\bigl(\gamma'(u)\bigr)
&&\left(\because\ g\ \text{の定義}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=\varphi'(u)
&&\left(\because\ \blkref{def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras}\right)\\
&=\varphi'\bigl(\mathrm{in}'_2(1_{\mathbb{C}})\bigr)
&&\left(\because\ u\ \text{の定義}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=\varphi'\bigl((0_V,1_{\mathbb{C}})\bigr)
&&\left(\because\ \blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&=\Bigl(\Phi(\gamma(0_V))+_B 1_{\mathbb{C}}\ast_B\Phi(\varepsilon),\ \Phi(\gamma(0_V))+_B(-_{\mathbb{C}}1_{\mathbb{C}})\ast_B\Phi(\varepsilon)\Bigr)
&&\left(\because\ \blkref{def_map_from_odd_extension_to_pair_of_matrices}\right)\\
&=\Bigl(0_B+_B 1_{\mathbb{C}}\ast_B\Phi(\varepsilon),\ 0_B+_B(-1_{\mathbb{C}})\ast_B\Phi(\varepsilon)\Bigr)
&&\left(\because\ \Phi(\gamma(0_V))=0_B\ \text{と}\ -1_{\mathbb{C}}\ \text{の定義。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=\Bigl(1_{\mathbb{C}}\ast_B\Phi(\varepsilon)+_B 0_B,\ (-1_{\mathbb{C}})\ast_B\Phi(\varepsilon)+_B 0_B\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の交換法則。各成分に。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(1_{\mathbb{C}}\ast_B\Phi(\varepsilon),\ (-1_{\mathbb{C}})\ast_B\Phi(\varepsilon)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{の加法の単位元。各成分に。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(\Phi(\varepsilon),\ (-1_{\mathbb{C}})\ast_B\Phi(\varepsilon)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_pair_of_matrices_on_central_element",
    kind: "claim",
    title: { text: "行列の組への準同型による、中心の元の値" },
    labels: ["claim_homomorphism_to_pair_of_matrices_on_central_element"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像、", math(String.raw`\Phi'`), " を ", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), " の準同型とする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), " の元とする。", math(String.raw`\Phi'(z)=\bigl(1_B,\ (-1_{\mathbb{C}})\ast_B 1_B\bigr)`), " である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\Phi'(z)
&=\Phi'\bigl(j(\varepsilon)\cdot_{A'}g\bigr)
&&\left(\because\ \blkref{def_central_element_of_odd_dimensional_clifford_algebra}\right)\\
&=\Phi'\bigl(j(\varepsilon)\bigr)\cdot_{B\times B}\Phi'(g)
&&\left(\because\ \Phi'\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\bigl(\Phi(\varepsilon),\Phi(\varepsilon)\bigr)\cdot_{B\times B}\Phi'(g)
&&\left(\because\ \blkref{claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism}\right)\\
&=\bigl(\Phi(\varepsilon),\Phi(\varepsilon)\bigr)\cdot_{B\times B}\bigl(\Phi(\varepsilon),(-1_{\mathbb{C}})\ast_B\Phi(\varepsilon)\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_pair_of_matrices_on_added_generator}\right)\\
&=\Bigl(\Phi(\varepsilon)\cdot_B\Phi(\varepsilon),\ \Phi(\varepsilon)\cdot_B\bigl((-1_{\mathbb{C}})\ast_B\Phi(\varepsilon)\bigr)\Bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\Bigl(\Phi(\varepsilon)\cdot_B\Phi(\varepsilon),\ (-1_{\mathbb{C}})\ast_B\bigl(\Phi(\varepsilon)\cdot_B\Phi(\varepsilon)\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\Bigl(\Phi(\varepsilon\cdot_A\varepsilon),\ (-1_{\mathbb{C}})\ast_B\Phi(\varepsilon\cdot_A\varepsilon)\Bigr)
&&\left(\because\ \Phi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Bigl(\Phi(1_A),\ (-1_{\mathbb{C}})\ast_B\Phi(1_A)\Bigr)
&&\left(\because\ \blkref{claim_square_of_parity_element_is_one}\right)\\
&=\Bigl(1_B,\ (-1_{\mathbb{C}})\ast_B 1_B\Bigr)
&&\left(\because\ \Phi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_idempotents_of_odd_dimensional_clifford_algebra",
    kind: "definition",
    title: { text: "中心の元から作る二つの冪等元" },
    labels: ["def_idempotents_of_odd_dimensional_clifford_algebra"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), " の元とする。", math(String.raw`\sigma\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}`), " について、", math(String.raw`A'`), " の元 ", math(String.raw`e_\sigma`), " を次で定める。"]),
      displayMath(String.raw`e_\sigma:=h\ast_{A'}\bigl(1_{A'}+_{A'}\sigma\ast_{A'}z\bigr)`),
      paragraph([math(String.raw`e_{+}:=e_{1_{\mathbb{C}}}`), "、", math(String.raw`e_{-}:=e_{-1_{\mathbb{C}}}`), " と書く。"]),
    ],
  },
  {
    id: "isomorphism_claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself",
    kind: "claim",
    title: { text: "中心の元から作った冪等元の平方は、その元自身である" },
    labels: ["claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), "、", math(String.raw`e_\sigma`), "・", math(String.raw`e_{+}`), "・", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元とする。すべての ", math(String.raw`\sigma\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}`), " について ", math(String.raw`e_\sigma\cdot_{A'}e_\sigma=e_\sigma`), " である。"]),
    ],
    proof: [
      paragraph(["準備として、", math(String.raw`U:=1_{A'}+_{A'}\sigma\ast_{A'}z`), " と置き、", math(String.raw`U\cdot_{A'}U`), " を計算する。"]),
      displayMath(String.raw`\begin{aligned}
U\cdot_{A'}U
&=1_{A'}\cdot_{A'}U+_{A'}(\sigma\ast_{A'}z)\cdot_{A'}U
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=U+_{A'}(\sigma\ast_{A'}z)\cdot_{A'}U
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=U+_{A'}\bigl((\sigma\ast_{A'}z)\cdot_{A'}1_{A'}+_{A'}(\sigma\ast_{A'}z)\cdot_{A'}(\sigma\ast_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=U+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}(\sigma\ast_{A'}z)\cdot_{A'}(\sigma\ast_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=U+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}\sigma\ast_{A'}(z\cdot_{A'}(\sigma\ast_{A'}z))\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=U+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}\sigma\ast_{A'}(\sigma\ast_{A'}(z\cdot_{A'}z))\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=U+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}(\sigma\cdot_{\mathbb{C}}\sigma)\ast_{A'}(z\cdot_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=U+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}(\sigma\cdot_{\mathbb{C}}\sigma)\ast_{A'}1_{A'}\bigr)
&&\left(\because\ \blkref{claim_square_of_central_element_is_one}\right)\\
&=U+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}1_{\mathbb{C}}\ast_{A'}1_{A'}\bigr)
&&\left(\because\ \sigma\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}\ \text{なので}\ \sigma\cdot_{\mathbb{C}}\sigma=1_{\mathbb{C}}\right)\\
&=U+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}1_{A'}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=U+_{A'}U
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=1_{\mathbb{C}}\ast_{A'}U+_{A'}1_{\mathbb{C}}\ast_{A'}U
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}U
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
e_\sigma\cdot_{A'}e_\sigma
&=(h\ast_{A'}U)\cdot_{A'}(h\ast_{A'}U)
&&\left(\because\ \blkref{def_idempotents_of_odd_dimensional_clifford_algebra}\right)\\
&=h\ast_{A'}\bigl(U\cdot_{A'}(h\ast_{A'}U)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=h\ast_{A'}\bigl(h\ast_{A'}(U\cdot_{A'}U)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=(h\cdot_{\mathbb{C}}h)\ast_{A'}(U\cdot_{A'}U)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(h\cdot_{\mathbb{C}}h)\ast_{A'}\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}U\bigr)
&&\left(\because\ \text{準備の等式}\right)\\
&=\bigl((h\cdot_{\mathbb{C}}h)\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\bigr)\ast_{A'}U
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}U
&&\left(\because\ h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})=1_{\mathbb{C}}\text{。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=e_\sigma
&&\left(\because\ \blkref{def_idempotents_of_odd_dimensional_clifford_algebra}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero",
    kind: "claim",
    title: { text: "中心の元から作った二つの冪等元の積は零である" },
    labels: ["claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), "、", math(String.raw`e_\sigma`), "・", math(String.raw`e_{+}`), "・", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元とする。", math(String.raw`\sigma\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}`), " について ", math(String.raw`\bar{\sigma}:=-_{\mathbb{C}}\sigma\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}`), " と書く。", math(String.raw`e_\sigma\cdot_{A'}e_{\bar{\sigma}}=0_{A'}`), " である。"]),
    ],
    proof: [
      paragraph(["準備として、", math(String.raw`U:=1_{A'}+_{A'}\sigma\ast_{A'}z`), "、", math(String.raw`\bar{U}:=1_{A'}+_{A'}\bar{\sigma}\ast_{A'}z`), " と置き、", math(String.raw`U\cdot_{A'}\bar{U}`), " を計算する。"]),
      displayMath(String.raw`\begin{aligned}
U\cdot_{A'}\bar{U}
&=1_{A'}\cdot_{A'}\bar{U}+_{A'}(\sigma\ast_{A'}z)\cdot_{A'}\bar{U}
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\bar{U}+_{A'}(\sigma\ast_{A'}z)\cdot_{A'}\bar{U}
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\bar{U}+_{A'}\bigl((\sigma\ast_{A'}z)\cdot_{A'}1_{A'}+_{A'}(\sigma\ast_{A'}z)\cdot_{A'}(\bar{\sigma}\ast_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\bar{U}+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}(\sigma\ast_{A'}z)\cdot_{A'}(\bar{\sigma}\ast_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=\bar{U}+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}\sigma\ast_{A'}(z\cdot_{A'}(\bar{\sigma}\ast_{A'}z))\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\bar{U}+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}\sigma\ast_{A'}(\bar{\sigma}\ast_{A'}(z\cdot_{A'}z))\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\bar{U}+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}(\sigma\cdot_{\mathbb{C}}\bar{\sigma})\ast_{A'}(z\cdot_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bar{U}+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}(\sigma\cdot_{\mathbb{C}}\bar{\sigma})\ast_{A'}1_{A'}\bigr)
&&\left(\because\ \blkref{claim_square_of_central_element_is_one}\right)\\
&=\bar{U}+_{A'}\bigl(\sigma\ast_{A'}z+_{A'}(-1_{\mathbb{C}})\ast_{A'}1_{A'}\bigr)
&&\left(\because\ \sigma\cdot_{\mathbb{C}}\bar{\sigma}=-_{\mathbb{C}}(\sigma\cdot_{\mathbb{C}}\sigma)=-1_{\mathbb{C}}\ \text{（}\mathbb{C}\ \text{の四則と}\ \sigma\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}\text{）}\right)\\
&=(1_{A'}+_{A'}\bar{\sigma}\ast_{A'}z)+_{A'}\bigl((-1_{\mathbb{C}})\ast_{A'}1_{A'}+_{A'}\sigma\ast_{A'}z\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(1_{A'}+_{A'}(-1_{\mathbb{C}})\ast_{A'}1_{A'}\bigr)+_{A'}(\bar{\sigma}\ast_{A'}z+_{A'}\sigma\ast_{A'}z)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{に当てる}\text{。}\blkref{claim_rearranging_sum_of_two_sums_in_vector_space}\right)\\
&=\bigl(1_{\mathbb{C}}\ast_{A'}1_{A'}+_{A'}(-1_{\mathbb{C}})\ast_{A'}1_{A'}\bigr)+_{A'}(\bar{\sigma}\ast_{A'}z+_{A'}\sigma\ast_{A'}z)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_{A'}1_{A'}+_{A'}(\bar{\sigma}+_{\mathbb{C}}\sigma)\ast_{A'}z
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラーの加法についての分配法則。二か所に。}\blkref{def_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\ast_{A'}1_{A'}+_{A'}0_{\mathbb{C}}\ast_{A'}z
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=0_{A'}+_{A'}0_{A'}
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{A'}
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
e_\sigma\cdot_{A'}e_{\bar{\sigma}}
&=(h\ast_{A'}U)\cdot_{A'}(h\ast_{A'}\bar{U})
&&\left(\because\ \blkref{def_idempotents_of_odd_dimensional_clifford_algebra}\right)\\
&=h\ast_{A'}\bigl(U\cdot_{A'}(h\ast_{A'}\bar{U})\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=h\ast_{A'}\bigl(h\ast_{A'}(U\cdot_{A'}\bar{U})\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=h\ast_{A'}(h\ast_{A'}0_{A'})
&&\left(\because\ \text{準備の等式}\right)\\
&=h\ast_{A'}0_{A'}
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=0_{A'}
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one",
    kind: "claim",
    title: { text: "中心の元から作った二つの冪等元の和は 1 である" },
    labels: ["claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), "、", math(String.raw`e_\sigma`), "・", math(String.raw`e_{+}`), "・", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元とする。", math(String.raw`e_{+}+_{A'}e_{-}=1_{A'}`), " である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
e_{+}+_{A'}e_{-}
&=h\ast_{A'}(1_{A'}+_{A'}1_{\mathbb{C}}\ast_{A'}z)+_{A'}h\ast_{A'}(1_{A'}+_{A'}(-1_{\mathbb{C}})\ast_{A'}z)
&&\left(\because\ \blkref{def_idempotents_of_odd_dimensional_clifford_algebra}\right)\\
&=h\ast_{A'}\bigl((1_{A'}+_{A'}1_{\mathbb{C}}\ast_{A'}z)+_{A'}(1_{A'}+_{A'}(-1_{\mathbb{C}})\ast_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\bigl((1_{A'}+_{A'}1_{A'})+_{A'}(1_{\mathbb{C}}\ast_{A'}z+_{A'}(-1_{\mathbb{C}})\ast_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{に当てる}\text{。}\blkref{claim_rearranging_sum_of_two_sums_in_vector_space}\right)\\
&=h\ast_{A'}\bigl((1_{\mathbb{C}}\ast_{A'}1_{A'}+_{A'}1_{\mathbb{C}}\ast_{A'}1_{A'})+_{A'}(1_{\mathbb{C}}\ast_{A'}z+_{A'}(-1_{\mathbb{C}})\ast_{A'}z)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}1_{A'}+_{A'}(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}}))\ast_{A'}z\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラーの加法についての分配法則。二か所に。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}1_{A'}+_{A'}0_{\mathbb{C}}\ast_{A'}z\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=h\ast_{A'}\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}1_{A'}+_{A'}0_{A'}\bigr)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=h\ast_{A'}\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}1_{A'}\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=\bigl(h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\bigr)\ast_{A'}1_{A'}
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_{A'}1_{A'}
&&\left(\because\ h\ \text{の定義。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=1_{A'}
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element",
    kind: "claim",
    title: { text: "中心の元から作った二つの冪等元の差は、中心の元である" },
    labels: ["claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), "、", math(String.raw`e_\sigma`), "・", math(String.raw`e_{+}`), "・", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元とする。", math(String.raw`e_{+}+_{A'}(-1_{\mathbb{C}})\ast_{A'}e_{-}=z`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`U_{+}:=1_{A'}+_{A'}1_{\mathbb{C}}\ast_{A'}z`), "、", math(String.raw`U_{-}:=1_{A'}+_{A'}(-1_{\mathbb{C}})\ast_{A'}z`), " と置く（", math(String.raw`e_{\pm}=h\ast_{A'}U_{\pm}`), "。", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), "）。"]),
      displayMath(String.raw`\begin{aligned}
e_{+}+_{A'}(-1_{\mathbb{C}})\ast_{A'}e_{-}
&=h\ast_{A'}U_{+}+_{A'}(-1_{\mathbb{C}})\ast_{A'}(h\ast_{A'}U_{-})
&&\left(\because\ \blkref{def_idempotents_of_odd_dimensional_clifford_algebra}\right)\\
&=h\ast_{A'}U_{+}+_{A'}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}h\bigr)\ast_{A'}U_{-}
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}U_{+}+_{A'}\bigl(h\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_{A'}U_{-}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=h\ast_{A'}U_{+}+_{A'}h\ast_{A'}\bigl((-1_{\mathbb{C}})\ast_{A'}U_{-}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\bigl(U_{+}+_{A'}(-1_{\mathbb{C}})\ast_{A'}U_{-}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\Bigl(U_{+}+_{A'}\bigl((-1_{\mathbb{C}})\ast_{A'}1_{A'}+_{A'}(-1_{\mathbb{C}})\ast_{A'}((-1_{\mathbb{C}})\ast_{A'}z)\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\Bigl(U_{+}+_{A'}\bigl((-1_{\mathbb{C}})\ast_{A'}1_{A'}+_{A'}((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}}))\ast_{A'}z\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\Bigl((1_{A'}+_{A'}1_{\mathbb{C}}\ast_{A'}z)+_{A'}\bigl((-1_{\mathbb{C}})\ast_{A'}1_{A'}+_{A'}1_{\mathbb{C}}\ast_{A'}z\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=h\ast_{A'}\Bigl(\bigl(1_{A'}+_{A'}(-1_{\mathbb{C}})\ast_{A'}1_{A'}\bigr)+_{A'}(1_{\mathbb{C}}\ast_{A'}z+_{A'}1_{\mathbb{C}}\ast_{A'}z)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{に当てる}\text{。}\blkref{claim_rearranging_sum_of_two_sums_in_vector_space}\right)\\
&=h\ast_{A'}\Bigl(\bigl(1_{\mathbb{C}}\ast_{A'}1_{A'}+_{A'}(-1_{\mathbb{C}})\ast_{A'}1_{A'}\bigr)+_{A'}(1_{\mathbb{C}}\ast_{A'}z+_{A'}1_{\mathbb{C}}\ast_{A'}z)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\bigl((1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}}))\ast_{A'}1_{A'}+_{A'}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}z\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラーの加法についての分配法則。二か所に。}\blkref{def_complex_vector_space}\right)\\
&=h\ast_{A'}\bigl(0_{\mathbb{C}}\ast_{A'}1_{A'}+_{A'}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}z\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=h\ast_{A'}\bigl(0_{A'}+_{A'}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}z\bigr)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=h\ast_{A'}\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}z+_{A'}0_{A'}\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=h\ast_{A'}\bigl((1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\ast_{A'}z\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=\bigl(h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\bigr)\ast_{A'}z
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=1_{\mathbb{C}}\ast_{A'}z
&&\left(\because\ h\ \text{の定義。}\blkref{def_setting_of_odd_dimensional_corollary}\right)\\
&=z
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element",
    kind: "claim",
    title: { text: "中心の元から作った冪等元は、すべての元と交換する" },
    labels: ["claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), "、", math(String.raw`e_\sigma`), "・", math(String.raw`e_{+}`), "・", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元とする。すべての ", math(String.raw`\sigma\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}`), " と ", math(String.raw`y\in A'`), " について ", math(String.raw`y\cdot_{A'}e_\sigma=e_\sigma\cdot_{A'}y`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`C_y`), " を ", ref("claim_elements_commuting_with_fixed_element_form_subalgebra"), " の ", math(String.raw`A'`), " の部分代数とする。", math(String.raw`1_{A'}\in C_y`), " である（", ref("def_subalgebra"), "）。", math(String.raw`z\cdot_{A'}y=y\cdot_{A'}z`), "（", ref("claim_central_element_commutes_with_every_element"), "）なので ", math(String.raw`z\in C_y`), " である。", math(String.raw`C_y`), " はスカラー倍と加法で閉じているので（", ref("def_subalgebra"), "）、", math(String.raw`\sigma\ast_{A'}z`), "、", math(String.raw`1_{A'}+_{A'}\sigma\ast_{A'}z`), "、", math(String.raw`h\ast_{A'}(1_{A'}+_{A'}\sigma\ast_{A'}z)=e_\sigma`), " が順に ", math(String.raw`C_y`), " に属する（", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), "）。", math(String.raw`e_\sigma\in C_y`), " は主張の等式である。"]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_pair_of_matrices_on_idempotents",
    kind: "claim",
    title: { text: "行列の組への準同型による、冪等元の値" },
    labels: ["claim_homomorphism_to_pair_of_matrices_on_idempotents"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像、", math(String.raw`\Phi'`), " を ", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), " の準同型とする。", math(String.raw`e_\sigma`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元とする。すべての ", math(String.raw`\sigma\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}`), " について次が成り立つ。"]),
      displayMath(String.raw`\Phi'(e_\sigma)=\Bigl(\bigl(h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}\sigma)\bigr)\ast_B 1_B,\ \ \bigl(h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}(-_{\mathbb{C}}\sigma))\bigr)\ast_B 1_B\Bigr)`),
    ],
    proof: [
      paragraph([math(String.raw`z`), " を ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), " の元とする。"]),
      displayMath(String.raw`\begin{aligned}
\Phi'(e_\sigma)
&=\Phi'\bigl(h\ast_{A'}(1_{A'}+_{A'}\sigma\ast_{A'}z)\bigr)
&&\left(\because\ \blkref{def_idempotents_of_odd_dimensional_clifford_algebra}\right)\\
&=h\ast_{B\times B}\Phi'(1_{A'}+_{A'}\sigma\ast_{A'}z)
&&\left(\because\ \Phi'\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=h\ast_{B\times B}\bigl(\Phi'(1_{A'})+_{B\times B}\Phi'(\sigma\ast_{A'}z)\bigr)
&&\left(\because\ \Phi'\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=h\ast_{B\times B}\bigl(\Phi'(1_{A'})+_{B\times B}\sigma\ast_{B\times B}\Phi'(z)\bigr)
&&\left(\because\ \Phi'\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=h\ast_{B\times B}\bigl(1_{B\times B}+_{B\times B}\sigma\ast_{B\times B}\Phi'(z)\bigr)
&&\left(\because\ \Phi'\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=h\ast_{B\times B}\bigl((1_B,1_B)+_{B\times B}\sigma\ast_{B\times B}\Phi'(z)\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=h\ast_{B\times B}\bigl((1_B,1_B)+_{B\times B}\sigma\ast_{B\times B}(1_B,(-1_{\mathbb{C}})\ast_B 1_B)\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_pair_of_matrices_on_central_element}\right)\\
&=h\ast_{B\times B}\Bigl((1_B,1_B)+_{B\times B}\bigl(\sigma\ast_B 1_B,\ \sigma\ast_B((-1_{\mathbb{C}})\ast_B 1_B)\bigr)\Bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=h\ast_{B\times B}\bigl(1_B+_B\sigma\ast_B 1_B,\ 1_B+_B\sigma\ast_B((-1_{\mathbb{C}})\ast_B 1_B)\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\Bigl(h\ast_B(1_B+_B\sigma\ast_B 1_B),\ h\ast_B\bigl(1_B+_B\sigma\ast_B((-1_{\mathbb{C}})\ast_B 1_B)\bigr)\Bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=\Bigl(h\ast_B(1_B+_B\sigma\ast_B 1_B),\ h\ast_B\bigl(1_B+_B(\sigma\cdot_{\mathbb{C}}(-1_{\mathbb{C}}))\ast_B 1_B\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(h\ast_B(1_B+_B\sigma\ast_B 1_B),\ h\ast_B\bigl(1_B+_B(-_{\mathbb{C}}\sigma)\ast_B 1_B\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\Bigl(h\ast_B(1_{\mathbb{C}}\ast_B 1_B+_B\sigma\ast_B 1_B),\ h\ast_B\bigl(1_{\mathbb{C}}\ast_B 1_B+_B(-_{\mathbb{C}}\sigma)\ast_B 1_B\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の単位元。各成分に。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(h\ast_B\bigl((1_{\mathbb{C}}+_{\mathbb{C}}\sigma)\ast_B 1_B\bigr),\ h\ast_B\bigl((1_{\mathbb{C}}+_{\mathbb{C}}(-_{\mathbb{C}}\sigma))\ast_B 1_B\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラーの加法についての分配法則。各成分に。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(\bigl(h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}\sigma)\bigr)\ast_B 1_B,\ \bigl(h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}(-_{\mathbb{C}}\sigma))\bigr)\ast_B 1_B\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{のスカラー倍の結合法則。各成分に。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra",
    kind: "definition",
    title: { text: "行列環の直積から奇数次元のクリフォード代数への写像" },
    labels: ["def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "）、", math(String.raw`e_{+}`), " と ", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元とする。写像 ", math(String.raw`\Psi':B\times B\to A'`), " を次で定める。"]),
      displayMath(String.raw`\Psi'\bigl((F,G)\bigr):=j\bigl(\Psi(F)\bigr)\cdot_{A'}e_{+}+_{A'}j\bigl(\Psi(G)\bigr)\cdot_{A'}e_{-}\qquad(F,G\in B)`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "行列環の直積から奇数次元のクリフォード代数への写像は ℂ-代数の準同型である" },
    labels: ["claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`B\times B`), " を直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）、", math(String.raw`e_{+}`), "・", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元、", math(String.raw`\Psi'`), " を ", ref("def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra"), " の写像とする。", math(String.raw`\Psi'`), " は ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。"]),
    ],
    proof: [
      paragraph([math(String.raw`J:=j\circ\Psi:B\to A'`), " と置く。", math(String.raw`\Psi`), " と ", math(String.raw`j`), " は ℂ-代数の準同型なので（", ref("claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism"), "、", ref("def_setting_of_odd_dimensional_corollary"), "）、", math(String.raw`J`), " は ℂ-代数の準同型である（", ref("claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism"), "）。", math(String.raw`F,G,F',G'\in B`), "、", math(String.raw`\lambda\in\mathbb{C}`), " とする。準備として、", math(String.raw`p,r\in A'`), " と ", math(String.raw`\sigma,\tau\in\{1_{\mathbb{C}},-1_{\mathbb{C}}\}`), " について次の等式を示す（以下「積の並べ替え」と呼ぶ）。"]),
      displayMath(String.raw`\begin{aligned}
(p\cdot_{A'}e_\sigma)\cdot_{A'}(r\cdot_{A'}e_\tau)
&=p\cdot_{A'}\bigl(e_\sigma\cdot_{A'}(r\cdot_{A'}e_\tau)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=p\cdot_{A'}\bigl((e_\sigma\cdot_{A'}r)\cdot_{A'}e_\tau\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=p\cdot_{A'}\bigl((r\cdot_{A'}e_\sigma)\cdot_{A'}e_\tau\bigr)
&&\left(\because\ y:=r\ \text{とした}\text{。}\blkref{claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element}\right)\\
&=p\cdot_{A'}\bigl(r\cdot_{A'}(e_\sigma\cdot_{A'}e_\tau)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=(p\cdot_{A'}r)\cdot_{A'}(e_\sigma\cdot_{A'}e_\tau)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph(["加法を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\Psi'\bigl((F,G)+_{B\times B}(F',G')\bigr)
&=\Psi'\bigl((F+_B F',\ G+_B G')\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=J(F+_B F')\cdot_{A'}e_{+}+_{A'}J(G+_B G')\cdot_{A'}e_{-}
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right)\\
&=\bigl(J(F)+_{A'}J(F')\bigr)\cdot_{A'}e_{+}+_{A'}\bigl(J(G)+_{A'}J(G')\bigr)\cdot_{A'}e_{-}
&&\left(\because\ J\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\bigl(J(F)\cdot_{A'}e_{+}+_{A'}J(F')\cdot_{A'}e_{+}\bigr)+_{A'}\bigl(J(G)\cdot_{A'}e_{-}+_{A'}J(G')\cdot_{A'}e_{-}\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\bigl(J(F)\cdot_{A'}e_{+}+_{A'}J(G)\cdot_{A'}e_{-}\bigr)+_{A'}\bigl(J(F')\cdot_{A'}e_{+}+_{A'}J(G')\cdot_{A'}e_{-}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{に当てる}\text{。}\blkref{claim_rearranging_sum_of_two_sums_in_vector_space}\right)\\
&=\Psi'\bigl((F,G)\bigr)+_{A'}\Psi'\bigl((F',G')\bigr)
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\Psi'\bigl(\lambda\ast_{B\times B}(F,G)\bigr)
&=\Psi'\bigl((\lambda\ast_B F,\ \lambda\ast_B G)\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=J(\lambda\ast_B F)\cdot_{A'}e_{+}+_{A'}J(\lambda\ast_B G)\cdot_{A'}e_{-}
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right)\\
&=\bigl(\lambda\ast_{A'}J(F)\bigr)\cdot_{A'}e_{+}+_{A'}\bigl(\lambda\ast_{A'}J(G)\bigr)\cdot_{A'}e_{-}
&&\left(\because\ J\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\lambda\ast_{A'}\bigl(J(F)\cdot_{A'}e_{+}\bigr)+_{A'}\lambda\ast_{A'}\bigl(J(G)\cdot_{A'}e_{-}\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\lambda\ast_{A'}\bigl(J(F)\cdot_{A'}e_{+}+_{A'}J(G)\cdot_{A'}e_{-}\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A')\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\ast_{A'}\Psi'\bigl((F,G)\bigr)
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right).
\end{aligned}`),
      paragraph(["乗法の単位元を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\Psi'(1_{B\times B})
&=\Psi'\bigl((1_B,1_B)\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=J(1_B)\cdot_{A'}e_{+}+_{A'}J(1_B)\cdot_{A'}e_{-}
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right)\\
&=1_{A'}\cdot_{A'}e_{+}+_{A'}1_{A'}\cdot_{A'}e_{-}
&&\left(\because\ J\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=e_{+}+_{A'}e_{-}
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=1_{A'}
&&\left(\because\ \blkref{claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one}\right).
\end{aligned}`),
      paragraph(["乗法を保つこと。", math(String.raw`P_1:=J(F)`), "、", math(String.raw`P_2:=J(G)`), "、", math(String.raw`Q_1:=J(F')`), "、", math(String.raw`Q_2:=J(G')`), " と置く。", math(String.raw`e_{+}\cdot_{A'}e_{-}=0_{A'}`), " と ", math(String.raw`e_{-}\cdot_{A'}e_{+}=0_{A'}`), " は ", ref("claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero"), " を ", math(String.raw`\sigma:=1_{\mathbb{C}}`), " と ", math(String.raw`\sigma:=-1_{\mathbb{C}}`), " に当てたものである。"]),
      displayMath(String.raw`\begin{aligned}
\Psi'\bigl((F,G)\bigr)\cdot_{A'}\Psi'\bigl((F',G')\bigr)
&=(P_1\cdot_{A'}e_{+}+_{A'}P_2\cdot_{A'}e_{-})\cdot_{A'}(Q_1\cdot_{A'}e_{+}+_{A'}Q_2\cdot_{A'}e_{-})
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right)\\
&=(P_1\cdot_{A'}e_{+})\cdot_{A'}(Q_1\cdot_{A'}e_{+}+_{A'}Q_2\cdot_{A'}e_{-})+_{A'}(P_2\cdot_{A'}e_{-})\cdot_{A'}(Q_1\cdot_{A'}e_{+}+_{A'}Q_2\cdot_{A'}e_{-})
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((P_1\cdot_{A'}e_{+})\cdot_{A'}(Q_1\cdot_{A'}e_{+})+_{A'}(P_1\cdot_{A'}e_{+})\cdot_{A'}(Q_2\cdot_{A'}e_{-})\bigr)+_{A'}\bigl((P_2\cdot_{A'}e_{-})\cdot_{A'}(Q_1\cdot_{A'}e_{+})+_{A'}(P_2\cdot_{A'}e_{-})\cdot_{A'}(Q_2\cdot_{A'}e_{-})\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\bigl((P_1Q_1)\cdot_{A'}(e_{+}e_{+})+_{A'}(P_1Q_2)\cdot_{A'}(e_{+}e_{-})\bigr)+_{A'}\bigl((P_2Q_1)\cdot_{A'}(e_{-}e_{+})+_{A'}(P_2Q_2)\cdot_{A'}(e_{-}e_{-})\bigr)
&&\left(\because\ \text{積の並べ替えを四か所に。ここで}\ PQ:=P\cdot_{A^{\prime}}Q\right)\\
&=\bigl((P_1Q_1)\cdot_{A'}e_{+}+_{A'}(P_1Q_2)\cdot_{A'}(e_{+}e_{-})\bigr)+_{A'}\bigl((P_2Q_1)\cdot_{A'}(e_{-}e_{+})+_{A'}(P_2Q_2)\cdot_{A'}e_{-}\bigr)
&&\left(\because\ \blkref{claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself}\right)\\
&=\bigl((P_1Q_1)\cdot_{A'}e_{+}+_{A'}(P_1Q_2)\cdot_{A'}0_{A'}\bigr)+_{A'}\bigl((P_2Q_1)\cdot_{A'}0_{A'}+_{A'}(P_2Q_2)\cdot_{A'}e_{-}\bigr)
&&\left(\because\ \blkref{claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero}\right)\\
&=\bigl((P_1Q_1)\cdot_{A'}e_{+}+_{A'}0_{A'}\bigr)+_{A'}\bigl(0_{A'}+_{A'}(P_2Q_2)\cdot_{A'}e_{-}\bigr)
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=(P_1Q_1)\cdot_{A'}e_{+}+_{A'}\bigl(0_{A'}+_{A'}(P_2Q_2)\cdot_{A'}e_{-}\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=(P_1Q_1)\cdot_{A'}e_{+}+_{A'}\bigl((P_2Q_2)\cdot_{A'}e_{-}+_{A'}0_{A'}\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=(P_1Q_1)\cdot_{A'}e_{+}+_{A'}(P_2Q_2)\cdot_{A'}e_{-}
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の加法の単位元。}\blkref{def_unital_ring}\right)\\
&=J(F\cdot_B F')\cdot_{A'}e_{+}+_{A'}J(G\cdot_B G')\cdot_{A'}e_{-}
&&\left(\because\ J\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Psi'\bigl((F\cdot_B F',\ G\cdot_B G')\bigr)
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right)\\
&=\Psi'\bigl((F,G)\cdot_{B\times B}(F',G')\bigr)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right).
\end{aligned}`),
      paragraph(["四つの性質から、", math(String.raw`\Psi'`), " は ℂ-代数の準同型である（", ref("def_complex_algebra_homomorphism"), "）。"]),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity",
    kind: "claim",
    title: { text: "行列環の直積から奇数次元のクリフォード代数へ移してから行列の組へ戻すと、恒等写像になる" },
    labels: ["claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像、", math(String.raw`\Phi'`), " を ", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), " の準同型とする。", math(String.raw`e_{+}`), "・", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元、", math(String.raw`\Psi'`), " を ", ref("def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra"), " の写像とする。すべての ", math(String.raw`F,G\in B`), " について ", math(String.raw`\Phi'\bigl(\Psi'((F,G))\bigr)=(F,G)`), " である。"]),
    ],
    proof: [
      paragraph([ref("claim_homomorphism_to_pair_of_matrices_on_idempotents"), " を ", math(String.raw`\sigma:=1_{\mathbb{C}}`), " と ", math(String.raw`\sigma:=-1_{\mathbb{C}}`), " に当て、ℂ の四則で ", math(String.raw`h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})=1_{\mathbb{C}}`), "（", math(String.raw`h`), " の定義。", ref("def_setting_of_odd_dimensional_corollary"), "）、", math(String.raw`h\cdot_{\mathbb{C}}(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}}))=0_{\mathbb{C}}`), "、", math(String.raw`-_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}`), " を使い、", math(String.raw`1_{\mathbb{C}}\ast_B 1_B=1_B`), "（", ref("def_complex_vector_space"), "）と ", math(String.raw`0_{\mathbb{C}}\ast_B 1_B=0_B`), "（", ref("claim_zero_scalar_multiple_is_zero_vector"), "）で書き直すと、", math(String.raw`\Phi'(e_{+})=(1_B,0_B)`), "、", math(String.raw`\Phi'(e_{-})=(0_B,1_B)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\Phi'\bigl(\Psi'((F,G))\bigr)
&=\Phi'\bigl(j(\Psi(F))\cdot_{A'}e_{+}+_{A'}j(\Psi(G))\cdot_{A'}e_{-}\bigr)
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right)\\
&=\Phi'\bigl(j(\Psi(F))\cdot_{A'}e_{+}\bigr)+_{B\times B}\Phi'\bigl(j(\Psi(G))\cdot_{A'}e_{-}\bigr)
&&\left(\because\ \Phi'\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Phi'\bigl(j(\Psi(F))\bigr)\cdot_{B\times B}\Phi'(e_{+})+_{B\times B}\Phi'\bigl(j(\Psi(G))\bigr)\cdot_{B\times B}\Phi'(e_{-})
&&\left(\because\ \Phi'\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\bigl(\Phi(\Psi(F)),\Phi(\Psi(F))\bigr)\cdot_{B\times B}\Phi'(e_{+})+_{B\times B}\bigl(\Phi(\Psi(G)),\Phi(\Psi(G))\bigr)\cdot_{B\times B}\Phi'(e_{-})
&&\left(\because\ \blkref{claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism}\right)\\
&=(F,F)\cdot_{B\times B}\Phi'(e_{+})+_{B\times B}(G,G)\cdot_{B\times B}\Phi'(e_{-})
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity}\right)\\
&=(F,F)\cdot_{B\times B}(1_B,0_B)+_{B\times B}(G,G)\cdot_{B\times B}(0_B,1_B)
&&\left(\because\ \text{上の二つの値}\right)\\
&=(F\cdot_B 1_B,\ F\cdot_B 0_B)+_{B\times B}(G\cdot_B 0_B,\ G\cdot_B 1_B)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(F,\ F\cdot_B 0_B)+_{B\times B}(G\cdot_B 0_B,\ G)
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=(F,\ 0_B)+_{B\times B}(0_B,\ G)
&&\left(\because\ \blkref{claim_element_times_zero_in_algebra_is_zero}\right)\\
&=(F+_B 0_B,\ 0_B+_B G)
&&\left(\because\ \blkref{def_product_of_two_complex_algebras}\right)\\
&=(F+_B 0_B,\ G+_B 0_B)
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=(F,G)
&&\left(\because\ U_{\mathrm{ring}}(B)\ \text{の加法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity",
    kind: "claim",
    title: { text: "奇数次元のクリフォード代数から行列の組へ移してから戻すと、恒等写像になる" },
    labels: ["claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity"],
    statement: [
      paragraph(["以下の記号は ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。", math(String.raw`\varepsilon`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " の元、", math(String.raw`B\times B`), " を ", math(String.raw`B`), " と ", math(String.raw`B`), " の直積（", ref("def_product_of_two_complex_algebras"), "、", ref("claim_product_of_two_complex_algebras_is_complex_algebra"), "）とする。", math(String.raw`\varphi'`), " を ", ref("def_map_from_odd_extension_to_pair_of_matrices"), " の写像、", math(String.raw`\Phi'`), " を ", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), " の準同型とする。", math(String.raw`e_{+}`), "・", math(String.raw`e_{-}`), " を ", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), " の元、", math(String.raw`\Psi'`), " を ", ref("def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra"), " の写像とする。すべての ", math(String.raw`a\in A'`), " について ", math(String.raw`\Psi'\bigl(\Phi'(a)\bigr)=a`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`\Xi:=\Psi'\circ\Phi':A'\to A'`), " は ℂ-代数の準同型である（", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), "、", ref("claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism"), "、", ref("claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism"), "）。", math(String.raw`\mathrm{id}_{A'}`), " も ℂ-代数の準同型である（", ref("claim_identity_map_is_algebra_homomorphism"), "）。", math(String.raw`\varepsilon`), " と ", math(String.raw`z`), " を ", ref("def_parity_element_of_split_clifford_algebra"), " と ", ref("def_central_element_of_odd_dimensional_clifford_algebra"), " の元とする。", math(String.raw`y\in A`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Xi\bigl(j(y)\bigr)
&=\Psi'\bigl((\Phi(y),\Phi(y))\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism}\right)\\
&=j\bigl(\Psi(\Phi(y))\bigr)\cdot_{A'}e_{+}+_{A'}j\bigl(\Psi(\Phi(y))\bigr)\cdot_{A'}e_{-}
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right)\\
&=j(y)\cdot_{A'}e_{+}+_{A'}j(y)\cdot_{A'}e_{-}
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right)\\
&=j(y)\cdot_{A'}(e_{+}+_{A'}e_{-})
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=j(y)\cdot_{A'}1_{A'}
&&\left(\because\ \blkref{claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one}\right)\\
&=j(y)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph([math(String.raw`g`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
\Xi(g)
&=\Psi'\bigl((\Phi(\varepsilon),\ (-1_{\mathbb{C}})\ast_B\Phi(\varepsilon))\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_pair_of_matrices_on_added_generator}\right)\\
&=j\bigl(\Psi(\Phi(\varepsilon))\bigr)\cdot_{A'}e_{+}+_{A'}j\bigl(\Psi((-1_{\mathbb{C}})\ast_B\Phi(\varepsilon))\bigr)\cdot_{A'}e_{-}
&&\left(\because\ \blkref{def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra}\right)\\
&=j\bigl(\Psi(\Phi(\varepsilon))\bigr)\cdot_{A'}e_{+}+_{A'}j\bigl((-1_{\mathbb{C}})\ast_A\Psi(\Phi(\varepsilon))\bigr)\cdot_{A'}e_{-}
&&\left(\because\ \Psi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=j(\varepsilon)\cdot_{A'}e_{+}+_{A'}j\bigl((-1_{\mathbb{C}})\ast_A\varepsilon\bigr)\cdot_{A'}e_{-}
&&\left(\because\ \blkref{claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity}\right)\\
&=j(\varepsilon)\cdot_{A'}e_{+}+_{A'}\bigl((-1_{\mathbb{C}})\ast_{A'}j(\varepsilon)\bigr)\cdot_{A'}e_{-}
&&\left(\because\ j\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=j(\varepsilon)\cdot_{A'}e_{+}+_{A'}(-1_{\mathbb{C}})\ast_{A'}\bigl(j(\varepsilon)\cdot_{A'}e_{-}\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=j(\varepsilon)\cdot_{A'}e_{+}+_{A'}j(\varepsilon)\cdot_{A'}\bigl((-1_{\mathbb{C}})\ast_{A'}e_{-}\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl(e_{+}+_{A'}(-1_{\mathbb{C}})\ast_{A'}e_{-}\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=j(\varepsilon)\cdot_{A'}z
&&\left(\because\ \blkref{claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element}\right)\\
&=j(\varepsilon)\cdot_{A'}\bigl(j(\varepsilon)\cdot_{A'}g\bigr)
&&\left(\because\ \blkref{def_central_element_of_odd_dimensional_clifford_algebra}\right)\\
&=\bigl(j(\varepsilon)\cdot_{A'}j(\varepsilon)\bigr)\cdot_{A'}g
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=j(\varepsilon\cdot_A\varepsilon)\cdot_{A'}g
&&\left(\because\ j\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=j(1_A)\cdot_{A'}g
&&\left(\because\ \blkref{claim_square_of_parity_element_is_one}\right)\\
&=1_{A'}\cdot_{A'}g
&&\left(\because\ j\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=g
&&\left(\because\ U_{\mathrm{ring}}(A')\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
      paragraph([math(String.raw`x\in V'`), " を ", math(String.raw`x=(v,t)`), "（", math(String.raw`v\in V`), "、", math(String.raw`t\in\mathbb{C}`), "）と書く。"]),
      displayMath(String.raw`\begin{aligned}
\Xi\bigl(\gamma'(x)\bigr)
&=\Xi\bigl(j(\gamma(v))+_{A'}t\ast_{A'}g\bigr)
&&\left(\because\ \blkref{claim_image_of_odd_extension_element_is_sum_of_images}\right)\\
&=\Xi\bigl(j(\gamma(v))\bigr)+_{A'}\Xi(t\ast_{A'}g)
&&\left(\because\ \Xi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\Xi\bigl(j(\gamma(v))\bigr)+_{A'}t\ast_{A'}\Xi(g)
&&\left(\because\ \Xi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=j(\gamma(v))+_{A'}t\ast_{A'}\Xi(g)
&&\left(\because\ \text{上の一つ目の等式で}\ y:=\gamma(v)\right)\\
&=j(\gamma(v))+_{A'}t\ast_{A'}g
&&\left(\because\ \text{上の二つ目の等式}\right)\\
&=\gamma'(x)
&&\left(\because\ \blkref{claim_image_of_odd_extension_element_is_sum_of_images}\right)\\
&=\mathrm{id}_{A'}\bigl(\gamma'(x)\bigr)
&&\left(\because\ \mathrm{id}_{A^{\prime}}\ \text{の定義}\right).
\end{aligned}`),
      paragraph([math(String.raw`\gamma'(V')`), " は ", math(String.raw`A'`), " を生成するので（", ref("claim_image_of_clifford_generator_map_generates_clifford_algebra"), "）、", ref("claim_homomorphisms_agreeing_on_generators_are_equal"), " により ", math(String.raw`\Xi=\mathrm{id}_{A'}`), " である。", math(String.raw`\Xi`), " の定義により、これは主張の等式である。"]),
    ],
  },
  {
    id: "isomorphism_theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras",
    kind: "theorem",
    title: { text: "系：奇数次元の二次空間のクリフォード代数と、行列環二つの直積の同型" },
    labels: ["theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras"],
    statement: [
      paragraph([math(String.raw`M\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`W`), " を ", math(String.raw`M`), " 個の元からなる基底 ", math(String.raw`w`), " をもつ ℂ-線型空間、", math(String.raw`V:=W\oplus W^{*}`), "、", math(String.raw`q:=q_W`), " とし、", math(String.raw`V':=V\oplus\mathbb{C}^{\mathrm{vec}}`), " に ", math(String.raw`q'((v,t)):=q(v)+_{\mathbb{C}}t\cdot_{\mathbb{C}}t`), " を置く（", ref("def_odd_dimensional_extension_of_split_quadratic_space"), "。", math(String.raw`q'`), " は二次形式である。", ref("claim_odd_extension_quadratic_form_is_quadratic_form"), "）。", math(String.raw`A:=\mathrm{Cl}(V,q)`), "、", math(String.raw`A':=\mathrm{Cl}(V',q')`), "、", math(String.raw`j:A\to A'`), "、", math(String.raw`g`), "、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), "、", math(String.raw`\Phi`), "、", math(String.raw`\Psi`), " を ", ref("def_setting_of_odd_dimensional_corollary"), " のものとする。"]),
      paragraph([math(String.raw`\varepsilon:=\prod_{A,\,i=1}^{M}(a_i\cdot_A a^{\dagger}_i+_A(-1_{\mathbb{C}})\ast_A(a^{\dagger}_i\cdot_A a_i))`), "（", ref("def_parity_element_of_split_clifford_algebra"), "）と ", math(String.raw`z:=j(\varepsilon)\cdot_{A'}g`), "（", ref("def_central_element_of_odd_dimensional_clifford_algebra"), "）について、", math(String.raw`z`), " は ", math(String.raw`A'`), " のすべての元と交換し（", ref("claim_central_element_commutes_with_every_element"), "）、", math(String.raw`z\cdot_{A'}z=1_{A'}`), " である（", ref("claim_square_of_central_element_is_one"), "）。", math(String.raw`\Phi':A'\to B\times B`), " を、", math(String.raw`\Phi'(j(a))=(\Phi(a),\Phi(a))`), "（", math(String.raw`a\in A`), "）と ", math(String.raw`\Phi'(g)=(\Phi(\varepsilon),(-1_{\mathbb{C}})\ast_B\Phi(\varepsilon))`), " を満たす ℂ-代数の準同型（", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), "、", ref("claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism"), "、", ref("claim_homomorphism_to_pair_of_matrices_on_added_generator"), "）、", math(String.raw`\Psi':B\times B\to A'`), " を ", math(String.raw`\Psi'((F,G)):=j(\Psi(F))\cdot_{A'}e_{+}+_{A'}j(\Psi(G))\cdot_{A'}e_{-}`), "、", math(String.raw`e_{\pm}:=h\ast_{A'}(1_{A'}+_{A'}(\pm1_{\mathbb{C}})\ast_{A'}z)`), " で定める写像（", ref("def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra"), "、", ref("def_idempotents_of_odd_dimensional_clifford_algebra"), "）とする。このとき次が成り立つ。"]),
      list([[math(String.raw`\Phi'`), " と ", math(String.raw`\Psi'`), " はどちらも ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。"], ["すべての ", math(String.raw`a\in A'`), " について ", math(String.raw`\Psi'(\Phi'(a))=a`), " であり、すべての ", math(String.raw`F,G\in B`), " について ", math(String.raw`\Phi'(\Psi'((F,G)))=(F,G)`), " である。"]]),
      paragraph(["したがって ", math(String.raw`\Phi'`), " は全単射であり、その逆写像は ", math(String.raw`\Psi'`), " である。"]),
    ],
    proof: [
      paragraph([math(String.raw`\Phi'`), " は ℂ-代数の準同型であり（", ref("def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras"), "）、", math(String.raw`\Psi'`), " も ℂ-代数の準同型である（", ref("claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism"), "）。二つの等式は ", ref("claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity"), " と ", ref("claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity"), " である。"]),
      paragraph(["単射であること。", math(String.raw`a,a'\in A'`), " が ", math(String.raw`\Phi'(a)=\Phi'(a')`), " を満たすとする。"]),
      displayMath(String.raw`\begin{aligned}
a
&=\Psi'\bigl(\Phi'(a)\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity}\right)\\
&=\Psi'\bigl(\Phi'(a')\bigr)
&&\left(\because\ \Phi'(a)=\Phi'(a')\right)\\
&=a'
&&\left(\because\ \blkref{claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity}\right).
\end{aligned}`),
      paragraph(["全射であること。", math(String.raw`(F,G)\in B\times B`), " について ", math(String.raw`\Psi'((F,G))`), " は ", math(String.raw`\Phi'(\Psi'((F,G)))=(F,G)`), " を満たす。したがって ", math(String.raw`\Phi'`), " は全単射である。", math(String.raw`\Phi'`), " の逆写像を ", math(String.raw`\Phi'^{-1}`), "（", math(String.raw`(F,G)`), " に ", math(String.raw`\Phi'(a)=(F,G)`), " を満たすただ一つの ", math(String.raw`a`), " を与える写像）とすると、", math(String.raw`\Psi'((F,G))`), " はこの条件を満たすので、", math(String.raw`\Phi'^{-1}((F,G))=\Psi'((F,G))`), " である。"]),
    ],
  },
  {
    id: "isomorphism_jordan_wigner_matrices_heading",
    kind: "heading",
    level: 2,
    title: { text: "系：複素行列版イジングの Jordan–Wigner 行列への接続" },
    labels: [],
  },
  {
    id: "isomorphism_definition_pauli_matrix_x",
    kind: "definition",
    title: { text: "Pauli 行列 σx", tex: String.raw`\text{Pauli 行列 }\sigma^{x}` },
    labels: ["def_pauli_matrix_x"],
    statement: [
      paragraph([
        math(String.raw`(2,\mathrm{id}_2)`), "（", math(String.raw`\mathrm{id}_2`), " は恒等写像）は ", math(String.raw`\{1,2\}`), " の番号付けなので、", math(String.raw`\{1,2\}`), " は有限集合である（", ref("def_numbering_of_finite_set"), "）。", math(String.raw`\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`),
        "（", ref("def_matrices_indexed_by_finite_set"), "）の元 ", math(String.raw`\sigma^{x}`), " を、成分で次のように定める。",
      ]),
      displayMath(String.raw`(\sigma^{x})_{1,1}:=0_{\mathbb{C}},\quad(\sigma^{x})_{1,2}:=1_{\mathbb{C}},\quad(\sigma^{x})_{2,1}:=1_{\mathbb{C}},\quad(\sigma^{x})_{2,2}:=0_{\mathbb{C}}`),
    ],
  },
  {
    id: "isomorphism_definition_pauli_matrix_y",
    kind: "definition",
    title: { text: "Pauli 行列 σy", tex: String.raw`\text{Pauli 行列 }\sigma^{y}` },
    labels: ["def_pauli_matrix_y"],
    statement: [
      paragraph([
        math(String.raw`\mathrm{i}\in\mathbb{C}`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " の元（", math(String.raw`\mathrm{i}\cdot_{\mathbb{C}}\mathrm{i}=-_{\mathbb{C}}1_{\mathbb{C}}`),
        "）とする。", math(String.raw`\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " の元 ", math(String.raw`\sigma^{y}`), " を、成分で次のように定める。",
      ]),
      displayMath(String.raw`(\sigma^{y})_{1,1}:=0_{\mathbb{C}},\quad(\sigma^{y})_{1,2}:=-_{\mathbb{C}}\mathrm{i},\quad(\sigma^{y})_{2,1}:=\mathrm{i},\quad(\sigma^{y})_{2,2}:=0_{\mathbb{C}}`),
    ],
  },
  {
    id: "isomorphism_definition_pauli_matrix_z",
    kind: "definition",
    title: { text: "Pauli 行列 σz", tex: String.raw`\text{Pauli 行列 }\sigma^{z}` },
    labels: ["def_pauli_matrix_z"],
    statement: [
      paragraph([
        math(String.raw`\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " の元 ", math(String.raw`\sigma^{z}`), " を、成分で次のように定める。",
        math(String.raw`-_{\mathbb{C}}1_{\mathbb{C}}`), " は ", math(String.raw`1_{\mathbb{C}}`), " の加法の逆元である。",
      ]),
      displayMath(String.raw`(\sigma^{z})_{1,1}:=1_{\mathbb{C}},\quad(\sigma^{z})_{1,2}:=0_{\mathbb{C}},\quad(\sigma^{z})_{2,1}:=0_{\mathbb{C}},\quad(\sigma^{z})_{2,2}:=-_{\mathbb{C}}1_{\mathbb{C}}`),
    ],
  },
  {
    id: "isomorphism_definition_matrix_exchanging_pauli_z_and_x",
    kind: "definition",
    title: { text: "σz と σx を入れ替える行列 K", tex: String.raw`\sigma^{z}\text{ と }\sigma^{x}\text{ を入れ替える行列 K}` },
    labels: ["def_matrix_exchanging_pauli_z_and_x"],
    statement: [
      paragraph([math(String.raw`\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " の元 ", math(String.raw`K`), " を、成分で次のように定める。"]),
      displayMath(String.raw`K_{1,1}:=1_{\mathbb{C}},\quad K_{1,2}:=1_{\mathbb{C}},\quad K_{2,1}:=1_{\mathbb{C}},\quad K_{2,2}:=-_{\mathbb{C}}1_{\mathbb{C}}`),
    ],
  },
  {
    id: "isomorphism_definition_half_of_matrix_exchanging_pauli_z_and_x",
    kind: "definition",
    title: { text: "K の各成分に h を掛けた行列 K'" },
    labels: ["def_half_of_matrix_exchanging_pauli_z_and_x"],
    statement: [
      paragraph([
        math(String.raw`h=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\in\mathbb{C}`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " の元とする。",
        math(String.raw`\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " の元 ", math(String.raw`K'`), " を、成分で次のように定める。",
      ]),
      displayMath(String.raw`K'_{1,1}:=h,\quad K'_{1,2}:=h,\quad K'_{2,1}:=h,\quad K'_{2,2}:=-_{\mathbb{C}}h`),
    ],
  },
  {
    id: "isomorphism_claim_entries_of_combination_of_off_diagonal_matrix_units",
    kind: "claim",
    title: { text: "{1,2} で添字づけた二つの非対角の行列単位の線型結合の成分" },
    labels: ["claim_entries_of_combination_of_off_diagonal_matrix_units"],
    statement: [
      paragraph([
        math(String.raw`E_{2,1},E_{1,2}\in\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " を行列単位（", ref("def_matrix_unit"), "）とし、", math(String.raw`\lambda,\lambda'\in\mathbb{C}`), "、",
        math(String.raw`D:=(\lambda\ast_{\mathrm{Mat}_{\{1,2\}}}E_{2,1})+_{\mathrm{Mat}_{\{1,2\}}}(\lambda'\ast_{\mathrm{Mat}_{\{1,2\}}}E_{1,2})`), " とする。次が成り立つ。",
      ]),
      displayMath(String.raw`D_{1,1}=0_{\mathbb{C}},\quad D_{1,2}=\lambda',\quad D_{2,1}=\lambda,\quad D_{2,2}=0_{\mathbb{C}}`),
    ],
    proof: [
      paragraph([
        math(String.raw`a,b\in\{1,2\}`), " について、行列の和とスカラー倍（", ref("def_matrices_indexed_by_finite_set"), "）と行列単位の成分（", ref("def_matrix_unit"), "）から次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
D_{a,b}
&=\bigl(\lambda\cdot_{\mathbb{C}}(E_{2,1})_{a,b}\bigr)+_{\mathbb{C}}\bigl(\lambda'\cdot_{\mathbb{C}}(E_{1,2})_{a,b}\bigr)
&&\left(\because\ \blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl(\lambda\cdot_{\mathbb{C}}(\delta_{2,a}\cdot_{\mathbb{C}}\delta_{1,b})\bigr)+_{\mathbb{C}}\bigl(\lambda'\cdot_{\mathbb{C}}(\delta_{1,a}\cdot_{\mathbb{C}}\delta_{2,b})\bigr)
&&\left(\because\ \blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph(["四つの成分は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
D_{1,1}
&=\bigl(\lambda\cdot_{\mathbb{C}}(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\bigr)+_{\mathbb{C}}\bigl(\lambda'\cdot_{\mathbb{C}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}})\bigr)
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right),\\[4pt]
D_{1,2}
&=\bigl(\lambda\cdot_{\mathbb{C}}(0_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}})\bigr)+_{\mathbb{C}}\bigl(\lambda'\cdot_{\mathbb{C}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=\lambda'
&&\left(\because\ \mathbb{C}\ \text{の四則}\right),\\[4pt]
D_{2,1}
&=\bigl(\lambda\cdot_{\mathbb{C}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\bigr)+_{\mathbb{C}}\bigl(\lambda'\cdot_{\mathbb{C}}(0_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}})\bigr)
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=\lambda
&&\left(\because\ \mathbb{C}\ \text{の四則}\right),\\[4pt]
D_{2,2}
&=\bigl(\lambda\cdot_{\mathbb{C}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}})\bigr)+_{\mathbb{C}}\bigl(\lambda'\cdot_{\mathbb{C}}(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity",
    kind: "claim",
    title: { text: "K に右から K' を掛けると単位行列になる" },
    labels: ["claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity"],
    statement: [
      paragraph([
        math(String.raw`K`), " を ", ref("def_matrix_exchanging_pauli_z_and_x"), "、", math(String.raw`K'`), " を ", ref("def_half_of_matrix_exchanging_pauli_z_and_x"),
        " の行列とする。", math(String.raw`K\cdot_{\mathrm{Mat}_{\{1,2\}}}K'=1_{\mathrm{Mat}_{\{1,2\}}}`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
h+_{\mathbb{C}}h
&=(1_{\mathbb{C}}\cdot_{\mathbb{C}}h)+_{\mathbb{C}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}h)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ h=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\text{。}\blkref{def_setting_of_general_even_dimensional_corollary}\right).
\end{aligned}`),
      paragraph([
        "四つの成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}K'\bigr)_{1,1}
&=\bigl((K)_{1,1}\cdot_{\mathbb{C}}(K')_{1,1}\bigr)+_{\mathbb{C}}\bigl((K)_{1,2}\cdot_{\mathbb{C}}(K')_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}h\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}h\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_half_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=h+_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \text{準備の}\ h+_{\mathbb{C}}h=1_{\mathbb{C}}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}K'\bigr)_{1,2}
&=\bigl((K)_{1,1}\cdot_{\mathbb{C}}(K')_{1,2}\bigr)+_{\mathbb{C}}\bigl((K)_{1,2}\cdot_{\mathbb{C}}(K')_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}h\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}(-_{\mathbb{C}}h)\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_half_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}K'\bigr)_{2,1}
&=\bigl((K)_{2,1}\cdot_{\mathbb{C}}(K')_{1,1}\bigr)+_{\mathbb{C}}\bigl((K)_{2,2}\cdot_{\mathbb{C}}(K')_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}h\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}h\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_half_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}K'\bigr)_{2,2}
&=\bigl((K)_{2,1}\cdot_{\mathbb{C}}(K')_{1,2}\bigr)+_{\mathbb{C}}\bigl((K)_{2,2}\cdot_{\mathbb{C}}(K')_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}h\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}(-_{\mathbb{C}}h)\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_half_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=h+_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \text{準備の}\ h+_{\mathbb{C}}h=1_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "四つの成分は単位行列の成分 ", math(String.raw`\delta_{1,1}=\delta_{2,2}=1_{\mathbb{C}}`), "、", math(String.raw`\delta_{1,2}=\delta_{2,1}=0_{\mathbb{C}}`), " に等しいので（", ref("def_kronecker_delta"), "）、主張の二つの行列は等しい（", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_half_times_matrix_exchanging_pauli_matrices_is_identity",
    kind: "claim",
    title: { text: "K に左から K' を掛けると単位行列になる" },
    labels: ["claim_half_times_matrix_exchanging_pauli_matrices_is_identity"],
    statement: [
      paragraph([
        math(String.raw`K`), " を ", ref("def_matrix_exchanging_pauli_z_and_x"), "、", math(String.raw`K'`), " を ", ref("def_half_of_matrix_exchanging_pauli_z_and_x"),
        " の行列とする。", math(String.raw`K'\cdot_{\mathrm{Mat}_{\{1,2\}}}K=1_{\mathrm{Mat}_{\{1,2\}}}`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
h+_{\mathbb{C}}h
&=(1_{\mathbb{C}}\cdot_{\mathbb{C}}h)+_{\mathbb{C}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}h)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ h=(1_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}})^{-1}\text{。}\blkref{def_setting_of_general_even_dimensional_corollary}\right).
\end{aligned}`),
      paragraph([
        "四つの成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(K'\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{1,1}
&=\bigl((K')_{1,1}\cdot_{\mathbb{C}}(K)_{1,1}\bigr)+_{\mathbb{C}}\bigl((K')_{1,2}\cdot_{\mathbb{C}}(K)_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(h\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(h\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_half_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=h+_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \text{準備の}\ h+_{\mathbb{C}}h=1_{\mathbb{C}}\right),\\[4pt]
\bigl(K'\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{1,2}
&=\bigl((K')_{1,1}\cdot_{\mathbb{C}}(K)_{1,2}\bigr)+_{\mathbb{C}}\bigl((K')_{1,2}\cdot_{\mathbb{C}}(K)_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(h\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(h\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_half_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right),\\[4pt]
\bigl(K'\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{2,1}
&=\bigl((K')_{2,1}\cdot_{\mathbb{C}}(K)_{1,1}\bigr)+_{\mathbb{C}}\bigl((K')_{2,2}\cdot_{\mathbb{C}}(K)_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(h\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}h)\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_half_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right),\\[4pt]
\bigl(K'\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{2,2}
&=\bigl((K')_{2,1}\cdot_{\mathbb{C}}(K)_{1,2}\bigr)+_{\mathbb{C}}\bigl((K')_{2,2}\cdot_{\mathbb{C}}(K)_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(h\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}h)\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_half_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=h+_{\mathbb{C}}h
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \text{準備の}\ h+_{\mathbb{C}}h=1_{\mathbb{C}}\right).
\end{aligned}`),
      paragraph([
        "四つの成分は単位行列の成分 ", math(String.raw`\delta_{1,1}=\delta_{2,2}=1_{\mathbb{C}}`), "、", math(String.raw`\delta_{1,2}=\delta_{2,1}=0_{\mathbb{C}}`), " に等しいので（", ref("def_kronecker_delta"), "）、主張の二つの行列は等しい（", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_matrix_k_turns_pauli_z_into_pauli_x",
    kind: "claim",
    title: { text: "K に右から z の Pauli 行列を掛けたものは、K に左から x の Pauli 行列を掛けたものに等しい" },
    labels: ["claim_matrix_k_turns_pauli_z_into_pauli_x"],
    statement: [
      paragraph([
        math(String.raw`K`), " を ", ref("def_matrix_exchanging_pauli_z_and_x"), "、", math(String.raw`\sigma^{x}`), " を ", ref("def_pauli_matrix_x"), "、", math(String.raw`\sigma^{z}`), " を ",
        ref("def_pauli_matrix_z"), " の行列とする。", math(String.raw`K\cdot_{\mathrm{Mat}_{\{1,2\}}}\sigma^{z}=\sigma^{x}\cdot_{\mathrm{Mat}_{\{1,2\}}}K`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}\sigma^{z}\bigr)_{1,1}
&=\bigl((K)_{1,1}\cdot_{\mathbb{C}}(\sigma^{z})_{1,1}\bigr)+_{\mathbb{C}}\bigl((K)_{1,2}\cdot_{\mathbb{C}}(\sigma^{z})_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_pauli_matrix_z}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{x})_{1,1}\cdot_{\mathbb{C}}(K)_{1,1}\bigr)+_{\mathbb{C}}\bigl((\sigma^{x})_{1,2}\cdot_{\mathbb{C}}(K)_{2,1}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_x}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{x}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{1,1}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}\sigma^{z}\bigr)_{1,2}
&=\bigl((K)_{1,1}\cdot_{\mathbb{C}}(\sigma^{z})_{1,2}\bigr)+_{\mathbb{C}}\bigl((K)_{1,2}\cdot_{\mathbb{C}}(\sigma^{z})_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_pauli_matrix_z}\right)\\
&=-_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{x})_{1,1}\cdot_{\mathbb{C}}(K)_{1,2}\bigr)+_{\mathbb{C}}\bigl((\sigma^{x})_{1,2}\cdot_{\mathbb{C}}(K)_{2,2}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_x}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{x}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{1,2}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}\sigma^{z}\bigr)_{2,1}
&=\bigl((K)_{2,1}\cdot_{\mathbb{C}}(\sigma^{z})_{1,1}\bigr)+_{\mathbb{C}}\bigl((K)_{2,2}\cdot_{\mathbb{C}}(\sigma^{z})_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_pauli_matrix_z}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{x})_{2,1}\cdot_{\mathbb{C}}(K)_{1,1}\bigr)+_{\mathbb{C}}\bigl((\sigma^{x})_{2,2}\cdot_{\mathbb{C}}(K)_{2,1}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_x}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{x}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{2,1}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}\sigma^{z}\bigr)_{2,2}
&=\bigl((K)_{2,1}\cdot_{\mathbb{C}}(\sigma^{z})_{1,2}\bigr)+_{\mathbb{C}}\bigl((K)_{2,2}\cdot_{\mathbb{C}}(\sigma^{z})_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\text{、}\blkref{def_pauli_matrix_z}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{x})_{2,1}\cdot_{\mathbb{C}}(K)_{1,2}\bigr)+_{\mathbb{C}}\bigl((\sigma^{x})_{2,2}\cdot_{\mathbb{C}}(K)_{2,2}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_x}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{x}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{2,2}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right).
\end{aligned}`),
      paragraph([
        "四つの成分がすべて等しいので、二つの行列は等しい（", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z",
    kind: "claim",
    title: { text: "K に右から二つの非対角の行列単位の和を掛けたものは、K に左から z の Pauli 行列を掛けたものに等しい" },
    labels: ["claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z"],
    statement: [
      paragraph([
        math(String.raw`K`), " を ", ref("def_matrix_exchanging_pauli_z_and_x"), "、", math(String.raw`\sigma^{z}`), " を ", ref("def_pauli_matrix_z"), " の行列、",
        math(String.raw`E_{2,1},E_{1,2}\in\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " を行列単位（", ref("def_matrix_unit"), "）とし、", math(String.raw`G`), " を次で置く。",
      ]),
      displayMath(String.raw`G:=(1_{\mathbb{C}}\ast_{\mathrm{Mat}_{\{1,2\}}}E_{2,1})+_{\mathrm{Mat}_{\{1,2\}}}(1_{\mathbb{C}}\ast_{\mathrm{Mat}_{\{1,2\}}}E_{1,2})`),
      paragraph([
        "このとき ", math(String.raw`K\cdot_{\mathrm{Mat}_{\{1,2\}}}G=\sigma^{z}\cdot_{\mathrm{Mat}_{\{1,2\}}}K`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、", ref("claim_entries_of_combination_of_off_diagonal_matrix_units"), " を ", math(String.raw`\lambda=\lambda'=1_{\mathbb{C}}`), " で当てると、", math(String.raw`G`), " の成分は ", math(String.raw`G_{1,1}=G_{2,2}=0_{\mathbb{C}}`), "、", math(String.raw`G_{1,2}=G_{2,1}=1_{\mathbb{C}}`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}G\bigr)_{1,1}
&=\bigl((K)_{1,1}\cdot_{\mathbb{C}}(G)_{1,1}\bigr)+_{\mathbb{C}}\bigl((K)_{1,2}\cdot_{\mathbb{C}}(G)_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\ \text{と}\ G\ \text{の成分}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{z})_{1,1}\cdot_{\mathbb{C}}(K)_{1,1}\bigr)+_{\mathbb{C}}\bigl((\sigma^{z})_{1,2}\cdot_{\mathbb{C}}(K)_{2,1}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_z}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{z}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{1,1}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}G\bigr)_{1,2}
&=\bigl((K)_{1,1}\cdot_{\mathbb{C}}(G)_{1,2}\bigr)+_{\mathbb{C}}\bigl((K)_{1,2}\cdot_{\mathbb{C}}(G)_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\ \text{と}\ G\ \text{の成分}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{z})_{1,1}\cdot_{\mathbb{C}}(K)_{1,2}\bigr)+_{\mathbb{C}}\bigl((\sigma^{z})_{1,2}\cdot_{\mathbb{C}}(K)_{2,2}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_z}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{z}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{1,2}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}G\bigr)_{2,1}
&=\bigl((K)_{2,1}\cdot_{\mathbb{C}}(G)_{1,1}\bigr)+_{\mathbb{C}}\bigl((K)_{2,2}\cdot_{\mathbb{C}}(G)_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\ \text{と}\ G\ \text{の成分}\right)\\
&=-_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{z})_{2,1}\cdot_{\mathbb{C}}(K)_{1,1}\bigr)+_{\mathbb{C}}\bigl((\sigma^{z})_{2,2}\cdot_{\mathbb{C}}(K)_{2,1}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_z}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{z}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{2,1}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}G\bigr)_{2,2}
&=\bigl((K)_{2,1}\cdot_{\mathbb{C}}(G)_{1,2}\bigr)+_{\mathbb{C}}\bigl((K)_{2,2}\cdot_{\mathbb{C}}(G)_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\ \text{と}\ G\ \text{の成分}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{z})_{2,1}\cdot_{\mathbb{C}}(K)_{1,2}\bigr)+_{\mathbb{C}}\bigl((\sigma^{z})_{2,2}\cdot_{\mathbb{C}}(K)_{2,2}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_z}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{z}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{2,2}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right).
\end{aligned}`),
      paragraph([
        "四つの成分がすべて等しいので、二つの行列は等しい（", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y",
    kind: "claim",
    title: { text: "K に右から二つの非対角の行列単位の虚数倍の和を掛けたものは、K に左から y の Pauli 行列を掛けたものに等しい" },
    labels: ["claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y"],
    statement: [
      paragraph([
        math(String.raw`K`), " を ", ref("def_matrix_exchanging_pauli_z_and_x"), "、", math(String.raw`\sigma^{y}`), " を ", ref("def_pauli_matrix_y"), " の行列、",
        math(String.raw`\mathrm{i}`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " の元、", math(String.raw`E_{2,1},E_{1,2}\in\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`),
        " を行列単位（", ref("def_matrix_unit"), "）とし、", math(String.raw`G'`), " を次で置く。",
      ]),
      displayMath(String.raw`G':=\bigl((-_{\mathbb{C}}\mathrm{i})\ast_{\mathrm{Mat}_{\{1,2\}}}E_{2,1}\bigr)+_{\mathrm{Mat}_{\{1,2\}}}(\mathrm{i}\ast_{\mathrm{Mat}_{\{1,2\}}}E_{1,2})`),
      paragraph([
        "このとき ", math(String.raw`K\cdot_{\mathrm{Mat}_{\{1,2\}}}G'=\sigma^{y}\cdot_{\mathrm{Mat}_{\{1,2\}}}K`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、", ref("claim_entries_of_combination_of_off_diagonal_matrix_units"), " を ", math(String.raw`\lambda=-_{\mathbb{C}}\mathrm{i}`), "、", math(String.raw`\lambda'=\mathrm{i}`), " で当てると、", math(String.raw`G'`), " の成分は ", math(String.raw`G'_{1,1}=G'_{2,2}=0_{\mathbb{C}}`), "、", math(String.raw`G'_{1,2}=\mathrm{i}`), "、", math(String.raw`G'_{2,1}=-_{\mathbb{C}}\mathrm{i}`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}G'\bigr)_{1,1}
&=\bigl((K)_{1,1}\cdot_{\mathbb{C}}(G')_{1,1}\bigr)+_{\mathbb{C}}\bigl((K)_{1,2}\cdot_{\mathbb{C}}(G')_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\ \text{と}\ G'\ \text{の成分}\right)\\
&=-_{\mathbb{C}}\mathrm{i}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{y})_{1,1}\cdot_{\mathbb{C}}(K)_{1,1}\bigr)+_{\mathbb{C}}\bigl((\sigma^{y})_{1,2}\cdot_{\mathbb{C}}(K)_{2,1}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_y}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{y}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{1,1}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}G'\bigr)_{1,2}
&=\bigl((K)_{1,1}\cdot_{\mathbb{C}}(G')_{1,2}\bigr)+_{\mathbb{C}}\bigl((K)_{1,2}\cdot_{\mathbb{C}}(G')_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}\mathrm{i}\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\ \text{と}\ G'\ \text{の成分}\right)\\
&=\mathrm{i}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{y})_{1,1}\cdot_{\mathbb{C}}(K)_{1,2}\bigr)+_{\mathbb{C}}\bigl((\sigma^{y})_{1,2}\cdot_{\mathbb{C}}(K)_{2,2}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_y}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{y}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{1,2}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}G'\bigr)_{2,1}
&=\bigl((K)_{2,1}\cdot_{\mathbb{C}}(G')_{1,1}\bigr)+_{\mathbb{C}}\bigl((K)_{2,2}\cdot_{\mathbb{C}}(G')_{2,1}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}(-_{\mathbb{C}}\mathrm{i})\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\ \text{と}\ G'\ \text{の成分}\right)\\
&=\mathrm{i}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(\mathrm{i}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{y})_{2,1}\cdot_{\mathbb{C}}(K)_{1,1}\bigr)+_{\mathbb{C}}\bigl((\sigma^{y})_{2,2}\cdot_{\mathbb{C}}(K)_{2,1}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_y}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{y}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{2,1}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right),\\[4pt]
\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}G'\bigr)_{2,2}
&=\bigl((K)_{2,1}\cdot_{\mathbb{C}}(G')_{1,2}\bigr)+_{\mathbb{C}}\bigl((K)_{2,2}\cdot_{\mathbb{C}}(G')_{2,2}\bigr)
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}\mathrm{i}\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_matrix_exchanging_pauli_z_and_x}\ \text{と}\ G'\ \text{の成分}\right)\\
&=\mathrm{i}
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl(\mathrm{i}\cdot_{\mathbb{C}}1_{\mathbb{C}}\bigr)+_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の四則}\right)\\
&=\bigl((\sigma^{y})_{2,1}\cdot_{\mathbb{C}}(K)_{1,2}\bigr)+_{\mathbb{C}}\bigl((\sigma^{y})_{2,2}\cdot_{\mathbb{C}}(K)_{2,2}\bigr)
&&\left(\because\ \text{成分の代入。}\blkref{def_pauli_matrix_y}\text{、}\blkref{def_matrix_exchanging_pauli_z_and_x}\right)\\
&=\bigl(\sigma^{y}\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)_{2,2}
&&\left(\because\ \blkref{claim_entry_of_product_of_matrices_indexed_by_two_element_set}\right).
\end{aligned}`),
      paragraph([
        "四つの成分がすべて等しいので、二つの行列は等しい（", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count",
    kind: "claim",
    title: { text: "z の Pauli 行列の対角成分を番号より前まで掛けた部分の積は、番号より小さい元の個数の符号である" },
    labels: ["claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`T\in\mathcal{P}_M`), "（", ref("def_power_set_of_first_m_positive_integers"), "）、",
        math(String.raw`i\in\{1,\dots,M\}`), " とし、", math(String.raw`\sigma^{z}`), " を ", ref("def_pauli_matrix_z"), " の行列、", math(String.raw`o_T(k)`), " を ",
        ref("def_membership_index_of_subset"), " の添字とする。", math(String.raw`\{1,\dots,M\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`\mathbb{C}`),
        " の元 ", math(String.raw`\alpha_k`), " が与えられていて、すべての ", math(String.raw`k\in\{1,\dots,i-1\}`), " について ",
        math(String.raw`\alpha_k=(\sigma^{z})_{o_T(k),o_T(k)}`), " であるとする。番号順の積の定義（", ref("def_ordered_product_in_complex_numbers"),
        "）が族 ", math(String.raw`\alpha_1,\dots,\alpha_M`), " について帰納的に定める元を ", math(String.raw`P_m`), "（", math(String.raw`m\in\{0,1,\dots,M\}`),
        "）と書く。このとき次が成り立つ（", math(String.raw`N_i(T)`), " は ", ref("def_count_of_subset_elements_below_index"), "、", math(String.raw`\varsigma`), " は ",
        ref("def_sign_of_nonnegative_integer"), "）。",
      ]),
      displayMath(String.raw`P_{i-1}=\varsigma\bigl(N_i(T)\bigr)`),
    ],
    proof: [
      paragraph([
        math(String.raw`i`), " についての帰納法で示す。", math(String.raw`i=1`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
P_0
&=1_{\mathbb{C}}
&&\left(\because\ \blkref{def_ordered_product_in_complex_numbers}\right)\\
&=\varsigma(0)
&&\left(\because\ \blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma\bigl(N_1(T)\bigr)
&&\left(\because\ N_1(T)=0\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`i\in\{2,\dots,M\}`), " とし、", math(String.raw`i-1`), " で主張が成り立つとする（帰納法の仮定）。", math(String.raw`\alpha`), " についての仮定は ",
        math(String.raw`k\in\{1,\dots,i-2\}`), " でも成り立つので、帰納法の仮定から ", math(String.raw`P_{i-2}=\varsigma(N_{i-1}(T))`), " である。", math(String.raw`i-1\in T`),
        " のとき、", math(String.raw`o_T(i-1)=2`), " であり（", ref("def_membership_index_of_subset"), "）、",
      ]),
      displayMath(String.raw`\begin{aligned}
P_{i-1}
&=P_{i-2}\cdot_{\mathbb{C}}\alpha_{i-1}
&&\left(\because\ \blkref{def_ordered_product_in_complex_numbers}\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)\cdot_{\mathbb{C}}\alpha_{i-1}
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)\cdot_{\mathbb{C}}(\sigma^{z})_{o_T(i-1),o_T(i-1)}
&&\left(\because\ \alpha\ \text{の仮定で}\ k:=i-1\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)\cdot_{\mathbb{C}}(\sigma^{z})_{2,2}
&&\left(\because\ o_T(i-1)=2\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)\cdot_{\mathbb{C}}(-_{\mathbb{C}}1_{\mathbb{C}})
&&\left(\because\ \blkref{def_pauli_matrix_z}\right)\\
&=(-_{\mathbb{C}}1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma\bigl(N_{i-1}(T)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(-1_{\mathbb{C}})\cdot_{\mathbb{C}}\varsigma\bigl(N_{i-1}(T)\bigr)
&&\left(\because\ -_{\mathbb{C}}1_{\mathbb{C}}\ \text{と}\ -1_{\mathbb{C}}\ \text{はどちらも}\ 1_{\mathbb{C}}\ \text{の加法の逆元}\right)\\
&=\varsigma\bigl(N_{i-1}(T)+1\bigr)
&&\left(\because\ N_{i-1}(T)+1\ge 1\text{。}\blkref{def_sign_of_nonnegative_integer}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)
&&\left(\because\ i-1\in T\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
      paragraph([math(String.raw`i-1\notin T`), " のとき、", math(String.raw`o_T(i-1)=1`), " であり（", ref("def_membership_index_of_subset"), "）、"]),
      displayMath(String.raw`\begin{aligned}
P_{i-1}
&=P_{i-2}\cdot_{\mathbb{C}}\alpha_{i-1}
&&\left(\because\ \blkref{def_ordered_product_in_complex_numbers}\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)\cdot_{\mathbb{C}}\alpha_{i-1}
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)\cdot_{\mathbb{C}}(\sigma^{z})_{o_T(i-1),o_T(i-1)}
&&\left(\because\ \alpha\ \text{の仮定で}\ k:=i-1\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)\cdot_{\mathbb{C}}(\sigma^{z})_{1,1}
&&\left(\because\ o_T(i-1)=1\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \blkref{def_pauli_matrix_z}\right)\\
&=\varsigma\bigl(N_{i-1}(T)\bigr)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\varsigma\bigl(N_i(T)\bigr)
&&\left(\because\ i-1\notin T\text{。}\blkref{def_count_of_subset_elements_below_index}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_creation_operator_matrix_is_kronecker_product",
    kind: "claim",
    title: { text: "生成作用素の行列は、z の Pauli 行列・行列単位・単位行列のクロネッカー積である" },
    labels: ["claim_creation_operator_matrix_is_kronecker_product"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`m\in\{1,\dots,M\}`), " とし、", math(String.raw`c_m`), " を生成作用素の行列（", ref("def_creation_operator_matrix"),
        "）、", math(String.raw`\sigma^{z}`), " を ", ref("def_pauli_matrix_z"), " の行列、", math(String.raw`E_{2,1}\in\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " を行列単位（",
        ref("def_matrix_unit"), "）、", math(String.raw`I_2:=1_{\mathrm{Mat}_{\{1,2\}}}`), " とする。", math(String.raw`k\in\{1,\dots,M\}`), " について ",
        math(String.raw`\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " の元 ", math(String.raw`A_k`), " を次で置く。",
      ]),
      displayMath(String.raw`A_k:=
\begin{cases}
  \sigma^{z} & (k<m),\\
  E_{2,1} & (k=m),\\
  I_2 & (k>m).
\end{cases}`),
      paragraph(["クロネッカー積（", ref("def_kronecker_product_indexed_by_power_set"), "）について次が成り立つ。"]),
      displayMath(String.raw`c_m=\mathop{\boxtimes}\limits_{k=1}^{M}A_k`),
    ],
    proof: [
      paragraph([
        math(String.raw`S,T\in\mathcal{P}_M`), " を任意に固定し、", math(String.raw`\alpha_k:=(A_k)_{o_S(k),o_T(k)}`), " と置く。番号順の積の定義（",
        ref("def_ordered_product_in_complex_numbers"), "）が族 ", math(String.raw`\alpha_1,\dots,\alpha_M`), " について定める元を ", math(String.raw`P_j`), " と書く。",
        math(String.raw`(\mathop{\boxtimes}_{k}A_k)_{S,T}=\prod_{\mathbb{C},\,k=1}^{M}\alpha_k`), " である（", ref("def_kronecker_product_indexed_by_power_set"), "）。準備として、",
        math(String.raw`a,b\in\{1,2\}`), "、", math(String.raw`a\neq b`), " ならば ", math(String.raw`(\sigma^{z})_{a,b}=0_{\mathbb{C}}`), "（", ref("def_pauli_matrix_z"), "）、",
        math(String.raw`(I_2)_{a,b}=\delta_{a,b}`), "（", ref("def_matrices_indexed_by_finite_set"), "）かつ ", math(String.raw`\delta_{a,b}=0_{\mathbb{C}}`), "（", ref("def_kronecker_delta"), "）であり、",
        math(String.raw`(E_{2,1})_{a,b}=\delta_{2,a}\cdot_{\mathbb{C}}\delta_{1,b}`), " である（", ref("def_matrix_unit"), "）。",
        "生成作用素の行列の定義（", ref("def_creation_operator_matrix"), "）の二つの場合に分ける。",
      ]),
      paragraph([
        "（", math(String.raw`m\notin T`), " かつ ", math(String.raw`S=T\cup\{m\}`), " の場合）", math(String.raw`(c_m)_{S,T}=\varsigma(N_m(T))`), " である。",
        math(String.raw`k\neq m`), " なら、", math(String.raw`k\in S`), " と ", math(String.raw`k\in T`), " は同値なので ", math(String.raw`o_S(k)=o_T(k)`), " であり（",
        ref("def_membership_index_of_subset"), "）、", math(String.raw`m\in S`), "、", math(String.raw`m\notin T`), " なので ", math(String.raw`o_S(m)=2`), "、",
        math(String.raw`o_T(m)=1`), " である。したがって ", math(String.raw`k<m`), " なら ", math(String.raw`\alpha_k=(\sigma^{z})_{o_T(k),o_T(k)}`), "、",
        math(String.raw`k>m`), " なら ", math(String.raw`\alpha_k=\delta_{o_T(k),o_T(k)}=1_{\mathbb{C}}`), "（", ref("def_kronecker_delta"), "）であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\alpha_m
&=(E_{2,1})_{2,1}
&&\left(\because\ o_S(m)=2,\ o_T(m)=1\right)\\
&=\delta_{2,2}\cdot_{\mathbb{C}}\delta_{1,1}
&&\left(\because\ \blkref{def_matrix_unit}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \blkref{def_kronecker_delta}\right)\\
&=1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\prod_{\mathbb{C},\,k=1}^{M}\alpha_k
&=P_m
&&\left(\because\ k>m\ \text{で}\ \alpha_k=1_{\mathbb{C}}\text{、}r:=m\text{。}\blkref{claim_ordered_product_with_unit_factors_after_index}\right)\\
&=P_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ \blkref{def_ordered_product_in_complex_numbers}\right)\\
&=P_{m-1}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ \text{上の式}\right)\\
&=P_{m-1}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\varsigma\bigl(N_m(T)\bigr)
&&\left(\because\ k<m\ \text{で}\ \alpha_k=(\sigma^{z})_{o_T(k),o_T(k)}\text{、}i:=m\text{。}\blkref{claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count}\right)\\
&=(c_m)_{S,T}
&&\left(\because\ \blkref{def_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        "（それ以外の場合）", math(String.raw`(c_m)_{S,T}=0_{\mathbb{C}}`), " である（", ref("def_creation_operator_matrix"), "）。", math(String.raw`\alpha_r=0_{\mathbb{C}}`),
        " となる ", math(String.raw`r\in\{1,\dots,M\}`), " があれば、次のとおり成分が一致する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\mathbb{C},\,k=1}^{M}\alpha_k
&=0_{\mathbb{C}}
&&\left(\because\ \alpha_r=0_{\mathbb{C}}\text{。}\blkref{claim_ordered_product_with_zero_factor_is_zero}\right)\\
&=(c_m)_{S,T}
&&\left(\because\ \text{それ以外の場合。}\blkref{def_creation_operator_matrix}\right).
\end{aligned}`),
      paragraph([
        "そのような ", math(String.raw`r`), " があることを、三つの場合に分けて示す。",
      ]),
      list([
        [
          math(String.raw`m\in T`), " のとき、", math(String.raw`o_T(m)=2`), " なので ", math(String.raw`\alpha_m=\delta_{2,o_S(m)}\cdot_{\mathbb{C}}\delta_{1,2}`), " であり、",
          math(String.raw`\delta_{1,2}=0_{\mathbb{C}}`), " なので ", math(String.raw`\alpha_m=0_{\mathbb{C}}`), " である（", ref("def_kronecker_delta"), "）。",
        ],
        [
          math(String.raw`m\notin T`), " かつ ", math(String.raw`m\notin S`), " のとき、", math(String.raw`o_S(m)=1`), " なので ", math(String.raw`\alpha_m=\delta_{2,1}\cdot_{\mathbb{C}}\delta_{1,o_T(m)}`),
          " であり、", math(String.raw`\delta_{2,1}=0_{\mathbb{C}}`), " なので ", math(String.raw`\alpha_m=0_{\mathbb{C}}`), " である。",
        ],
        [
          math(String.raw`m\notin T`), "、", math(String.raw`m\in S`), " かつ ", math(String.raw`S\neq T\cup\{m\}`), " のとき、集合の等しさの定義（",
          ref("def_power_set_of_first_m_positive_integers"), "）により、", math(String.raw`k\in S`), " と ", math(String.raw`k\in T\cup\{m\}`), " が同値でない ",
          math(String.raw`k\in\{1,\dots,M\}`), " がある。", math(String.raw`m\in S`), " かつ ", math(String.raw`m\in T\cup\{m\}`), " なので ", math(String.raw`k\neq m`),
          " であり、", math(String.raw`k\neq m`), " なら ", math(String.raw`k\in T\cup\{m\}`), " と ", math(String.raw`k\in T`), " は同値なので、", math(String.raw`k\in S`),
          " と ", math(String.raw`k\in T`), " は同値でない。したがって ", math(String.raw`o_S(k)\neq o_T(k)`), " であり（", ref("def_membership_index_of_subset"), "）、",
          math(String.raw`A_k`), " は ", math(String.raw`\sigma^{z}`), " か ", math(String.raw`I_2`), " なので、準備から ", math(String.raw`\alpha_k=0_{\mathbb{C}}`), " である。",
        ],
      ]),
      paragraph([
        "二つの場合のどちらでも ", math(String.raw`(c_m)_{S,T}=(\mathop{\boxtimes}_{k}A_k)_{S,T}`), " であり、", math(String.raw`S,T`), " は任意だったので主張が成り立つ（",
        ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
    ],
  },
  {
    id: "isomorphism_claim_annihilation_operator_matrix_is_kronecker_product",
    kind: "claim",
    title: { text: "消滅作用素の行列は、z の Pauli 行列・行列単位・単位行列のクロネッカー積である" },
    labels: ["claim_annihilation_operator_matrix_is_kronecker_product"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`m`), "、", math(String.raw`\sigma^{z}`), "、", math(String.raw`I_2`), "、", math(String.raw`A_k`), " を ",
        ref("claim_creation_operator_matrix_is_kronecker_product"), " のものとし、", math(String.raw`c_m^{\mathsf T}`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"),
        "）、", math(String.raw`E_{1,2}\in\mathrm{Mat}_{\{1,2\}}(\mathbb{C})`), " を行列単位（", ref("def_matrix_unit"), "）とする。", math(String.raw`k\in\{1,\dots,M\}`), " について ",
        math(String.raw`k\neq m`), " なら ", math(String.raw`A'_k:=A_k`), "、", math(String.raw`A'_m:=E_{1,2}`), " と置く。クロネッカー積（",
        ref("def_kronecker_product_indexed_by_power_set"), "）について次が成り立つ。",
      ]),
      displayMath(String.raw`c_m^{\mathsf T}=\mathop{\boxtimes}\limits_{k=1}^{M}A'_k`),
    ],
    proof: [
      paragraph([
        "準備として、すべての ", math(String.raw`k\in\{1,\dots,M\}`), " と ", math(String.raw`a,b\in\{1,2\}`), " について ", math(String.raw`(A'_k)_{a,b}=(A_k)_{b,a}`),
        " である。", math(String.raw`k\neq m`), " のとき、", math(String.raw`A_k`), " は ", math(String.raw`\sigma^{z}`), " か ", math(String.raw`I_2`), " であり、",
        math(String.raw`a=b`), " なら両辺は同じ成分、", math(String.raw`a\neq b`), " なら両辺とも ", math(String.raw`0_{\mathbb{C}}`), " である（", ref("def_pauli_matrix_z"),
        "、", ref("def_matrices_indexed_by_finite_set"), "、", ref("def_kronecker_delta"), "）。", math(String.raw`k=m`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
(E_{1,2})_{a,b}
&=\delta_{1,a}\cdot_{\mathbb{C}}\delta_{2,b}
&&\left(\because\ \blkref{def_matrix_unit}\right)\\
&=\delta_{2,b}\cdot_{\mathbb{C}}\delta_{1,a}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(E_{2,1})_{b,a}
&&\left(\because\ \blkref{def_matrix_unit}\right).
\end{aligned}`),
      paragraph([math(String.raw`S,T\in\mathcal{P}_M`), " を任意に固定する。"]),
      displayMath(String.raw`\begin{aligned}
(c_m^{\mathsf T})_{S,T}
&=(c_m)_{T,S}
&&\left(\because\ \blkref{def_annihilation_operator_matrix}\right)\\
&=\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}A_k\Bigr)_{T,S}
&&\left(\because\ \blkref{claim_creation_operator_matrix_is_kronecker_product}\right)\\
&=\prod_{\mathbb{C},\,k=1}^{M}(A_k)_{o_T(k),o_S(k)}
&&\left(\because\ \blkref{def_kronecker_product_indexed_by_power_set}\right)\\
&=\prod_{\mathbb{C},\,k=1}^{M}(A'_k)_{o_S(k),o_T(k)}
&&\left(\because\ \text{各}\ k\ \text{で準備の等式。}\blkref{def_ordered_product_in_complex_numbers}\right)\\
&=\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}A'_k\Bigr)_{S,T}
&&\left(\because\ \blkref{def_kronecker_product_indexed_by_power_set}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_jordan_wigner_z_matrix",
    kind: "definition",
    title: { text: "Jordan–Wigner 行列 Zm", tex: String.raw`\text{Jordan–Wigner 行列 }Z_m` },
    labels: ["def_jordan_wigner_z_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`\sigma^{x}`), " を ", ref("def_pauli_matrix_x"), "、", math(String.raw`\sigma^{z}`), " を ", ref("def_pauli_matrix_z"),
        " の行列、", math(String.raw`I_2:=1_{\mathrm{Mat}_{\{1,2\}}}`), " とする。", math(String.raw`m\in\{1,\dots,M\}`), " について、", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元 ", math(String.raw`Z_m`), " を、次の族のクロネッカー積（", ref("def_kronecker_product_indexed_by_power_set"), "）で定める。",
      ]),
      displayMath(String.raw`Z_m:=\mathop{\boxtimes}\limits_{k=1}^{M}
\begin{cases}
  \sigma^{x} & (k<m),\\
  \sigma^{z} & (k=m),\\
  I_2 & (k>m).
\end{cases}`),
    ],
  },
  {
    id: "isomorphism_definition_jordan_wigner_y_matrix",
    kind: "definition",
    title: { text: "Jordan–Wigner 行列 Ym", tex: String.raw`\text{Jordan–Wigner 行列 }Y_m` },
    labels: ["def_jordan_wigner_y_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`\sigma^{x}`), " を ", ref("def_pauli_matrix_x"), "、", math(String.raw`\sigma^{y}`), " を ", ref("def_pauli_matrix_y"),
        " の行列、", math(String.raw`I_2:=1_{\mathrm{Mat}_{\{1,2\}}}`), " とする。", math(String.raw`m\in\{1,\dots,M\}`), " について、", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元 ", math(String.raw`Y_m`), " を、次の族のクロネッカー積（", ref("def_kronecker_product_indexed_by_power_set"), "）で定める。",
      ]),
      displayMath(String.raw`Y_m:=\mathop{\boxtimes}\limits_{k=1}^{M}
\begin{cases}
  \sigma^{x} & (k<m),\\
  \sigma^{y} & (k=m),\\
  I_2 & (k>m).
\end{cases}`),
    ],
  },
  {
    id: "isomorphism_definition_kronecker_power_of_matrix_exchanging_pauli_z_and_x",
    kind: "definition",
    title: { text: "すべての因子が K のクロネッカー積 U" },
    labels: ["def_kronecker_power_of_matrix_exchanging_pauli_z_and_x"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`K`), " を ", ref("def_matrix_exchanging_pauli_z_and_x"), " の行列とする。", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元 ", math(String.raw`U`), " を、すべての ", math(String.raw`k\in\{1,\dots,M\}`), " で因子が ", math(String.raw`K`), " である族のクロネッカー積（",
        ref("def_kronecker_product_indexed_by_power_set"), "）で定める。",
      ]),
      displayMath(String.raw`U:=\mathop{\boxtimes}\limits_{k=1}^{M}K`),
    ],
  },
  {
    id: "isomorphism_definition_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x",
    kind: "definition",
    title: { text: "すべての因子が K' のクロネッカー積 U'" },
    labels: ["def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), " とし、", math(String.raw`K'`), " を ", ref("def_half_of_matrix_exchanging_pauli_z_and_x"), " の行列とする。", math(String.raw`\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " の元 ", math(String.raw`U'`), " を、すべての ", math(String.raw`k\in\{1,\dots,M\}`), " で因子が ", math(String.raw`K'`), " である族のクロネッカー積（",
        ref("def_kronecker_product_indexed_by_power_set"), "）で定める。",
      ]),
      displayMath(String.raw`U':=\mathop{\boxtimes}\limits_{k=1}^{M}K'`),
    ],
  },
  {
    id: "isomorphism_claim_kronecker_power_of_k_times_that_of_its_half_is_identity",
    kind: "claim",
    title: { text: "U に右から U' を掛けると単位行列になる" },
    labels: ["claim_kronecker_power_of_k_times_that_of_its_half_is_identity"],
    statement: [
      paragraph([
        math(String.raw`U`), " を ", ref("def_kronecker_power_of_matrix_exchanging_pauli_z_and_x"), "、", math(String.raw`U'`), " を ", ref("def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x"),
        " の行列とする。", math(String.raw`U\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}U'=1_{\mathrm{Mat}_{\mathcal{P}_M}}`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
U\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}U'
&=\mathop{\boxtimes}\limits_{k=1}^{M}\bigl(K\cdot_{\mathrm{Mat}_{\{1,2\}}}K'\bigr)
&&\left(\because\ \blkref{claim_product_of_kronecker_products_is_kronecker_product_of_products}\right)\\
&=\mathop{\boxtimes}\limits_{k=1}^{M}1_{\mathrm{Mat}_{\{1,2\}}}
&&\left(\because\ \blkref{claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity}\text{。各}\ k\ \text{の因子が等しい。}\blkref{def_kronecker_product_indexed_by_power_set}\right)\\
&=1_{\mathrm{Mat}_{\mathcal{P}_M}}
&&\left(\because\ \blkref{claim_kronecker_product_of_identity_matrices_is_identity_matrix}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity",
    kind: "claim",
    title: { text: "U に左から U' を掛けると単位行列になる" },
    labels: ["claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity"],
    statement: [
      paragraph([
        math(String.raw`U`), " を ", ref("def_kronecker_power_of_matrix_exchanging_pauli_z_and_x"), "、", math(String.raw`U'`), " を ", ref("def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x"),
        " の行列とする。", math(String.raw`U'\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}U=1_{\mathrm{Mat}_{\mathcal{P}_M}}`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
U'\cdot_{\mathrm{Mat}_{\mathcal{P}_M}}U
&=\mathop{\boxtimes}\limits_{k=1}^{M}\bigl(K'\cdot_{\mathrm{Mat}_{\{1,2\}}}K\bigr)
&&\left(\because\ \blkref{claim_product_of_kronecker_products_is_kronecker_product_of_products}\right)\\
&=\mathop{\boxtimes}\limits_{k=1}^{M}1_{\mathrm{Mat}_{\{1,2\}}}
&&\left(\because\ \blkref{claim_half_times_matrix_exchanging_pauli_matrices_is_identity}\text{。各}\ k\ \text{の因子が等しい。}\blkref{def_kronecker_product_indexed_by_power_set}\right)\\
&=1_{\mathrm{Mat}_{\mathcal{P}_M}}
&&\left(\because\ \blkref{claim_kronecker_product_of_identity_matrices_is_identity_matrix}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis",
    kind: "claim",
    title: { text: "一般の偶数次元の系の準同型は、直交基底の前半の元の像を生成作用素と消滅作用素の行列の和へ移す" },
    labels: ["claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`e`), "、", math(String.raw`\gamma_Y`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " のもの、",
        math(String.raw`\Phi_Y:\mathrm{Cl}(Y,Q)\to\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " を ",
        ref("theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra"), " の準同型 ",
        math(String.raw`\Phi_Y=\Phi\circ\mathrm{Cl}(\theta)`), " とする。", math(String.raw`c_m`), " を生成作用素の行列（", ref("def_creation_operator_matrix"), "）、",
        math(String.raw`c_m^{\mathsf T}`), " を消滅作用素の行列（", ref("def_annihilation_operator_matrix"), "）とし、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " と書く。すべての ", math(String.raw`m\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi_Y\bigl(\gamma_Y(e_m)\bigr)=c_m+_B c_m^{\mathsf T}`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書き、", math(String.raw`u`), " を ", ref("def_family_in_split_space_for_isometry"), " の族とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Phi_Y\bigl(\gamma_Y(e_m)\bigr)
&=\Phi\Bigl(\mathrm{Cl}(\theta)\bigl(\gamma_Y(e_m)\bigr)\Bigr)
&&\left(\because\ \Phi_Y\ \text{の定義。}\blkref{theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra}\right)\\
&=\Phi\Bigl(\gamma\bigl(\theta(e_m)\bigr)\Bigr)
&&\left(\because\ \mathrm{Cl}(\theta)\circ\gamma_Y=\gamma\circ\theta\text{。}\blkref{def_homomorphism_of_clifford_algebras_induced_by_isometry}\right)\\
&=\Phi\bigl(\gamma(u_m)\bigr)
&&\left(\because\ \theta=L_{e,u}\text{。}\blkref{def_map_to_split_quadratic_space}\text{、}\blkref{claim_map_by_coordinates_and_family_sends_basis_member_to_family_member}\right)\\
&=\Phi\Bigl(\gamma\bigl((w_m,\ f_m)\bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&=\Phi\Bigl(\gamma\bigl(\mathrm{in}_1(w_m)+_V\mathrm{in}_2(f_m)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_direct_sum_element_is_sum_of_embedded_components}\right)\\
&=\Phi\Bigl(\gamma\bigl(\mathrm{in}_1(w_m)\bigr)+_A\gamma\bigl(\mathrm{in}_2(f_m)\bigr)\Bigr)
&&\left(\because\ \gamma\ \text{は線型写像。}\blkref{claim_clifford_generator_map_is_linear_map}\right)\\
&=\Phi\bigl(a^{\dagger}_m+_A a_m\bigr)
&&\left(\because\ \blkref{def_creation_generator_of_split_clifford_algebra}\text{、}\blkref{def_annihilation_generator_of_split_clifford_algebra}\right)\\
&=\Phi\bigl(a^{\dagger}_m\bigr)+_B\Phi(a_m)
&&\left(\because\ \Phi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=c_m+_B c_m^{\mathsf T}
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix}\text{、}\blkref{claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis",
    kind: "claim",
    title: { text: "一般の偶数次元の系の準同型は、直交基底の後半の元の像を生成作用素と消滅作用素の行列の虚数倍の和へ移す" },
    labels: ["claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`e`), "、", math(String.raw`\gamma_Y`), "、", math(String.raw`\Phi_Y`), "、", math(String.raw`c_m`), "、",
        math(String.raw`c_m^{\mathsf T}`), "、", math(String.raw`B`), " を ", ref("claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis"), " のもの、",
        math(String.raw`\mathrm{i}`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " の元とする。すべての ",
        math(String.raw`m\in\{1,\dots,M\}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\Phi_Y\bigl(\gamma_Y(e_{M+m})\bigr)=\bigl((-_{\mathbb{C}}\mathrm{i})\ast_B c_m\bigr)+_B\bigl(\mathrm{i}\ast_B c_m^{\mathsf T}\bigr)`),
    ],
    proof: [
      paragraph([
        math(String.raw`A:=\mathrm{Cl}(V,q)`), " と書き、", math(String.raw`u`), " を ", ref("def_family_in_split_space_for_isometry"), " の族とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\Phi_Y\bigl(\gamma_Y(e_{M+m})\bigr)\\
&\quad=\Phi\Bigl(\mathrm{Cl}(\theta)\bigl(\gamma_Y(e_{M+m})\bigr)\Bigr)
&&\left(\because\ \Phi_Y\ \text{の定義。}\blkref{theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra}\right)\\
&\quad=\Phi\Bigl(\gamma\bigl(\theta(e_{M+m})\bigr)\Bigr)
&&\left(\because\ \mathrm{Cl}(\theta)\circ\gamma_Y=\gamma\circ\theta\text{。}\blkref{def_homomorphism_of_clifford_algebras_induced_by_isometry}\right)\\
&\quad=\Phi\bigl(\gamma(u_{M+m})\bigr)
&&\left(\because\ \theta=L_{e,u}\text{。}\blkref{def_map_to_split_quadratic_space}\text{、}\blkref{claim_map_by_coordinates_and_family_sends_basis_member_to_family_member}\right)\\
&\quad=\Phi\Bigl(\gamma\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m,\ \mathrm{i}\cdot_{W^{*}}f_m\bigr)\Bigr)\Bigr)
&&\left(\because\ \blkref{def_family_in_split_space_for_isometry}\right)\\
&\quad=\Phi\Bigl(\gamma\Bigl(\mathrm{in}_1\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_W w_m\bigr)+_V\mathrm{in}_2\bigl(\mathrm{i}\cdot_{W^{*}}f_m\bigr)\Bigr)\Bigr)
&&\left(\because\ \blkref{claim_direct_sum_element_is_sum_of_embedded_components}\right)\\
&\quad=\Phi\Bigl(\gamma\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_V\mathrm{in}_1(w_m)\bigr)+_V\bigl(\mathrm{i}\cdot_V\mathrm{in}_2(f_m)\bigr)\Bigr)\Bigr)
&&\left(\because\ \mathrm{in}_1,\ \mathrm{in}_2\ \text{はスカラー倍を保つ。}\blkref{claim_embedding_into_first_component_is_linear_map}\text{、}\blkref{claim_embedding_into_second_component_is_linear_map}\right)\\
&\quad=\Phi\Bigl(\gamma\bigl((-_{\mathbb{C}}\mathrm{i})\cdot_V\mathrm{in}_1(w_m)\bigr)+_A\gamma\bigl(\mathrm{i}\cdot_V\mathrm{in}_2(f_m)\bigr)\Bigr)
&&\left(\because\ \gamma\ \text{は加法を保つ。}\blkref{claim_clifford_generator_map_is_linear_map}\right)\\
&\quad=\Phi\Bigl(\Bigl((-_{\mathbb{C}}\mathrm{i})\ast_A\gamma\bigl(\mathrm{in}_1(w_m)\bigr)\Bigr)+_A\Bigl(\mathrm{i}\ast_A\gamma\bigl(\mathrm{in}_2(f_m)\bigr)\Bigr)\Bigr)
&&\left(\because\ \gamma\ \text{はスカラー倍を保つ（二か所）。}\blkref{claim_clifford_generator_map_is_linear_map}\right)\\
&\quad=\Phi\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\ast_A a^{\dagger}_m\bigr)+_A\bigl(\mathrm{i}\ast_A a_m\bigr)\Bigr)
&&\left(\because\ \blkref{def_creation_generator_of_split_clifford_algebra}\text{、}\blkref{def_annihilation_generator_of_split_clifford_algebra}\right)\\
&\quad=\Phi\bigl((-_{\mathbb{C}}\mathrm{i})\ast_A a^{\dagger}_m\bigr)+_B\Phi\bigl(\mathrm{i}\ast_A a_m\bigr)
&&\left(\because\ \Phi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&\quad=\Bigl((-_{\mathbb{C}}\mathrm{i})\ast_B\Phi\bigl(a^{\dagger}_m\bigr)\Bigr)+_B\bigl(\mathrm{i}\ast_B\Phi(a_m)\bigr)
&&\left(\because\ \Phi\ \text{はスカラー倍を保つ（二か所）。}\blkref{def_complex_algebra_homomorphism}\right)\\
&\quad=\bigl((-_{\mathbb{C}}\mathrm{i})\ast_B c_m\bigr)+_B\bigl(\mathrm{i}\ast_B c_m^{\mathsf T}\bigr)
&&\left(\because\ \blkref{claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix}\text{、}\blkref{claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix",
    kind: "claim",
    title: { text: "生成作用素と消滅作用素の行列の和を U と U' で挟むと、z の Pauli 行列で終わる Jordan–Wigner 行列になる" },
    labels: ["claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`m\in\{1,\dots,M\}`), "、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " とし、",
        math(String.raw`c_m`), " を ", ref("def_creation_operator_matrix"), "、", math(String.raw`c_m^{\mathsf T}`), " を ", ref("def_annihilation_operator_matrix"), "、",
        math(String.raw`Z_m`), " を ", ref("def_jordan_wigner_z_matrix"), "、", math(String.raw`U`), " を ", ref("def_kronecker_power_of_matrix_exchanging_pauli_z_and_x"), "、",
        math(String.raw`U'`), " を ", ref("def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x"), " の行列、", math(String.raw`\kappa_{U,U'}`), " を ",
        ref("def_conjugation_of_matrices"), " の写像とする。次が成り立つ。",
      ]),
      displayMath(String.raw`\kappa_{U,U'}\bigl(c_m+_B c_m^{\mathsf T}\bigr)=Z_m`),
    ],
    proof: [
      paragraph([
        math(String.raw`A_k`), " と ", math(String.raw`A'_k`), " を ", ref("claim_creation_operator_matrix_is_kronecker_product"), " と ", ref("claim_annihilation_operator_matrix_is_kronecker_product"),
        " の族、", math(String.raw`E_{2,1},E_{1,2}`), " を行列単位、", math(String.raw`\sigma^{x},\sigma^{z}`), " を Pauli 行列（", ref("def_pauli_matrix_x"), "、", ref("def_pauli_matrix_z"),
        "）、", math(String.raw`K`), " を ", ref("def_matrix_exchanging_pauli_z_and_x"), " の行列、", math(String.raw`I_2:=1_{\mathrm{Mat}_{\{1,2\}}}`), " とし、",
        math(String.raw`\mathrm{Mat}_{\{1,2\}}`), " の演算の添字を ", math(String.raw`2`), " と略記する。", math(String.raw`k\in\{1,\dots,M\}`), " について ",
        math(String.raw`k\neq m`), " なら ", math(String.raw`G_k:=A_k`), "、", math(String.raw`G_m:=(1_{\mathbb{C}}\ast_2 E_{2,1})+_2(1_{\mathbb{C}}\ast_2 E_{1,2})`), " と置き、",
        math(String.raw`F_k`), " を ", ref("def_jordan_wigner_z_matrix"), " の右辺の第 ", math(String.raw`k`), " 因子（", math(String.raw`k<m`), " なら ", math(String.raw`\sigma^{x}`),
        "、", math(String.raw`k=m`), " なら ", math(String.raw`\sigma^{z}`), "、", math(String.raw`k>m`), " なら ", math(String.raw`I_2`), "）とする。",
      ]),
      paragraph([
        "（一）", math(String.raw`c_m+_B c_m^{\mathsf T}=\mathop{\boxtimes}_{k}G_k`), " である。", math(String.raw`k\neq m`), " なら ", math(String.raw`A_k=A'_k=G_k`), " なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
c_m+_B c_m^{\mathsf T}
&=\bigl(1_{\mathbb{C}}\ast_B c_m\bigr)+_B\bigl(1_{\mathbb{C}}\ast_B c_m^{\mathsf T}\bigr)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{claim_matrices_indexed_by_finite_set_form_complex_vector_space}\text{、}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(1_{\mathbb{C}}\ast_B\mathop{\boxtimes}\limits_{k=1}^{M}A_k\Bigr)+_B\Bigl(1_{\mathbb{C}}\ast_B\mathop{\boxtimes}\limits_{k=1}^{M}A'_k\Bigr)
&&\left(\because\ \blkref{claim_creation_operator_matrix_is_kronecker_product}\text{、}\blkref{claim_annihilation_operator_matrix_is_kronecker_product}\right)\\
&=\mathop{\boxtimes}\limits_{k=1}^{M}G_k
&&\left(\because\ r:=m\text{、}\lambda=\lambda':=1_{\mathbb{C}}\text{。}\blkref{claim_kronecker_product_is_linear_in_one_factor}\right).
\end{aligned}`),
      paragraph([
        "（二）すべての ", math(String.raw`k`), " について ", math(String.raw`K\cdot_2 G_k=F_k\cdot_2 K`), " である。", math(String.raw`k<m`), " なら ", math(String.raw`G_k=\sigma^{z}`),
        "、", math(String.raw`F_k=\sigma^{x}`), " で ", ref("claim_matrix_k_turns_pauli_z_into_pauli_x"), " による。", math(String.raw`k=m`), " なら ",
        ref("claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z"), " による。", math(String.raw`k>m`), " なら ", math(String.raw`G_k=F_k=I_2`), " で、",
        math(String.raw`K\cdot_2 I_2=K`), "（", ref("claim_identity_matrix_is_right_unit_of_matrix_product"), "）と ", math(String.raw`K=I_2\cdot_2 K`), "（", ref("claim_identity_matrix_is_left_unit_of_matrix_product"), "）による。",
      ]),
      paragraph(["行列の積の結合法則（", ref("claim_matrix_product_is_associative"), "）を「結合」と略記する。"]),
      displayMath(String.raw`\begin{aligned}
\kappa_{U,U'}\bigl(c_m+_B c_m^{\mathsf T}\bigr)
&=\bigl(U\cdot_B(c_m+_B c_m^{\mathsf T})\bigr)\cdot_B U'
&&\left(\because\ \blkref{def_conjugation_of_matrices}\right)\\
&=\Bigl(U\cdot_B\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}G_k\Bigr)\Bigr)\cdot_B U'
&&\left(\because\ \text{（一）}\right)\\
&=\Bigl(\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}K\Bigr)\cdot_B\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}G_k\Bigr)\Bigr)\cdot_B U'
&&\left(\because\ \blkref{def_kronecker_power_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}\bigl(K\cdot_2 G_k\bigr)\Bigr)\cdot_B U'
&&\left(\because\ \blkref{claim_product_of_kronecker_products_is_kronecker_product_of_products}\right)\\
&=\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}\bigl(F_k\cdot_2 K\bigr)\Bigr)\cdot_B U'
&&\left(\because\ \text{各}\ k\ \text{で（二）。}\blkref{def_kronecker_product_indexed_by_power_set}\right)\\
&=\Bigl(\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}F_k\Bigr)\cdot_B\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}K\Bigr)\Bigr)\cdot_B U'
&&\left(\because\ \blkref{claim_product_of_kronecker_products_is_kronecker_product_of_products}\right)\\
&=\Bigl(Z_m\cdot_B\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}K\Bigr)\Bigr)\cdot_B U'
&&\left(\because\ \blkref{def_jordan_wigner_z_matrix}\right)\\
&=\bigl(Z_m\cdot_B U\bigr)\cdot_B U'
&&\left(\because\ \blkref{def_kronecker_power_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=Z_m\cdot_B\bigl(U\cdot_B U'\bigr)
&&\left(\because\ \text{結合}\right)\\
&=Z_m\cdot_B 1_B
&&\left(\because\ \blkref{claim_kronecker_power_of_k_times_that_of_its_half_is_identity}\right)\\
&=Z_m
&&\left(\because\ \blkref{claim_identity_matrix_is_right_unit_of_matrix_product}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix",
    kind: "claim",
    title: { text: "生成作用素と消滅作用素の行列の虚数倍の和を U と U' で挟むと、y の Pauli 行列で終わる Jordan–Wigner 行列になる" },
    labels: ["claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`m`), "、", math(String.raw`B`), "、", math(String.raw`c_m`), "、", math(String.raw`c_m^{\mathsf T}`), "、", math(String.raw`U`), "、",
        math(String.raw`U'`), "、", math(String.raw`\kappa_{U,U'}`), " を ", ref("claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix"), " のもの、",
        math(String.raw`\mathrm{i}`), " を ", ref("def_setting_of_general_even_dimensional_corollary"), " の元、", math(String.raw`Y_m`), " を ", ref("def_jordan_wigner_y_matrix"),
        " の行列とする。次が成り立つ。",
      ]),
      displayMath(String.raw`\kappa_{U,U'}\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\ast_B c_m\bigr)+_B\bigl(\mathrm{i}\ast_B c_m^{\mathsf T}\bigr)\Bigr)=Y_m`),
    ],
    proof: [
      paragraph([
        math(String.raw`A_k`), "、", math(String.raw`A'_k`), "、", math(String.raw`E_{2,1}`), "、", math(String.raw`E_{1,2}`), "、", math(String.raw`K`), "、", math(String.raw`I_2`),
        " と添字の略記 ", math(String.raw`2`), " を ", ref("claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix"), " の証明のものとし、",
        math(String.raw`\sigma^{x},\sigma^{y}`), " を Pauli 行列（", ref("def_pauli_matrix_x"), "、", ref("def_pauli_matrix_y"), "）とする。", math(String.raw`X:=\bigl((-_{\mathbb{C}}\mathrm{i})\ast_B c_m\bigr)+_B\bigl(\mathrm{i}\ast_B c_m^{\mathsf T}\bigr)`),
        " と書く。", math(String.raw`k\neq m`), " なら ", math(String.raw`G'_k:=A_k`), "、", math(String.raw`G'_m:=\bigl((-_{\mathbb{C}}\mathrm{i})\ast_2 E_{2,1}\bigr)+_2(\mathrm{i}\ast_2 E_{1,2})`),
        " と置き、", math(String.raw`F'_k`), " を ", ref("def_jordan_wigner_y_matrix"), " の右辺の第 ", math(String.raw`k`), " 因子（", math(String.raw`k<m`), " なら ",
        math(String.raw`\sigma^{x}`), "、", math(String.raw`k=m`), " なら ", math(String.raw`\sigma^{y}`), "、", math(String.raw`k>m`), " なら ", math(String.raw`I_2`), "）とする。",
      ]),
      paragraph([
        "（一）", math(String.raw`X=\mathop{\boxtimes}_{k}G'_k`), " である。", math(String.raw`k\neq m`), " なら ", math(String.raw`A_k=A'_k=G'_k`), " なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
X
&=\Bigl((-_{\mathbb{C}}\mathrm{i})\ast_B\mathop{\boxtimes}\limits_{k=1}^{M}A_k\Bigr)+_B\Bigl(\mathrm{i}\ast_B\mathop{\boxtimes}\limits_{k=1}^{M}A'_k\Bigr)
&&\left(\because\ \blkref{claim_creation_operator_matrix_is_kronecker_product}\text{、}\blkref{claim_annihilation_operator_matrix_is_kronecker_product}\right)\\
&=\mathop{\boxtimes}\limits_{k=1}^{M}G'_k
&&\left(\because\ r:=m\text{、}\lambda:=-_{\mathbb{C}}\mathrm{i}\text{、}\lambda':=\mathrm{i}\text{。}\blkref{claim_kronecker_product_is_linear_in_one_factor}\right).
\end{aligned}`),
      paragraph([
        "（二）すべての ", math(String.raw`k`), " について ", math(String.raw`K\cdot_2 G'_k=F'_k\cdot_2 K`), " である。", math(String.raw`k<m`), " なら ",
        ref("claim_matrix_k_turns_pauli_z_into_pauli_x"), "、", math(String.raw`k=m`), " なら ", ref("claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y"),
        "、", math(String.raw`k>m`), " なら ", math(String.raw`K\cdot_2 I_2=K`), "（", ref("claim_identity_matrix_is_right_unit_of_matrix_product"), "）と ",
        math(String.raw`K=I_2\cdot_2 K`), "（", ref("claim_identity_matrix_is_left_unit_of_matrix_product"), "）による。",
      ]),
      paragraph(["行列の積の結合法則（", ref("claim_matrix_product_is_associative"), "）を「結合」と略記する。"]),
      displayMath(String.raw`\begin{aligned}
\kappa_{U,U'}(X)
&=\bigl(U\cdot_B X\bigr)\cdot_B U'
&&\left(\because\ \blkref{def_conjugation_of_matrices}\right)\\
&=\Bigl(U\cdot_B\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}G'_k\Bigr)\Bigr)\cdot_B U'
&&\left(\because\ \text{（一）}\right)\\
&=\Bigl(\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}K\Bigr)\cdot_B\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}G'_k\Bigr)\Bigr)\cdot_B U'
&&\left(\because\ \blkref{def_kronecker_power_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}\bigl(K\cdot_2 G'_k\bigr)\Bigr)\cdot_B U'
&&\left(\because\ \blkref{claim_product_of_kronecker_products_is_kronecker_product_of_products}\right)\\
&=\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}\bigl(F'_k\cdot_2 K\bigr)\Bigr)\cdot_B U'
&&\left(\because\ \text{各}\ k\ \text{で（二）。}\blkref{def_kronecker_product_indexed_by_power_set}\right)\\
&=\Bigl(\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}F'_k\Bigr)\cdot_B\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}K\Bigr)\Bigr)\cdot_B U'
&&\left(\because\ \blkref{claim_product_of_kronecker_products_is_kronecker_product_of_products}\right)\\
&=\Bigl(Y_m\cdot_B\Bigl(\mathop{\boxtimes}\limits_{k=1}^{M}K\Bigr)\Bigr)\cdot_B U'
&&\left(\because\ \blkref{def_jordan_wigner_y_matrix}\right)\\
&=\bigl(Y_m\cdot_B U\bigr)\cdot_B U'
&&\left(\because\ \blkref{def_kronecker_power_of_matrix_exchanging_pauli_z_and_x}\right)\\
&=Y_m\cdot_B\bigl(U\cdot_B U'\bigr)
&&\left(\because\ \text{結合}\right)\\
&=Y_m\cdot_B 1_B
&&\left(\because\ \blkref{claim_kronecker_power_of_k_times_that_of_its_half_is_identity}\right)\\
&=Y_m
&&\left(\because\ \blkref{claim_identity_matrix_is_right_unit_of_matrix_product}\right).
\end{aligned}`),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power",
    kind: "definition",
    title: { text: "一般の偶数次元の系の行き先を U と U' で挟んだ写像" },
    labels: ["def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`Y`), "、", math(String.raw`Q`), "、", math(String.raw`\mathrm{Cl}(Y,Q)`), " を ", ref("def_setting_of_general_even_dimensional_corollary"),
        " のものとし、", math(String.raw`B:=\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`), " と書く。", math(String.raw`\Phi_Y:\mathrm{Cl}(Y,Q)\to B`), " と ", math(String.raw`\Psi_Y:B\to\mathrm{Cl}(Y,Q)`),
        " を ", ref("theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra"), " の準同型、", math(String.raw`U`), " を ",
        ref("def_kronecker_power_of_matrix_exchanging_pauli_z_and_x"), "、", math(String.raw`U'`), " を ", ref("def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x"),
        " の行列、", math(String.raw`\kappa_{U,U'}`), " と ", math(String.raw`\kappa_{U',U}`), " を ", ref("def_conjugation_of_matrices"), " の写像とする。",
        "写像 ", math(String.raw`\Omega:\mathrm{Cl}(Y,Q)\to B`), " を次で定める。",
      ]),
      displayMath(String.raw`\Omega:=\kappa_{U,U'}\circ\Phi_Y`),
    ],
  },
  {
    id: "isomorphism_definition_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power",
    kind: "definition",
    title: { text: "U' と U で挟んでから一般の偶数次元の系の帰りへ渡す写像" },
    labels: ["def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`Y`), "、", math(String.raw`Q`), "、", math(String.raw`\mathrm{Cl}(Y,Q)`), "、", math(String.raw`B`), "、", math(String.raw`\Psi_Y`), "、",
        math(String.raw`U`), "、", math(String.raw`U'`), "、", math(String.raw`\kappa_{U',U}`), " を ", ref("def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power"),
        " のものとする。写像 ", math(String.raw`\Omega':B\to\mathrm{Cl}(Y,Q)`), " を次で定める。",
      ]),
      displayMath(String.raw`\Omega':=\Psi_Y\circ\kappa_{U',U}`),
    ],
  },
  {
    id: "isomorphism_theorem_clifford_algebra_of_general_even_dimensional_space_sends_orthonormal_basis_to_jordan_wigner_matrices",
    kind: "theorem",
    title: { text: "系：一般の偶数次元の非退化な二次空間のクリフォード代数から行列環への同型で、直交基底の像が Jordan–Wigner 行列になるもの" },
    labels: ["theorem_clifford_algebra_of_general_even_dimensional_space_sends_orthonormal_basis_to_jordan_wigner_matrices"],
    statement: [
      paragraph([
        math(String.raw`M`), "、", math(String.raw`\mathrm{Cl}(Y,Q)`), "、", math(String.raw`\gamma_Y`), "、", math(String.raw`e`), " を ", ref("def_setting_of_general_even_dimensional_corollary"),
        " のもの、", math(String.raw`B`), "、", math(String.raw`\Phi_Y`), "、", math(String.raw`\Psi_Y`), "、", math(String.raw`U`), "、", math(String.raw`U'`), " を ",
        ref("def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power"), " のもの、", math(String.raw`\Omega`), " を ",
        ref("def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power"), "、", math(String.raw`\Omega'`), " を ",
        ref("def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power"), " の写像とする。",
      ]),
      paragraph(["このとき次が成り立つ（", math(String.raw`Z_m`), " は ", ref("def_jordan_wigner_z_matrix"), "、", math(String.raw`Y_m`), " は ", ref("def_jordan_wigner_y_matrix"), "）。"]),
      list([
        [math(String.raw`\Omega`), " と ", math(String.raw`\Omega'`), " はどちらも ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。"],
        [
          "すべての ", math(String.raw`a\in\mathrm{Cl}(Y,Q)`), " について ", math(String.raw`\Omega'(\Omega(a))=a`), " であり、すべての ", math(String.raw`F\in B`), " について ",
          math(String.raw`\Omega(\Omega'(F))=F`), " である。",
        ],
        [
          "すべての ", math(String.raw`m\in\{1,\dots,M\}`), " について ", math(String.raw`\Omega(\gamma_Y(e_m))=Z_m`), " かつ ", math(String.raw`\Omega(\gamma_Y(e_{M+m}))=Y_m`), " である。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`U\cdot_B U'=1_B`), "（", ref("claim_kronecker_power_of_k_times_that_of_its_half_is_identity"), "）と ", math(String.raw`U'\cdot_B U=1_B`), "（",
        ref("claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity"), "）なので、", ref("claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism"),
        " を ", math(String.raw`(U,U')`), " と ", math(String.raw`(U',U)`), " に当てると、", math(String.raw`\kappa_{U,U'}`), " と ", math(String.raw`\kappa_{U',U}`),
        " は ℂ-代数の準同型である。", math(String.raw`\Phi_Y`), " と ", math(String.raw`\Psi_Y`), " も ℂ-代数の準同型なので（",
        ref("theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra"), "）、合成 ", math(String.raw`\Omega`), " と ",
        math(String.raw`\Omega'`), " は ℂ-代数の準同型である（", ref("claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism"), "）。",
      ]),
      paragraph([
        ref("claim_conjugations_by_mutually_inverse_matrices_compose_to_identity"), " を ", math(String.raw`(U,U')`), " に当てると（仮定 ", math(String.raw`U'\cdot_B U=1_B`),
        "）すべての ", math(String.raw`G\in B`), " について ", math(String.raw`\kappa_{U',U}(\kappa_{U,U'}(G))=G`), "、", math(String.raw`(U',U)`), " に当てると（仮定 ",
        math(String.raw`U\cdot_B U'=1_B`), "）", math(String.raw`\kappa_{U,U'}(\kappa_{U',U}(G))=G`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Omega'\bigl(\Omega(a)\bigr)
&=\Psi_Y\Bigl(\kappa_{U',U}\Bigl(\kappa_{U,U'}\bigl(\Phi_Y(a)\bigr)\Bigr)\Bigr)
&&\left(\because\ \blkref{def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power}\text{、}\blkref{def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power}\right)\\
&=\Psi_Y\bigl(\Phi_Y(a)\bigr)
&&\left(\because\ \text{上の一つ目の等式で}\ G:=\Phi_Y(a)\right)\\
&=a
&&\left(\because\ \blkref{theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra}\right),\\[4pt]
\Omega\bigl(\Omega'(F)\bigr)
&=\kappa_{U,U'}\Bigl(\Phi_Y\Bigl(\Psi_Y\bigl(\kappa_{U',U}(F)\bigr)\Bigr)\Bigr)
&&\left(\because\ \blkref{def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power}\text{、}\blkref{def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power}\right)\\
&=\kappa_{U,U'}\bigl(\kappa_{U',U}(F)\bigr)
&&\left(\because\ \blkref{theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra}\right)\\
&=F
&&\left(\because\ \text{上の二つ目の等式で}\ G:=F\right).
\end{aligned}`),
      paragraph([math(String.raw`m\in\{1,\dots,M\}`), " について："]),
      displayMath(String.raw`\begin{aligned}
\Omega\bigl(\gamma_Y(e_m)\bigr)
&=\kappa_{U,U'}\Bigl(\Phi_Y\bigl(\gamma_Y(e_m)\bigr)\Bigr)
&&\left(\because\ \blkref{def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power}\right)\\
&=\kappa_{U,U'}\bigl(c_m+_B c_m^{\mathsf T}\bigr)
&&\left(\because\ \blkref{claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis}\right)\\
&=Z_m
&&\left(\because\ \blkref{claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix}\right),\\[4pt]
\Omega\bigl(\gamma_Y(e_{M+m})\bigr)
&=\kappa_{U,U'}\Bigl(\Phi_Y\bigl(\gamma_Y(e_{M+m})\bigr)\Bigr)
&&\left(\because\ \blkref{def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power}\right)\\
&=\kappa_{U,U'}\Bigl(\bigl((-_{\mathbb{C}}\mathrm{i})\ast_B c_m\bigr)+_B\bigl(\mathrm{i}\ast_B c_m^{\mathsf T}\bigr)\Bigr)
&&\left(\because\ \blkref{claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis}\right)\\
&=Y_m
&&\left(\because\ \blkref{claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix}\right).
\end{aligned}`),
    ],
  },
]);
