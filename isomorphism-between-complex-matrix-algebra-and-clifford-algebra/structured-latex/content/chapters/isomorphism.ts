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
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i=j\ \text{と}\ S=U\ \text{で}\ \delta\ \text{の定義を二つの因子に。}\blkref{def_kronecker_delta}\right)\\
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
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}\varsigma(N_i(S))\cdot_{\mathbb{C}}\varsigma(N_i(S))
&&\left(\because\ j=i\ \text{と}\ U=S\right)\\
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ n:=N_i(S)\ \text{を当てる。}\blkref{claim_sign_of_nonnegative_integer_squares_to_one}\right)\\
&\quad=1_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i=j\ \text{と}\ S=U\ \text{で}\ \delta\ \text{の定義を二つの因子に。}\blkref{def_kronecker_delta}\right)\\
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
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_1)\ \text{と}\ (\star_2)\right)\\
&\quad=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&\quad=1_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\ \text{との積は}\ 0_{\mathbb{C}}\right)\\
&\quad=\delta_{i,j}\cdot_{\mathbb{C}}\delta_{S,U}
&&\left(\because\ i=j\ \text{と}\ S\neq U\ \text{で}\ \delta\ \text{の定義を二つの因子に。}\blkref{def_kronecker_delta}\right)\\
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
&\quad=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \text{条件が成り立たないので}\ (\star_1)\ \text{と}\ (\star_2)\right)\\
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
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立つので}\ (\star_1)\ \text{と}\ (\star_2)\text{、}\alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ S=S'\cup\{i\}\ \text{と}\ U=S'\cup\{j\}\right)\\
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
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma(N_j(S))\cdot_{\mathbb{C}}\varsigma(N_i(U))
&&\left(\because\ \text{条件が成り立つので}\ (\star_1)\ \text{と}\ (\star_2)\text{、}\alpha,\beta\ \text{の置き方}\right)\\
&\quad=\alpha\cdot_{\mathbb{C}}\beta+_{\mathbb{C}}\varsigma\bigl(N_j(S'\cup\{i\})\bigr)\cdot_{\mathbb{C}}\varsigma\bigl(N_i(S'\cup\{j\})\bigr)
&&\left(\because\ S=S'\cup\{i\}\ \text{と}\ U=S'\cup\{j\}\right)\\
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
]);
