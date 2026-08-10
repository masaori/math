import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_diagonalization_appendix_B",
    kind: "heading",
    level: 1,
    origin: { path: "_old/typst/main.typ", ordinal: 5 },
    title: { text: "対角化の計算 (ホロノミック量子場 付録B)" },
    labels: [],
  },
  {
    id: "heading_transfer_matrix",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 6 },
    title: { text: "転送行列" },
    labels: [],
  },
  {
    id: "transfer_matrix_001_definition_symbols",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/000_definition_転送行列の記号の定義.typ", ordinal: 1 },
    title: { text: "記号の定義" },
    labels: ["def_transfer_matrix_symbols"],
    statement: [
      list([
        [
          math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
          ": ",
          math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
          " 上の単位行列",
        ],
        [
          math(String.raw`\sigma_k^x := I_{\mathrm{Mat}(2,\mathbb{C})} \boxtimes \cdots \boxtimes \overbrace{\sigma^x}^{k\text{th}} \boxtimes \cdots \boxtimes I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2^M,\mathbb{C})`),
        ],
        [
          math(String.raw`\sigma_k^y := I_{\mathrm{Mat}(2,\mathbb{C})} \boxtimes \cdots \boxtimes \overbrace{\sigma^y}^{k\text{th}} \boxtimes \cdots \boxtimes I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2^M,\mathbb{C})`),
        ],
        [
          math(String.raw`\sigma_k^z := I_{\mathrm{Mat}(2,\mathbb{C})} \boxtimes \cdots \boxtimes \overbrace{\sigma^z}^{k\text{th}} \boxtimes \cdots \boxtimes I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2^M,\mathbb{C})`),
        ],
        [
          math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})} := I_{\mathrm{Mat}(2,\mathbb{C})} \boxtimes \cdots \boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}`),
        ],
        [
          math(String.raw`V_1 := \exp\!\left(K_1 \sum_{m=1}^{M}\sigma_m^z\sigma_{m+1}^z\right)
= \exp\!\left(K_1 \left(\sigma_1^z\sigma_2^z + \sigma_2^z\sigma_3^z + \cdots + \sigma_M^z\sigma_1^z\right)\right) \in \mathrm{Mat}(2^M,\mathbb{C})`),
          "（",
          math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
          " とし、",
          math(String.raw`\sigma_{M+1}^z := \sigma_1^z`),
          " と周期的に延長した上での和である）",
        ],
        [
          math(String.raw`V_2 := (2\sinh 2K_2)^{M/2} \exp\!\left(K_2^* \left(\sigma_1^x + \sigma_2^x + \cdots + \sigma_M^x\right)\right) \in \mathrm{Mat}(2^M,\mathbb{C})`),
        ],
        [
          math(String.raw`Z_m := \sigma_1^x \cdots \sigma_{m-1}^x \sigma_m^z \in \mathrm{Mat}(2^M,\mathbb{C})`),
          "（ただし ",
          math(String.raw`Z_1 := \sigma_1^z`),
          "、",
          math(String.raw`Z_{M+1} := Z_1`),
          "。ホロノミック量子場では ",
          math(String.raw`p_m`),
          "）",
        ],
        [
          math(String.raw`Y_m := \sigma_1^x \cdots \sigma_{m-1}^x \sigma_m^y \in \mathrm{Mat}(2^M,\mathbb{C})`),
          "（ただし ",
          math(String.raw`Y_1 := \sigma_1^y`),
          "、",
          math(String.raw`Y_{M+1} := Y_1`),
          "。ホロノミック量子場では ",
          math(String.raw`q_m`),
          "）",
        ],
        [
          math(String.raw`\varepsilon := \sigma_1^x \cdots \sigma_M^x = i^M (Z_1 Y_1)(Z_2 Y_2) \cdots (Z_M Y_M) \in \mathrm{Mat}(2^M,\mathbb{C})`),
          "（右辺は ",
          math(String.raw`Z_m Y_m`),
          " の積であって和ではない。",
          math(String.raw`Z_m Y_m = \sigma_m^z \sigma_m^y = -i\,\sigma_m^x`),
          " より ",
          math(String.raw`i^M(-i)^M \sigma_1^x \cdots \sigma_M^x = \sigma_1^x \cdots \sigma_M^x`),
          " で一致する）",
        ],
        [
          math(String.raw`K_1^* := -\tfrac{1}{2}\log(\tanh K_1) \iff \sinh(2K_1)\sinh(2K_1^*) = 1`),
        ],
        [
          math(String.raw`K_2^* := -\tfrac{1}{2}\log(\tanh K_2) \iff \sinh(2K_2)\sinh(2K_2^*) = 1`),
        ],
        [
          math(String.raw`c_i := \cosh 2K_i,\quad s_i := \sinh 2K_i,\quad c_i^* := \cosh 2K_i^*,\quad s_i^* := \sinh 2K_i^*`),
        ],
      ]),
      paragraph([
        math(String.raw`K_i, K_i^* > 0`),
        " より、",
        math(String.raw`c_i, s_i, c_i^*, s_i^* > 0`),
      ]),
      paragraph([
        "ここで ",
        math(String.raw`\boxtimes`),
        " は ",
        ref("def_kronecker"),
        " のクロネッカー積であり、",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " は ",
        math(String.raw`2^M`),
        " 次の複素正方行列全体である。すなわち上の ",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z, Z_m, Y_m, \varepsilon`),
        " などはすべて具体的な ",
        math(String.raw`2^M`),
        " 次の複素行列である。",
      ]),
      paragraph([
        math(String.raw`V_1, V_2`),
        " に現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_end_iso"),
        " の同型 ",
        math(String.raw`\mathbf{end}`),
        " による同一視 ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C}) \cong \mathrm{End}(\mathcal{F})`),
        " のもとでの ",
        ref("def_exp"),
        " の ",
        math(String.raw`\exp`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文（および本ブロックの旧版）の V_1 の定義は exp(√-1 K_1 (σ^z_1σ^z_2 + ⋯ + σ^z_Mσ^z_1)) と" +
          "虚数単位を含んでいたが、これは誤りなので K_1 に訂正した。根拠: Y_m Z_{m+1} = -√-1 σ^z_mσ^z_{m+1} " +
          "（<V1_V2_in_Z_Y_epsilon> の証明 Step 2）であるから、定義を原文どおり √-1 K_1 とすると " +
          "V_1 = exp(-K_1(Y_1Z_2+⋯)) となり、原文の主張 <V1_V2_in_Z_Y_epsilon>（V_1 = exp(√-1 K_1(Y_1Z_2+⋯)））と" +
          "矛盾する。さらに 004 章以降（H_1^{(±)} の定義ブロック、V_1^{(±)} の定義、008 章）はすべて " +
          "V_1 = exp(√-1 K_1 H_1) 側と整合しており、虚数単位は Jordan--Wigner 置換 σ^z_mσ^z_{m+1} = √-1 Y_mZ_{m+1} " +
          "から生じるものである。V_2 の定義（虚数単位なし）とその主張（√-1 K_2^* が付く）も同じ理由で整合している。" +
          "また 001 章の転送行列 (V_1)_{μ,μ'} は実正値行列であり、σ^z 表示の V_1 に虚数単位が付かないことと合う。",
        "V_1 の指数の中の巡回和は M ≥ 2 でなければ意味を持たない（M = 1 では σ^z_1σ^z_2 が未定義）ため、" +
          "M ≥ 2 と σ^z_{M+1} := σ^z_1 を明示した。σ_k^a, Z_m, Y_m, ε 自体は M ≥ 1 で定義される。",
        "exp の意味（どの代数のどの位相での級数か）が書かれていなかったため、<def_end_iso> の同一視のもとでの " +
          "<def_exp> の exp であることを明示した（定義が意味をもつために必要な事項）。",
        '旧 main.typ には、見出し「対角化の計算」直下に同内容のインライン #definition("記号の定義") が' +
          "重複して置かれていた。相違は双対関係の注記のみで、そちらは旧版の sinh(K_i)sinh(K_i^*)=1" +
          "（parts/004/000 で sinh(2K_i)sinh(2K_i^*)=1 に訂正済み）。よって重複ブロックは作らず、" +
          "本ブロックへ集約した（インライン側にのみ在った σ_k^y, σ_k^z, I_{(Mat(2,C))^{⊗M}}, " +
          "p_m/q_m の対応は本ブロックへ補記済み）。",
      ],
    },
  },
  {
    id: "transfer_matrix_002_claim_Z_Y_linearly_independent",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ", ordinal: 2 },
    title: { tex: String.raw`Z_m, Y_m \text{ は線型独立}` },
    labels: ["Z_Y_linearly_independent"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_1,\dots,Z_M,Y_1,\dots,Y_M \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を考える。",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " を ",
        math(String.raw`\mathbb{C}`),
        "-線型空間とみなすとき、",
      ]),
      displayMath(
        String.raw`\{Z_1, \dots, Z_M, Y_1, \dots, Y_M\} \text{ は線型独立}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\alpha_1,\dots,\alpha_M,\beta_1,\dots,\beta_M \in \mathbb{C}`),
        " が ",
        math(String.raw`\sum_{m=1}^{M}\alpha_m Z_m+\sum_{m=1}^{M}\beta_m Y_m=0`),
        " を満たすならば、すべての ",
        math(String.raw`m`),
        " について ",
        math(String.raw`\alpha_m=\beta_m=0`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z\in\mathrm{Mat}(2,\mathbb{C})`),
        " を標準的な Pauli 行列",
      ]),
      displayMath(
        String.raw`\sigma^x=\begin{pmatrix}0&1\\1&0\end{pmatrix},\quad
\sigma^y=\begin{pmatrix}0&-i\\i&0\end{pmatrix},\quad
\sigma^z=\begin{pmatrix}1&0\\0&-1\end{pmatrix},\quad
I:=I_{\mathrm{Mat}(2,\mathbb{C})}=\begin{pmatrix}1&0\\0&1\end{pmatrix}`,
      ),
      paragraph([
        "とする。",
        ref("def_transfer_matrix_symbols"),
        " のとおり ",
        math(String.raw`\sigma_k^a`),
        "（",
        math(String.raw`a\in\{x,y,z\}`),
        "）は第 ",
        math(String.raw`k`),
        " 番目の因子（サイト）のみが ",
        math(String.raw`\sigma^a`),
        " で他の因子がすべて ",
        math(String.raw`I`),
        " である元である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\mathcal{B}:=\{I,\sigma^x,\sigma^y,\sigma^z\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底である。任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}\in\mathrm{Mat}(2,\mathbb{C})`),
        " に対して",
      ]),
      displayMath(
        String.raw`A=\frac{a_{11}+a_{22}}{2}I
+\frac{a_{12}+a_{21}}{2}\sigma^x
+\frac{i(a_{12}-a_{21})}{2}\sigma^y
+\frac{a_{11}-a_{22}}{2}\sigma^z
\quad (\because \text{成分比較})`,
      ),
      paragraph([
        "が成り立つ。右辺の 4 つの成分を 1 つずつ計算すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\frac{a_{11}+a_{22}}{2}I
+\frac{a_{12}+a_{21}}{2}\sigma^x
+\frac{i(a_{12}-a_{21})}{2}\sigma^y
+\frac{a_{11}-a_{22}}{2}\sigma^z\right)_{11}
&=\frac{a_{11}+a_{22}}{2}\cdot 1+\frac{a_{11}-a_{22}}{2}\cdot 1
&&(\because\ I_{11}=\sigma^z_{11}=1,\ \sigma^x_{11}=\sigma^y_{11}=0)\\
&=\frac{a_{11}+a_{22}}{2}+\frac{a_{11}-a_{22}}{2}
&&(\because\ \text{1 を掛けても変わらない})\\
&=\frac{2a_{11}}{2}
&&(\because\ \text{同分母の和})\\
&=a_{11}
&&(\because\ \text{約分})
\end{aligned}`),
      paragraph([
        "であり、同じ計算を残りの 3 つの成分について行うと、",
      ]),
      displayMath(String.raw`\begin{aligned}
(\cdots)_{22}
&=\frac{a_{11}+a_{22}}{2}\cdot 1+\frac{a_{11}-a_{22}}{2}\cdot(-1)
&&(\because\ I_{22}=1,\ \sigma^z_{22}=-1,\ \sigma^x_{22}=\sigma^y_{22}=0)\\
&=\frac{a_{11}+a_{22}}{2}-\frac{a_{11}-a_{22}}{2}
&&(\because\ (-1)\ \text{を掛けることは符号を変えること})\\
&=\frac{2a_{22}}{2}
&&(\because\ \text{同分母の差})\\
&=a_{22}
&&(\because\ \text{約分})\\[1ex]
(\cdots)_{12}
&=\frac{a_{12}+a_{21}}{2}\cdot 1+\frac{i(a_{12}-a_{21})}{2}\cdot(-i)
&&(\because\ \sigma^x_{12}=1,\ \sigma^y_{12}=-i,\ I_{12}=\sigma^z_{12}=0)\\
&=\frac{a_{12}+a_{21}}{2}+\frac{a_{12}-a_{21}}{2}
&&(\because\ i\cdot(-i)=1)\\
&=\frac{2a_{12}}{2}
&&(\because\ \text{同分母の和})\\
&=a_{12}
&&(\because\ \text{約分})\\[1ex]
(\cdots)_{21}
&=\frac{a_{12}+a_{21}}{2}\cdot 1+\frac{i(a_{12}-a_{21})}{2}\cdot i
&&(\because\ \sigma^x_{21}=1,\ \sigma^y_{21}=i,\ I_{21}=\sigma^z_{21}=0)\\
&=\frac{a_{12}+a_{21}}{2}-\frac{a_{12}-a_{21}}{2}
&&(\because\ i\cdot i=-1)\\
&=\frac{2a_{21}}{2}
&&(\because\ \text{同分母の差})\\
&=a_{21}
&&(\because\ \text{約分})
\end{aligned}`),
      paragraph([
        "となる（",
        math(String.raw`(\cdots)`),
        " は上と同じ右辺の行列である）。よって ",
        math(String.raw`\mathcal{B}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " を張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{B}`),
        " であるから ",
        math(String.raw`\mathcal{B}`),
        " は基底である。以下",
      ]),
      displayMath(
        String.raw`e_1:=I,\quad e_2:=\sigma^x,\quad e_3:=\sigma^y,\quad e_4:=\sigma^z`,
      ),
      paragraph(["と番号を付ける。"]),
      paragraph([
        "Step 2: クロネッカー積がつくる基底。",
        ref("tensor_basis"),
        " (2) を基底 ",
        math(String.raw`\mathcal{B}=\{e_1,e_2,e_3,e_4\}`),
        " に適用すると、多重添字 ",
        math(String.raw`(i_1,\dots,i_M)\in\{1,2,3,4\}^M`),
        " で添字づけられた族",
      ]),
      displayMath(
        String.raw`\mathcal{E}:=\left\{\,e_{i_1}\boxtimes\cdots\boxtimes e_{i_M}
\;\middle|\;(i_1,\dots,i_M)\in\{1,2,3,4\}^M\,\right\}`,
      ),
      paragraph([
        "は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底である。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`Z_m,Y_m`),
        " のクロネッカー積による表示。まず ",
        math(String.raw`1\le r\le M`),
        " と ",
        math(String.raw`a_1,\dots,a_r\in\{x,y,z\}`),
        " について",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_r^{a_r}
= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M-r}`,
      ),
      paragraph([
        "が成り立つことを ",
        math(String.raw`r`),
        " に関する帰納法で示す。",
        math(String.raw`r=1`),
        " のときは ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_1^{a_1}`),
        " の定義そのものである。",
        math(String.raw`r`),
        " で成り立つとすると、クロネッカー積の積が各サイトごとの積であること（",
        ref("kronecker_product_rule"),
        " (1)）",
      ]),
      displayMath(
        String.raw`(A_1\boxtimes\cdots\boxtimes A_M)(B_1\boxtimes\cdots\boxtimes B_M)
= (A_1B_1)\boxtimes\cdots\boxtimes(A_MB_M)`,
      ),
      paragraph(["と ", math(String.raw`AI=IA=A`), " より、"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^{a_1}\cdots\sigma_r^{a_r}\sigma_{r+1}^{a_{r+1}}
&= \left(\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes I\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(I\boxtimes\cdots\boxtimes I\boxtimes\overbrace{\sigma^{a_{r+1}}}^{(r+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
\quad (\because \text{帰納法の仮定}) \\
&= (\sigma^{a_1}I)\boxtimes\cdots\boxtimes(\sigma^{a_r}I)\boxtimes(I\sigma^{a_{r+1}})\boxtimes(II)\boxtimes\cdots\boxtimes(II)
\quad (\because \text{クロネッカー積の積の規則}) \\
&= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes\sigma^{a_{r+1}}\boxtimes
   \overbrace{I\boxtimes\cdots\boxtimes I}^{M-(r+1)}
\quad (\because AI=IA=A)
\end{aligned}`,
      ),
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m=\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        math(String.raw`Y_m=\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        " にこれを適用すると（",
        math(String.raw`m=1`),
        " のときは前半の積が空積で ",
        math(String.raw`Z_1=\sigma_1^z`),
        "、",
        math(String.raw`Y_1=\sigma_1^y`),
        " であり、下の式で ",
        math(String.raw`\sigma^x`),
        " の個数を ",
        math(String.raw`0`),
        " とすればよい）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^z}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m} \\
Y_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^y}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m}
\end{aligned}`,
      ),
      paragraph([
        "Step 4: 対応する多重添字。Step 1 の番号付け ",
        math(String.raw`e_1=I,\ e_2=\sigma^x,\ e_3=\sigma^y,\ e_4=\sigma^z`),
        " のもとで、Step 3 の表示は ",
        math(String.raw`Z_m,Y_m`),
        " がそれぞれ多重添字",
      ]),
      displayMath(
        String.raw`\zeta(m)_k:=\begin{cases}2 & (k<m)\\ 4 & (k=m)\\ 1 & (k>m)\end{cases}
\qquad
\eta(m)_k:=\begin{cases}2 & (k<m)\\ 3 & (k=m)\\ 1 & (k>m)\end{cases}`,
      ),
      paragraph([
        "に対応する ",
        math(String.raw`\mathcal{E}`),
        " の元であることを意味する。すなわち ",
        math(String.raw`Z_m=e_{\zeta(m)_1}\boxtimes\cdots\boxtimes e_{\zeta(m)_M}`),
        "、",
        math(String.raw`Y_m=e_{\eta(m)_1}\boxtimes\cdots\boxtimes e_{\eta(m)_M}`),
        "。",
      ]),
      paragraph([
        "Step 5: これら ",
        math(String.raw`2M`),
        " 個の多重添字は相異なる。",
        math(String.raw`m,m'\in\{1,\dots,M\}`),
        " について次のように場合分けする。",
      ]),
      list([
        [
          math(String.raw`\zeta(m)`),
          " と ",
          math(String.raw`\zeta(m')`),
          "（",
          math(String.raw`m<m'`),
          "）: 第 ",
          math(String.raw`m`),
          " 成分は ",
          math(String.raw`\zeta(m)_m=4`),
          "、",
          math(String.raw`\zeta(m')_m=2`),
          "（",
          math(String.raw`m<m'`),
          " より）であり相異なる。",
        ],
        [
          math(String.raw`\eta(m)`),
          " と ",
          math(String.raw`\eta(m')`),
          "（",
          math(String.raw`m<m'`),
          "）: 第 ",
          math(String.raw`m`),
          " 成分は ",
          math(String.raw`\eta(m)_m=3`),
          "、",
          math(String.raw`\eta(m')_m=2`),
          " であり相異なる。",
        ],
        [
          math(String.raw`\zeta(m)`),
          " と ",
          math(String.raw`\eta(m')`),
          " で ",
          math(String.raw`m=m'`),
          " のとき: 第 ",
          math(String.raw`m`),
          " 成分は ",
          math(String.raw`4`),
          " と ",
          math(String.raw`3`),
          " で相異なる。",
        ],
        [
          math(String.raw`\zeta(m)`),
          " と ",
          math(String.raw`\eta(m')`),
          " で ",
          math(String.raw`m<m'`),
          " のとき: 第 ",
          math(String.raw`m`),
          " 成分は ",
          math(String.raw`4`),
          " と ",
          math(String.raw`2`),
          " で相異なる。",
        ],
        [
          math(String.raw`\zeta(m)`),
          " と ",
          math(String.raw`\eta(m')`),
          " で ",
          math(String.raw`m>m'`),
          " のとき: 第 ",
          math(String.raw`m'`),
          " 成分は ",
          math(String.raw`\zeta(m)_{m'}=2`),
          "（",
          math(String.raw`m'<m`),
          " より）と ",
          math(String.raw`\eta(m')_{m'}=3`),
          " で相異なる。",
        ],
      ]),
      paragraph([
        "以上より ",
        math(String.raw`\zeta(1),\dots,\zeta(M),\eta(1),\dots,\eta(M)`),
        " は相異なる ",
        math(String.raw`2M`),
        " 個の多重添字であり、対応する ",
        math(String.raw`Z_1,\dots,Z_M,Y_1,\dots,Y_M`),
        " は基底 ",
        math(String.raw`\mathcal{E}`),
        " の相異なる ",
        math(String.raw`2M`),
        " 個の元である。",
      ]),
      paragraph([
        "Step 6: 結論。",
        math(String.raw`\alpha_1,\dots,\alpha_M,\beta_1,\dots,\beta_M\in\mathbb{C}`),
        " が",
      ]),
      displayMath(
        String.raw`\sum_{m=1}^{M}\alpha_m Z_m+\sum_{m=1}^{M}\beta_m Y_m=0`,
      ),
      paragraph([
        "を満たすとする。Step 5 より左辺は基底 ",
        math(String.raw`\mathcal{E}`),
        " の相異なる元の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合であり、",
        math(String.raw`\mathcal{E}`),
        " のそれ以外の元の係数は ",
        math(String.raw`0`),
        " である。基底による表示は一意（特に ",
        math(String.raw`0`),
        " の表示はすべての係数が ",
        math(String.raw`0`),
        "）であるから、",
      ]),
      displayMath(
        String.raw`\alpha_1=\cdots=\alpha_M=\beta_1=\cdots=\beta_M=0`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\{Z_1,\dots,Z_M,Y_1,\dots,Y_M\}`),
        " は線型独立である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO: 証明略」のみ。ここで証明を与えた。",
        "原文の statement は式のみで、どの体上・どの空間での線型独立かが書かれていなかったため、" +
          "Mat(2,C)^{⊗M} を C-線型空間とみなしたときの線型独立性であることを statement に明示した" +
          "（主張の内容自体は変えていない）。",
        "記号の定義（labels: def_transfer_matrix_symbols）は sigma^x, sigma^y, sigma^z を" +
          "定義せずに sigma_k^x 等を導入している。本証明では標準的な Pauli 行列として明示した" +
          "（Z_Y_generate_algebra の証明も同じ扱いをしている）。",
      ],
    },
  },
  {
    id: "transfer_matrix_003_claim_V1_V2_in_Z_Y_epsilon",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/002_claim_V1V2をZYepsilonで表す.typ", ordinal: 3 },
    title: { tex: String.raw`V_1, V_2 \text{ を } Z, Y, \varepsilon \text{ で表す}` },
    labels: ["V1_V2_in_Z_Y_epsilon"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1, V_2, Z_m, Y_m, \varepsilon, K_1, K_2^*, s_2 \;(= \sinh 2K_2)`),
        " を考える。このとき ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V_1 &= \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1} Z_M - \varepsilon Y_M Z_1)\right) \\
V_2 &= (2s_2)^{M/2} \exp\!\left(i K_2^* (Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_M Y_M)\right)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`i \in \mathbb{C}`),
        " は虚数単位）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の方針: ",
        math(String.raw`\exp`),
        " の中身どうしが ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の元として等しいことを示す。",
        math(String.raw`\exp`),
        " は写像であるから、これが示されれば ",
        math(String.raw`\exp`),
        " の値も等しく、主張が従う（したがって ",
        ref("theorem_exp_product"),
        " のような ",
        math(String.raw`\exp`),
        " の分解は用いない）。",
      ]),
      paragraph([
        "以下、",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z, I := I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2,\mathbb{C})`),
        " は ",
        ref("pauli_matrix_products"),
        " の Pauli 行列とし、クロネッカー積の積が各サイトごとの積であること（",
        ref("kronecker_product_rule"),
        " (1)）",
      ]),
      displayMath(
        String.raw`(A_1\boxtimes\cdots\boxtimes A_M)(B_1\boxtimes\cdots\boxtimes B_M)
= (A_1B_1)\boxtimes\cdots\boxtimes(A_MB_M)
\quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "と、クロネッカー積が各因子について ",
        math(String.raw`\mathbb{C}`),
        "-線型であること（",
        ref("kronecker_multilinear"),
        "）",
      ]),
      displayMath(
        String.raw`C_1\boxtimes\cdots\boxtimes\overbrace{(c\,C_j)}^{j\text{th}}\boxtimes\cdots\boxtimes C_M
= c\,(C_1\boxtimes\cdots\boxtimes C_M) \quad (c\in\mathbb{C})
\quad (\because \text{第 } j \text{ 因子についての } \mathbb{C}\text{-線型性})`,
      ),
      paragraph(["を繰り返し用いる。"]),
      paragraph([
        "Step 0: 単一サイトの Pauli 行列の積。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x\sigma^x = I`),
        " に加えて、以下の 3 式を ",
        math(String.raw`2\times 2`),
        " 行列の積の成分計算（",
        ref("mat_mult"),
        "）で確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}0\cdot0+(-i)\cdot1 & 0\cdot1+(-i)\cdot0 \\ i\cdot0+0\cdot1 & i\cdot1+0\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= -i\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= -i\,\sigma^z
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^y
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}0\cdot0+1\cdot i & 0\cdot(-i)+1\cdot0 \\ 1\cdot0+0\cdot i & 1\cdot(-i)+0\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}i&0\\0&-i\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= i\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= i\,\sigma^z
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}1\cdot0+0\cdot i & 1\cdot(-i)+0\cdot0 \\ 0\cdot0+(-1)\cdot i & 0\cdot(-i)+(-1)\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= -i\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= -i\,\sigma^x
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 1: ",
        math(String.raw`Z_m, Y_m, \varepsilon, \sigma_m^z\sigma_{m+1}^z, \sigma_m^x`),
        " のクロネッカー積による表示。まず ",
        math(String.raw`1\le r\le M`),
        " と ",
        math(String.raw`a_1,\dots,a_r\in\{x,y,z\}`),
        " について",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_r^{a_r}
= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M-r}`,
      ),
      paragraph([
        "が成り立つ。これを ",
        math(String.raw`r`),
        " に関する帰納法で示す。",
        math(String.raw`r=1`),
        " のときは ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_1^{a_1}`),
        " の定義そのものである。",
        math(String.raw`r`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^{a_1}\cdots\sigma_r^{a_r}\sigma_{r+1}^{a_{r+1}}
&= \left(\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(I\boxtimes\cdots\boxtimes I\boxtimes\overbrace{\sigma^{a_{r+1}}}^{(r+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
\quad (\because \text{帰納法の仮定}) \\
&= (\sigma^{a_1}I)\boxtimes\cdots\boxtimes(\sigma^{a_r}I)\boxtimes(I\sigma^{a_{r+1}})\boxtimes(II)\boxtimes\cdots\boxtimes(II)
\quad (\because \text{クロネッカー積の積の規則}) \\
&= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_{r+1}}\boxtimes
   \overbrace{I\boxtimes\cdots\boxtimes I}^{M-(r+1)}
\quad (\because AI=IA=A)
\end{aligned}`,
      ),
      paragraph([
        "これを ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        "、",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x`),
        " に適用すると（",
        math(String.raw`m=1`),
        " のときは前半の積が空積で ",
        math(String.raw`Z_1=\sigma_1^z`),
        "、",
        math(String.raw`Y_1=\sigma_1^y`),
        "。以下の式で ",
        math(String.raw`\sigma^x`),
        " の個数を ",
        math(String.raw`0`),
        " とすればよい）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^z}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m} \\
Y_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^y}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m} \\
\varepsilon &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M}
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\sigma_m^x`),
        " は第 ",
        math(String.raw`m`),
        " 因子のみ ",
        math(String.raw`\sigma^x`),
        " で他は ",
        math(String.raw`I`),
        " であり、",
        math(String.raw`1\le m\le M-1`),
        " について（第 ",
        math(String.raw`m`),
        " 因子と第 ",
        math(String.raw`m+1`),
        " 因子以外はすべて ",
        math(String.raw`II=I`),
        "）",
      ]),
      displayMath(
        String.raw`\sigma_m^z\sigma_{m+1}^z
= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}
\quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "である。同様に ",
        math(String.raw`M\ge 2`),
        " より第 ",
        math(String.raw`1`),
        " 因子と第 ",
        math(String.raw`M`),
        " 因子は異なるので",
      ]),
      displayMath(
        String.raw`\sigma_M^z\sigma_1^z
= \overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-2}\boxtimes\overbrace{\sigma^z}^{M\text{th}}
= \sigma_1^z\sigma_M^z
\quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`1\le m\le M-1`),
        " について ",
        math(String.raw`Y_m Z_{m+1} = -i\,\sigma_m^z\sigma_{m+1}^z`),
        "。Step 1 の表示を用いて因子ごとに計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_m Z_{m+1}
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^y}^{m\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^x}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
\quad (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}
   \boxtimes\overbrace{(\sigma^y\sigma^x)}^{m\text{th}}\boxtimes\overbrace{(I\sigma^z)}^{(m+1)\text{th}}\boxtimes(II)\boxtimes\cdots\boxtimes(II)
\quad (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{(-i\,\sigma^z)}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I
\quad (\because \sigma^x\sigma^x = I,\ \sigma^y\sigma^x = -i\,\sigma^z \text{（Step 0）}) \\
&= (-i)\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
\quad (\because \text{第 } m \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= -i\,\sigma_m^z\sigma_{m+1}^z \quad (\because \text{Step 1})
\end{aligned}`,
      ),
      paragraph([
        "両辺に ",
        math(String.raw`i \in \mathbb{C}`),
        " を掛け ",
        math(String.raw`i\cdot(-i) = 1`),
        " を使うと",
      ]),
      displayMath(
        String.raw`\sigma_m^z\sigma_{m+1}^z = i\,Y_m Z_{m+1} \qquad (1\le m\le M-1)`,
      ),
      paragraph([
        "Step 3: 境界項 ",
        math(String.raw`\varepsilon\, Y_M Z_1 = i\,\sigma_M^z\sigma_1^z`),
        "。ここで Jordan--Wigner 文字列 ",
        math(String.raw`\sigma_1^x\cdots\sigma_{M-1}^x`),
        " が周期境界で一周し、",
        math(String.raw`Z_1 = \sigma_1^z`),
        " の側に文字列が付いていないため、Step 2 の計算では第 ",
        math(String.raw`1`),
        " 因子の ",
        math(String.raw`\sigma^x`),
        " が相殺せずに残る。これを打ち消すのが ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x`),
        " である。実際、",
        math(String.raw`M\ge 2`),
        " のもとで 3 つの元の積を（クロネッカー積の積の規則を 2 回使って）因子ごとに計算すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\, Y_M Z_1
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M}\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-1}\boxtimes\overbrace{\sigma^y}^{M\text{th}}\right)
   \left(\overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-1}\right)
\quad (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x\sigma^z)}^{1\text{st}}
   \boxtimes\overbrace{(\sigma^x\sigma^x I)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x I)}^{2\text{nd},\dots,(M-1)\text{th}}
   \boxtimes\overbrace{(\sigma^x\sigma^y I)}^{M\text{th}}
\quad (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-2}\boxtimes\overbrace{(i\,\sigma^z)}^{M\text{th}}
\quad (\because \sigma^x\sigma^x = I,\ AI=A,\ \sigma^x\sigma^y = i\,\sigma^z \text{（Step 0）}) \\
&= i\left(\overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-2}\boxtimes\overbrace{\sigma^z}^{M\text{th}}\right)
\quad (\because \text{第 } M \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= i\,\sigma_M^z\sigma_1^z \quad (\because \text{Step 1 の最後の式})
\end{aligned}`,
      ),
      paragraph([
        "両辺に ",
        math(String.raw`-i`),
        " を掛け ",
        math(String.raw`(-i)\cdot i = 1`),
        " を使うと",
      ]),
      displayMath(
        String.raw`\sigma_M^z\sigma_1^z = -i\,\varepsilon\, Y_M Z_1`,
      ),
      paragraph([
        "Step 4: ",
        math(String.raw`1\le m\le M`),
        " について ",
        math(String.raw`Z_m Y_m = -i\,\sigma_m^x`),
        "。同様に因子ごとに計算すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_m Y_m
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^y}^{m\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
\quad (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}\boxtimes\overbrace{(\sigma^z\sigma^y)}^{m\text{th}}\boxtimes(II)\boxtimes\cdots\boxtimes(II)
\quad (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{(-i\,\sigma^x)}^{m\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I
\quad (\because \sigma^x\sigma^x = I,\ \sigma^z\sigma^y = -i\,\sigma^x \text{（Step 0）}) \\
&= (-i)\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{\sigma^x}^{m\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
\quad (\because \text{第 } m \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= -i\,\sigma_m^x
\end{aligned}`,
      ),
      paragraph([
        "（これは ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon`),
        " の項に書かれている等式 ",
        math(String.raw`Z_m Y_m = -i\,\sigma_m^x`),
        " の証明でもある。）両辺に ",
        math(String.raw`i`),
        " を掛けて",
      ]),
      displayMath(String.raw`\sigma_m^x = i\,Z_m Y_m \qquad (1\le m\le M)`),
      paragraph([
        "Step 5: ",
        math(String.raw`V_1`),
        " の表式。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1`),
        " の指数の中身を、",
        math(String.raw`\sigma_{M+1}^z = \sigma_1^z`),
        " により最後の項 ",
        math(String.raw`\sigma_M^z\sigma_{M+1}^z = \sigma_M^z\sigma_1^z`),
        " だけ分けて書くと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
K_1\sum_{m=1}^{M}\sigma_m^z\sigma_{m+1}^z
&= K_1\left(\sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z\right) + K_1\,\sigma_M^z\sigma_1^z \\
&= K_1\left(\sum_{m=1}^{M-1} i\,Y_m Z_{m+1}\right) + K_1\left(-i\,\varepsilon\,Y_M Z_1\right)
\quad (\because \text{Step 2, Step 3}) \\
&= i K_1\left(\sum_{m=1}^{M-1} Y_m Z_{m+1} - \varepsilon\, Y_M Z_1\right)
\quad (\because \mathbb{C}\text{-線型空間 } \mathrm{Mat}(2^M,\mathbb{C}) \text{ でのスカラー倍の分配律}) \\
&= i K_1\left(Y_1Z_2 + Y_2Z_3 + \cdots + Y_{M-1}Z_M - \varepsilon\,Y_M Z_1\right)
\end{aligned}`,
      ),
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の同一の元であるから、",
        math(String.raw`\exp`),
        " の値も等しく、",
      ]),
      displayMath(
        String.raw`V_1 = \exp\!\left(K_1\sum_{m=1}^{M}\sigma_m^z\sigma_{m+1}^z\right)
= \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1} Z_M - \varepsilon Y_M Z_1)\right)`,
      ),
      paragraph([
        "Step 6: ",
        math(String.raw`V_2`),
        " の表式。同様に、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
K_2^*\left(\sigma_1^x + \sigma_2^x + \cdots + \sigma_M^x\right)
&= K_2^*\sum_{m=1}^{M} i\,Z_m Y_m \quad (\because \text{Step 4}) \\
&= i K_2^*\left(Z_1Y_1 + Z_2Y_2 + \cdots + Z_MY_M\right)
\quad (\because \text{スカラー倍の分配律})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`s_2 = \sinh 2K_2`),
        " より係数は ",
        math(String.raw`(2\sinh 2K_2)^{M/2} = (2s_2)^{M/2}`),
        " であるから、",
      ]),
      displayMath(
        String.raw`V_2 = (2s_2)^{M/2}\exp\!\left(i K_2^* (Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_M Y_M)\right)`,
      ),
      paragraph(["以上で 2 式が示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO」のみ。ここで証明を与えた。",
        "証明の過程で、原文の V_1 の定義に含まれていた虚数単位が誤りであることが判明したため、" +
          "<def_transfer_matrix_symbols> 側を訂正した（理由はそちらの conversion.notes を参照）。",
        "原文の statement は式のみで M の範囲・記号の出典が書かれていなかったため、M ≥ 2 と" +
          "参照先（<def_transfer_matrix_symbols>）を明示した（主張の内容自体は変えていない）。",
      ],
    },
  },
  {
    id: "transfer_matrix_005_definition_end_isomorphism",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/004_転送行列/004_definition_EndFとMat2Cテンソル積Mの同型.typ",
      ordinal: 5,
    },
    title: { tex: String.raw`\mathbf{end}: \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{End}(\mathcal{F})` },
    labels: ["def_end_iso"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、",
      ]),
      displayMath(String.raw`\mathcal{F} := \mathbb{C}^{2^M}`),
      paragraph([
        "とおく（",
        math(String.raw`2^M`),
        " 次元の数ベクトル全体。",
        ref("def_kronecker"),
        " のクロネッカー積 ",
        math(String.raw`v_1\boxtimes\cdots\boxtimes v_M`),
        " が住む空間である）。",
        math(String.raw`\mathbb{C}^2`),
        " の標準基底を ",
        math(String.raw`e_1 := (1,0),\ e_2 := (0,1)`),
        "、",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位を ",
        math(String.raw`E_{ij}`),
        "（",
        math(String.raw`(i,j)`),
        " 成分が ",
        math(String.raw`1`),
        " で他が ",
        math(String.raw`0`),
        "、",
        math(String.raw`i,j\in\{1,2\}`),
        "）とする。多重添字 ",
        math(String.raw`\mathcal{I} := \{1,2\}^M`),
        " の元 ",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)`),
        " について",
      ]),
      displayMath(
        String.raw`f_I := e_{i_1}\boxtimes\cdots\boxtimes e_{i_M} \in \mathcal{F}, \qquad
E_{I,J} := E_{i_1j_1}\boxtimes\cdots\boxtimes E_{i_Mj_M} \in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "とおく（",
        ref("def_kronecker"),
        " のクロネッカー積。",
        math(String.raw`f_I \in \mathbb{C}^{2^M}`),
        " は数ベクトル、",
        math(String.raw`E_{I,J} \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " は ",
        math(String.raw`2^M`),
        " 次の複素行列である）。",
        ref("tensor_basis"),
        " (3) と (1) より ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " は ",
        math(String.raw`\mathcal{F}`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底（",
        math(String.raw`\dim_{\mathbb{C}}\mathcal{F} = 2^M`),
        "）であり、",
        math(String.raw`(E_{I,J})_{I,J\in\mathcal{I}}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底（",
        math(String.raw`\dim_{\mathbb{C}} = 4^M`),
        "）である。さらに ",
        math(String.raw`\Theta_{I,J} \in \mathrm{End}(\mathcal{F})`),
        " を、基底 ",
        math(String.raw`(f_K)_{K\in\mathcal{I}}`),
        " 上の値",
      ]),
      displayMath(
        String.raw`\Theta_{I,J}(f_K) := \begin{cases} f_I & (K=J) \\ 0 & (K\neq J)\end{cases}`,
      ),
      paragraph([
        "で定まる ",
        math(String.raw`\mathbb{C}`),
        "-線型写像とする（基底上の値を与えれば線型写像が一意に定まる）。このとき ",
        math(String.raw`\mathbf{end}`),
        " を、基底 ",
        math(String.raw`(E_{I,J})`),
        " 上で",
      ]),
      displayMath(
        String.raw`\mathbf{end}(E_{I,J}) := \Theta_{I,J} \qquad (I,J\in\mathcal{I})`,
      ),
      paragraph([
        "と定めて ",
        math(String.raw`\mathbb{C}`),
        "-線型に拡張した写像",
      ]),
      displayMath(
        String.raw`\mathbf{end}: \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{End}(\mathcal{F})`,
      ),
      paragraph([
        "とおく（",
        ref("end_is_algebra_isomorphism"),
        " より、これは単位的 ",
        math(String.raw`\mathbb{C}`),
        "-代数の同型である）。",
        math(String.raw`A \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " の ",
        math(String.raw`\mathcal{F}`),
        " への作用 ",
        math(String.raw`Af`),
        "（",
        math(String.raw`f\in\mathcal{F}`),
        "）は、以後つねに ",
        math(String.raw`(\mathbf{end}(A))(f)`),
        " を意味する。",
      ]),
      paragraph([
        math(String.raw`\mathcal{F}`),
        " は基底 ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " による座標表示で ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " と同一視され、",
        ref("def_matrix_norm"),
        " のノルムにより有限次元 ",
        math(String.raw`\mathbb{C}`),
        "-ノルム線型空間となる。この同一視のもとで ",
        math(String.raw`\mathrm{End}(\mathcal{F})`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " と同一視され、",
        ref("def_exp"),
        " の ",
        math(String.raw`\exp : \mathrm{End}(\mathcal{F}) \to \mathrm{End}(\mathcal{F})`),
        " が定まる。そこで ",
        math(String.raw`A \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " に対する ",
        math(String.raw`\exp(A)`),
        " を、この同型による移送で",
      ]),
      displayMath(
        String.raw`\exp(A) := \mathbf{end}^{-1}\!\left(\exp(\mathbf{end}(A))\right)
\in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "と定める。定義から直ちに",
      ]),
      displayMath(
        String.raw`\mathbf{end}(\exp(A)) = \exp(\mathbf{end}(A)) \qquad (A \in \mathrm{Mat}(2^M,\mathbb{C}))`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathbf{end}`),
        " は単位的代数の同型なので、部分和も ",
        math(String.raw`\mathbf{end}\!\left(\sum_{n=0}^{N}\frac{1}{n!}A^n\right) = \sum_{n=0}^{N}\frac{1}{n!}(\mathbf{end}(A))^n`),
        " と対応する）。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文は「End(F) と Mat(2,C)^{⊗M} の線型同型写像を一つ取る」としか書いていないが、" +
          "任意に取った線型同型では積・単位元が保たれず、<V1_restriction_to_eigenspaces> の証明" +
          "（ε の作用と exp の級数を交換する）が成立しない。そこで、正準な単位的 C-代数同型を" +
          "具体的に構成する形に書き換えた（正しさに必要な事項なので statement に置く）。",
        "写像の向きも原文は End(F) → Mat(2,C)^{⊗M} だが、原文の <V1_restriction_to_eigenspaces> は " +
          "end(V_1)|_{F^{(±)}} と、Mat(2,C)^{⊗M} の元 V_1 に end を適用して F 上の写像として制限している。" +
          "向きが逆でなければ型が合わないため、Mat(2,C)^{⊗M} → End(F) に訂正した。",
        "Mat(2,C)^{⊗M} 上の exp（<def_transfer_matrix_symbols> の V_1, V_2 で使われている）は、" +
          "どの位相での級数か原文に書かれていない。ここで end による移送として定義を与えた。",
      ],
    },
  },
  {
    id: "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 5 },
    title: { tex: String.raw`\mathbf{end} \text{ は単位的 } \mathbb{C}\text{-代数の同型}` },
    labels: ["end_is_algebra_isomorphism"],
    statement: [
      paragraph([
        ref("def_end_iso"),
        " の ",
        math(String.raw`\mathbf{end}`),
        " について、次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\mathbf{end}`),
          " は ",
          math(String.raw`\mathbb{C}`),
          "-線型同型（全単射）である。",
        ],
        [
          "(2) ",
          math(String.raw`\mathbf{end}(AB) = \mathbf{end}(A)\circ\mathbf{end}(B)`),
          "（",
          math(String.raw`A,B\in\mathrm{Mat}(2^M,\mathbb{C})`),
          "）。",
        ],
        [
          "(3) ",
          math(String.raw`\mathbf{end}\!\left(I_{\mathrm{Mat}(2^M,\mathbb{C})}\right) = \mathrm{id}_{\mathcal{F}}`),
          "。",
        ],
        [
          "(4) ",
          math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
          " と ",
          math(String.raw`v_1,\dots,v_M \in \mathbb{C}^2`),
          " について ",
          math(
            String.raw`\left(\mathbf{end}(A_1\boxtimes\cdots\boxtimes A_M)\right)(v_1\boxtimes\cdots\boxtimes v_M)
= (A_1v_1)\boxtimes\cdots\boxtimes(A_Mv_M)`,
          ),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "記号は ",
        ref("def_end_iso"),
        " のものとする。多重添字 ",
        math(String.raw`I,J\in\mathcal{I}=\{1,2\}^M`),
        " について ",
        math(String.raw`\delta_{I,J} := 1`),
        "（",
        math(String.raw`I=J`),
        "）、",
        math(String.raw`0`),
        "（",
        math(String.raw`I\neq J`),
        "）とおく。成分ごとの ",
        math(String.raw`\delta_{i,j}`),
        " についても同様とし、",
        math(String.raw`I=J \iff \forall m,\ i_m=j_m`),
        " より",
      ]),
      displayMath(String.raw`\delta_{I,J} = \prod_{m=1}^{M}\delta_{i_m,j_m}`),
      paragraph(["が成り立つ。"]),
      paragraph([
        "Step 1: ",
        math(String.raw`(\Theta_{I,J})_{I,J\in\mathcal{I}}`),
        " は ",
        math(String.raw`\mathrm{End}(\mathcal{F})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底である。まず張ること: ",
        math(String.raw`T\in\mathrm{End}(\mathcal{F})`),
        " を任意に取り、基底 ",
        math(String.raw`(f_I)`),
        " による表示 ",
        math(String.raw`T(f_J) = \sum_{I\in\mathcal{I}} t_{I,J} f_I`),
        "（",
        math(String.raw`t_{I,J}\in\mathbb{C}`),
        " は一意）を取ると、任意の ",
        math(String.raw`K\in\mathcal{I}`),
        " について",
      ]),
      displayMath(
        String.raw`\left(\sum_{I,J\in\mathcal{I}} t_{I,J}\Theta_{I,J}\right)(f_K)
= \sum_{I,J\in\mathcal{I}} t_{I,J}\,\delta_{J,K} f_I
= \sum_{I\in\mathcal{I}} t_{I,K} f_I
= T(f_K)`,
      ),
      paragraph([
        "であり、基底上で一致する線型写像は等しいから ",
        math(String.raw`T = \sum_{I,J} t_{I,J}\Theta_{I,J}`),
        "。次に線型独立性: ",
        math(String.raw`c_{I,J}\in\mathbb{C}`),
        " が ",
        math(String.raw`\sum_{I,J} c_{I,J}\Theta_{I,J} = 0`),
        " を満たすとすると、各 ",
        math(String.raw`K`),
        " について ",
        math(String.raw`0 = \sum_{I,J} c_{I,J}\delta_{J,K}f_I = \sum_{I} c_{I,K}f_I`),
        " であり、",
        math(String.raw`(f_I)`),
        " が基底だからすべての ",
        math(String.raw`I`),
        " で ",
        math(String.raw`c_{I,K}=0`),
        "。",
        math(String.raw`K`),
        " は任意だからすべての係数が ",
        math(String.raw`0`),
        " である。",
      ]),
      paragraph([
        "Step 2: (1)。",
        math(String.raw`\mathbf{end}`),
        " は基底 ",
        math(String.raw`(E_{I,J})`),
        " を基底 ",
        math(String.raw`(\Theta_{I,J})`),
        " へ、添字を保って一対一に写す線型写像である。基底を基底へ写す線型写像は全単射である" +
          "（基底の像が張るので全射、基底の像が線型独立なので単射）。",
      ]),
      paragraph([
        "Step 3: (2)。両辺は ",
        math(String.raw`(A,B)`),
        " について ",
        math(String.raw`\mathbb{C}`),
        "-双線型（左辺は積の双線型性と ",
        math(String.raw`\mathbf{end}`),
        " の線型性、右辺は写像の合成の双線型性）だから、基底の元 ",
        math(String.raw`A=E_{I,J},\ B=E_{K,L}`),
        " について示せば十分である。",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位の積は ",
        math(String.raw`E_{ij}E_{kl} = \delta_{j,k}E_{il}`),
        "（成分計算）であるから、クロネッカー積の積の規則（",
        ref("kronecker_product_rule"),
        " (1)）と各因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{I,J}E_{K,L}
&= (E_{i_1j_1}E_{k_1l_1})\boxtimes\cdots\boxtimes(E_{i_Mj_M}E_{k_Ml_M})
\quad (\because \text{クロネッカー積の積の規則}) \\
&= (\delta_{j_1,k_1}E_{i_1l_1})\boxtimes\cdots\boxtimes(\delta_{j_M,k_M}E_{i_Ml_M}) \\
&= \left(\prod_{m=1}^{M}\delta_{j_m,k_m}\right) E_{I,L}
\quad (\because \text{各因子についての } \mathbb{C}\text{-線型性})
= \delta_{J,K}E_{I,L}
\end{aligned}`,
      ),
      paragraph(["一方、任意の ", math(String.raw`P\in\mathcal{I}`), " について"]),
      displayMath(
        String.raw`\left(\Theta_{I,J}\circ\Theta_{K,L}\right)(f_P)
= \Theta_{I,J}\!\left(\delta_{L,P}f_K\right)
= \delta_{L,P}\,\delta_{J,K}\,f_I
= \delta_{J,K}\,\Theta_{I,L}(f_P)`,
      ),
      paragraph([
        "であり、基底上で一致するから ",
        math(String.raw`\Theta_{I,J}\circ\Theta_{K,L} = \delta_{J,K}\Theta_{I,L}`),
        "。よって",
      ]),
      displayMath(
        String.raw`\mathbf{end}(E_{I,J}E_{K,L}) = \delta_{J,K}\mathbf{end}(E_{I,L}) = \delta_{J,K}\Theta_{I,L}
= \Theta_{I,J}\circ\Theta_{K,L} = \mathbf{end}(E_{I,J})\circ\mathbf{end}(E_{K,L})`,
      ),
      paragraph([
        "Step 4: (3)。",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})} = E_{11}+E_{22}`),
        "、",
        ref("kronecker_product_rule"),
        " (2)、およびクロネッカー積の各因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "。和で展開する）より",
      ]),
      displayMath(
        String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})}
= \underbrace{(E_{11}+E_{22})\boxtimes\cdots\boxtimes(E_{11}+E_{22})}_{M}
= \sum_{I\in\mathcal{I}} E_{I,I}`,
      ),
      paragraph([
        "であり、各 ",
        math(String.raw`K\in\mathcal{I}`),
        " について ",
        math(String.raw`\left(\sum_{I}\Theta_{I,I}\right)(f_K) = \sum_{I}\delta_{I,K}f_I = f_K`),
        " だから ",
        math(String.raw`\sum_{I}\Theta_{I,I} = \mathrm{id}_{\mathcal{F}}`),
        "。よって ",
        math(String.raw`\mathbf{end}\!\left(I_{\mathrm{Mat}(2^M,\mathbb{C})}\right) = \mathrm{id}_{\mathcal{F}}`),
        "。",
      ]),
      paragraph([
        "Step 5: (4)。両辺は ",
        math(String.raw`A_1,\dots,A_M,v_1,\dots,v_M`),
        " の各々について ",
        math(String.raw`\mathbb{C}`),
        "-線型であるから、",
        math(String.raw`A_m = E_{i_mj_m}`),
        "、",
        math(String.raw`v_m = e_{k_m}`),
        " の場合に示せば十分である。",
        math(String.raw`E_{ij}e_k = \delta_{j,k}e_i`),
        "（成分計算）より右辺は",
      ]),
      displayMath(
        String.raw`(E_{i_1j_1}e_{k_1})\boxtimes\cdots\boxtimes(E_{i_Mj_M}e_{k_M})
= \left(\prod_{m=1}^{M}\delta_{j_m,k_m}\right)f_I
= \delta_{J,K}f_I`,
      ),
      paragraph([
        "であり、左辺は ",
        math(String.raw`\left(\mathbf{end}(E_{I,J})\right)(f_K) = \Theta_{I,J}(f_K) = \delta_{J,K}f_I`),
        " であるから一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文（Typst）に対応ブロックは無い。原文が「線型同型を一つ取る」で済ませていた end を" +
          "正準な単位的代数同型として構成したため、その性質（<V1_restriction_to_eigenspaces> の証明で" +
          "実際に使うのは線型性・乗法性・単位元の保存）をここで証明した。",
      ],
    },
  },
  {
    id: "transfer_matrix_004_definition_eigenspaces_of_epsilon",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/003_definition_epsilonの固有空間.typ", ordinal: 4 },
    title: { tex: String.raw`\varepsilon \text{ の固有空間}` },
    labels: ["def_eigenspaces_of_epsilon"],
    statement: [
      paragraph([
        ref("def_end_iso"),
        " の ",
        math(String.raw`\mathcal{F} = \mathbb{C}^{2^M}`),
        " と、",
        math(String.raw`\varepsilon \in \mathrm{Mat}(2^M,\mathbb{C})`),
        "（",
        ref("def_transfer_matrix_symbols"),
        "）の ",
        math(String.raw`\mathbf{end}`),
        " による ",
        math(String.raw`\mathcal{F}`),
        " への作用について、",
      ]),
      displayMath(
        String.raw`\mathcal{F}^{(\pm)} := \{f \in \mathcal{F} \mid \varepsilon f = \pm f\}
= \{f \in \mathcal{F} \mid (\mathbf{end}(\varepsilon))(f) = \pm f\}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\mathbf{end}(\varepsilon)`),
        " は線型写像だから、",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " は ",
        math(String.raw`\mathcal{F}`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-部分線型空間である。",
      ]),
      paragraph([
        "なお ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x = \sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " と ",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x\sigma^x = I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "、および ",
        ref("kronecker_product_rule"),
        " (1)(2) より",
      ]),
      displayMath(
        String.raw`\varepsilon^2 = (\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)
= I_{\mathrm{Mat}(2^M,\mathbb{C})}
\quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "であるから、",
        ref("end_is_algebra_isomorphism"),
        " (2)(3) より ",
        math(String.raw`(\mathbf{end}(\varepsilon))^2 = \mathrm{id}_{\mathcal{F}}`),
        " であり、",
        math(String.raw`\mathbf{end}(\varepsilon)`),
        " の固有値は ",
        math(String.raw`\pm 1`),
        " に限る（固有値 ",
        math(String.raw`\lambda`),
        " と固有ベクトル ",
        math(String.raw`f\neq 0`),
        " について ",
        math(String.raw`f = (\mathbf{end}(\varepsilon))^2 f = \lambda^2 f`),
        " より ",
        math(String.raw`\lambda^2=1`),
        "）。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文は εf の意味（ε は Mat(2,C)^{⊗M} の元であって F の自己準同型ではない）を書いていないため、" +
          "<def_end_iso> の end による作用であることを明示した。あわせて、原文が「ε² = 1 より固有値は ±1」と" +
          "根拠なしに述べていた部分に、ε² = I の因子ごとの計算と固有値が ±1 に限る理由を補った。",
        "本ブロックは原文では end の定義より前に置かれていたが、εf の意味が end を要するため、" +
          "<def_end_iso> の後ろへ移した（内容は変えていない）。",
      ],
    },
  },
  {
    id: "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/005_claim_V1の固有空間への制限.typ", ordinal: 6 },
    title: { tex: String.raw`V_1 \text{ の固有空間への制限}` },
    labels: ["V1_restriction_to_eigenspaces"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1`),
        "、",
        ref("def_end_iso"),
        " の ",
        math(String.raw`\mathbf{end}`),
        "、",
        ref("def_eigenspaces_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " について（複号同順）、",
      ]),
      displayMath(
        String.raw`\left(\mathbf{end}(V_1)\right)\big|_{\mathcal{F}^{(\pm)}}
= \left(\mathbf{end}\!\left(\exp\!\left(i K_1 (Y_1 Z_2 + \cdots + Y_{M-1} Z_M \mp Y_M Z_1)\right)\right)\right)\big|_{\mathcal{F}^{(\pm)}}`,
      ),
      paragraph([
        "が成り立つ。両辺は ",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " から ",
        math(String.raw`\mathcal{F}`),
        " への写像として一致する、という意味である（右辺の ",
        math(String.raw`\exp(\cdots)`),
        " は ",
        ref("def_V1_pm"),
        " の ",
        math(String.raw`V_1^{(\pm)}`),
        " に他ならない）。",
      ]),
    ],
    proof: [
      paragraph([
        "記号を固定する。",
        ref("V1_V2_in_Z_Y_epsilon"),
        " より ",
        math(String.raw`V_1 = \exp(G)`),
        "、また ",
        ref("def_V1_pm"),
        " より ",
        math(String.raw`V_1^{(\pm)} = \exp(G^{(\pm)})`),
        "。ここで",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W &:= Y_M Z_1 \ \in \mathrm{Mat}(2^M,\mathbb{C}) \\
G &:= i K_1\left(\sum_{m=1}^{M-1} Y_m Z_{m+1} - \varepsilon W\right) \ \in \mathrm{Mat}(2^M,\mathbb{C}) \\
G^{(\pm)} &:= i K_1\left(\sum_{m=1}^{M-1} Y_m Z_{m+1} \mp W\right) \ \in \mathrm{Mat}(2^M,\mathbb{C})
\end{aligned}`,
      ),
      paragraph([
        "である（複号同順）。以下 ",
        math(String.raw`A \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " に対し ",
        math(String.raw`\hat{A} := \mathbf{end}(A) \in \mathrm{End}(\mathcal{F})`),
        " と書く。",
        ref("end_is_algebra_isomorphism"),
        " より ",
        math(String.raw`\widehat{AB} = \hat{A}\circ\hat{B}`),
        " かつ ",
        math(String.raw`A \mapsto \hat{A}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\varepsilon`),
        " は各 ",
        math(String.raw`Z_m, Y_m`),
        "（",
        math(String.raw`m\in\{1,\dots,M\}`),
        "）と反交換する。すなわち",
      ]),
      displayMath(
        String.raw`\varepsilon Z_m = -\,Z_m\varepsilon, \qquad \varepsilon Y_m = -\,Y_m\varepsilon`,
      ),
      paragraph([
        ref("V1_V2_in_Z_Y_epsilon"),
        " の証明 Step 1 と同じクロネッカー積による表示",
      ]),
      displayMath(
        String.raw`\varepsilon = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M},\qquad
Z_m = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m},\qquad
Y_m = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^y}^{m\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m}`,
      ),
      paragraph([
        "のもとで ",
        ref("tensor_anticommutation_from_single_site"),
        " を ",
        math(String.raw`X=\varepsilon`),
        "、",
        math(String.raw`Y=Z_m`),
        " に適用する。第 ",
        math(String.raw`k`),
        " 因子の組 ",
        math(String.raw`(x_k,y_k)`),
        " は",
      ]),
      list([
        [
          math(String.raw`k<m`),
          " のとき ",
          math(String.raw`(\sigma^x,\sigma^x)`),
          "。",
          math(String.raw`\sigma^x\sigma^x = \sigma^x\sigma^x`),
          " より可換。",
        ],
        [
          math(String.raw`k=m`),
          " のとき ",
          math(String.raw`(\sigma^x,\sigma^z)`),
          "。",
          ref("pauli_matrix_products"),
          " の ",
          math(String.raw`\sigma^z\sigma^x = -\,\sigma^x\sigma^z`),
          " より反可換。",
        ],
        [
          math(String.raw`k>m`),
          " のとき ",
          math(String.raw`(\sigma^x,I)`),
          "。",
          math(String.raw`I\sigma^x = \sigma^x I`),
          " より可換。",
        ],
      ]),
      paragraph([
        "であり、反可換なサイトはちょうど 1 つ（",
        math(String.raw`k=m`),
        "）だから ",
        math(String.raw`[\varepsilon, Z_m]_+ = \varepsilon Z_m + Z_m\varepsilon = 0`),
        "、すなわち ",
        math(String.raw`\varepsilon Z_m = -Z_m\varepsilon`),
        "。",
        math(String.raw`Y_m`),
        " についても、",
        math(String.raw`k=m`),
        " の組が ",
        math(String.raw`(\sigma^x,\sigma^y)`),
        " で ",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^y\sigma^x = -\,\sigma^x\sigma^y`),
        " より反可換、他のサイトは同じく可換であるから ",
        math(String.raw`\varepsilon Y_m = -Y_m\varepsilon`),
        "。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`W`),
        "、各 ",
        math(String.raw`Y_mZ_{m+1}`),
        "、",
        math(String.raw`\varepsilon W`),
        "、および ",
        math(String.raw`G, G^{(\pm)}`),
        " と可換である。実際、",
        math(String.raw`a,b\in\{1,\dots,M\}`),
        " について Step 1 を 2 回使うと",
      ]),
      displayMath(
        String.raw`\varepsilon (Y_a Z_b)
= (\varepsilon Y_a) Z_b
= (-Y_a\varepsilon)Z_b
= -Y_a(\varepsilon Z_b)
= -Y_a(-Z_b\varepsilon)
= (Y_a Z_b)\varepsilon`,
      ),
      paragraph([
        "（積の結合律とスカラー倍の可換性を使った）。特に ",
        math(String.raw`\varepsilon W = W\varepsilon`),
        " かつ ",
        math(String.raw`\varepsilon(Y_mZ_{m+1}) = (Y_mZ_{m+1})\varepsilon`),
        "。また",
      ]),
      displayMath(
        String.raw`\varepsilon(\varepsilon W) = \varepsilon(W\varepsilon) = (\varepsilon W)\varepsilon`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`G, G^{(\pm)}`),
        " はいずれも ",
        math(String.raw`\varepsilon`),
        " と可換な元の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合であり、積の双線型性より ",
        math(String.raw`\varepsilon G = G\varepsilon`),
        "、",
        math(String.raw`\varepsilon G^{(\pm)} = G^{(\pm)}\varepsilon`),
        "。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " は ",
        math(String.raw`\hat{W}, \hat{G}, \hat{G}^{(\pm)}`),
        " で不変である。",
        math(String.raw`A \in \{W, G, G^{(\pm)}\}`),
        " は Step 2 より ",
        math(String.raw`\varepsilon A = A\varepsilon`),
        " を満たすから、",
        ref("end_is_algebra_isomorphism"),
        " (2) より ",
        math(String.raw`\hat{\varepsilon}\circ\hat{A} = \widehat{\varepsilon A} = \widehat{A\varepsilon} = \hat{A}\circ\hat{\varepsilon}`),
        "。よって ",
        math(String.raw`f\in\mathcal{F}^{(\pm)}`),
        "（すなわち ",
        math(String.raw`\hat{\varepsilon}f = \pm f`),
        "）に対し",
      ]),
      displayMath(
        String.raw`\hat{\varepsilon}\left(\hat{A}f\right)
= \hat{A}\left(\hat{\varepsilon}f\right)
= \hat{A}(\pm f)
= \pm\,\hat{A}f
\quad (\because \hat{A} \text{ の線型性})`,
      ),
      paragraph([
        "であり ",
        math(String.raw`\hat{A}f \in \mathcal{F}^{(\pm)}`),
        "。",
      ]),
      paragraph([
        "Step 4: ",
        math(String.raw`f\in\mathcal{F}^{(\pm)}`),
        " に対し ",
        math(String.raw`\hat{G}f = \hat{G}^{(\pm)}f`),
        "。まず ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`G - G^{(\pm)}
= i K_1\left(-\varepsilon W \pm W\right)
\quad (\because G, G^{(\pm)} \text{ の定義。} \textstyle\sum_{m=1}^{M-1} Y_mZ_{m+1} \text{ の項は打ち消し合う})`,
      ),
      paragraph([
        "である。",
        ref("end_is_algebra_isomorphism"),
        " の線型性と (2) より ",
        math(String.raw`\widehat{\varepsilon W} = \hat{\varepsilon}\circ\hat{W}`),
        " だから、Step 3 の ",
        math(String.raw`\hat{W}f\in\mathcal{F}^{(\pm)}`),
        " を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\hat{G} - \hat{G}^{(\pm)}\right)f
&= i K_1\left(-\hat{\varepsilon}\!\left(\hat{W}f\right) \pm \hat{W}f\right)
\quad (\because \mathbf{end} \text{ の線型性と } \widehat{\varepsilon W} = \hat{\varepsilon}\circ\hat{W}) \\
&= i K_1\left(-(\pm\hat{W}f) \pm \hat{W}f\right)
\quad (\because \hat{W}f\in\mathcal{F}^{(\pm)} \text{ より } \hat{\varepsilon}(\hat{W}f) = \pm\hat{W}f) \\
&= i K_1\cdot 0 = 0
\end{aligned}`,
      ),
      paragraph([
        "（複号同順。",
        math(String.raw`-(\pm x)\pm x = \mp x \pm x = 0`),
        "）。よって ",
        math(String.raw`\hat{G}f = \hat{G}^{(\pm)}f`),
        "。",
      ]),
      paragraph([
        "Step 5: ",
        math(String.raw`n\in\mathbb{Z}_{\geq 0}`),
        " と ",
        math(String.raw`f\in\mathcal{F}^{(\pm)}`),
        " について ",
        math(String.raw`\hat{G}^{\,n}f = \left(\hat{G}^{(\pm)}\right)^{n}f`),
        "（",
        math(String.raw`\hat{G}^{\,0} := \mathrm{id}_{\mathcal{F}}`),
        "）。",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n=0`),
        " は両辺 ",
        math(String.raw`f`),
        " で成立。",
        math(String.raw`n`),
        " で成立するとし ",
        math(String.raw`f\in\mathcal{F}^{(\pm)}`),
        " を取ると、Step 4 より ",
        math(String.raw`g := \hat{G}f = \hat{G}^{(\pm)}f`),
        " であり、Step 3 より ",
        math(String.raw`g\in\mathcal{F}^{(\pm)}`),
        " だから帰納法の仮定を ",
        math(String.raw`g`),
        " に適用でき、",
      ]),
      displayMath(
        String.raw`\hat{G}^{\,n+1}f = \hat{G}^{\,n}\!\left(\hat{G}f\right) = \hat{G}^{\,n}g
= \left(\hat{G}^{(\pm)}\right)^{n}g
= \left(\hat{G}^{(\pm)}\right)^{n}\!\left(\hat{G}^{(\pm)}f\right)
= \left(\hat{G}^{(\pm)}\right)^{n+1}f`,
      ),
      paragraph([
        "Step 6: ",
        math(String.raw`\exp`),
        " への持ち上げ。",
        ref("def_end_iso"),
        " の ",
        math(String.raw`\mathbf{end}(\exp(A)) = \exp(\mathbf{end}(A))`),
        " より",
      ]),
      displayMath(
        String.raw`\mathbf{end}(V_1) = \mathbf{end}(\exp(G)) = \exp\!\left(\hat{G}\right), \qquad
\mathbf{end}\!\left(V_1^{(\pm)}\right) = \mathbf{end}\!\left(\exp\!\left(G^{(\pm)}\right)\right) = \exp\!\left(\hat{G}^{(\pm)}\right)`,
      ),
      paragraph([
        math(String.raw`\mathcal{F}`),
        " は有限次元 ",
        math(String.raw`\mathbb{C}`),
        "-ノルム線型空間（",
        ref("def_end_iso"),
        "）であるから、",
        ref("def_exp"),
        " と ",
        ref("exp_converges"),
        " により、任意の ",
        math(String.raw`X\in\mathrm{End}(\mathcal{F})`),
        " と ",
        math(String.raw`f\in\mathcal{F}`),
        " について",
      ]),
      displayMath(
        String.raw`\left(\exp(X)\right)f = \lim_{N\to\infty} \sum_{n=0}^{N}\frac{1}{n!}X^{n}f
\qquad (\mathcal{F} \text{ のノルムに関する収束})`,
      ),
      paragraph([
        "が成り立つ（",
        ref("exp_converges"),
        " は級数の各点収束を主張し、",
        ref("def_exp"),
        " の ",
        math(String.raw`\exp(X)`),
        " はその極限として定まる線型写像である）。ここで解析的操作（",
        math(String.raw`\mathbb{C}`),
        " 上の無限級数の極限）へ移行するのはこの箇所だけであり、Step 1〜5 はすべて有限個の元の" +
          "代数的な等式である。",
      ]),
      paragraph([
        "いま ",
        math(String.raw`f\in\mathcal{F}^{(\pm)}`),
        " を任意に取る。Step 5 より、各 ",
        math(String.raw`N\in\mathbb{Z}_{\geq 0}`),
        " について部分和が",
      ]),
      displayMath(
        String.raw`S_N := \sum_{n=0}^{N}\frac{1}{n!}\hat{G}^{\,n}f
= \sum_{n=0}^{N}\frac{1}{n!}\left(\hat{G}^{(\pm)}\right)^{n}f =: S_N^{(\pm)}`,
      ),
      paragraph([
        "と一致する。上の各点収束より ",
        math(String.raw`S_N \to \left(\exp(\hat{G})\right)f`),
        " かつ ",
        math(String.raw`S_N^{(\pm)} = S_N \to \left(\exp(\hat{G}^{(\pm)})\right)f`),
        " であり、同一の点列が 2 つの極限 ",
        math(String.raw`\alpha,\beta`),
        " を持てば、ノルムの三角不等式より任意の ",
        math(String.raw`N`),
        " で ",
        math(String.raw`\|\alpha-\beta\| \leq \|\alpha - S_N\| + \|S_N - \beta\| \to 0`),
        "、すなわち ",
        math(String.raw`\|\alpha-\beta\|=0`),
        " だから ",
        math(String.raw`\alpha=\beta`),
        "。よって",
      ]),
      displayMath(
        String.raw`\left(\mathbf{end}(V_1)\right)f = \left(\exp(\hat{G})\right)f
= \left(\exp(\hat{G}^{(\pm)})\right)f = \left(\mathbf{end}\!\left(V_1^{(\pm)}\right)\right)f`,
      ),
      paragraph([
        math(String.raw`f\in\mathcal{F}^{(\pm)}`),
        " は任意だったから、",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " 上の写像として",
      ]),
      displayMath(
        String.raw`\left(\mathbf{end}(V_1)\right)\big|_{\mathcal{F}^{(\pm)}}
= \left(\mathbf{end}\!\left(V_1^{(\pm)}\right)\right)\big|_{\mathcal{F}^{(\pm)}}
= \left(\mathbf{end}\!\left(\exp\!\left(i K_1 (Y_1 Z_2 + \cdots + Y_{M-1} Z_M \mp Y_M Z_1)\right)\right)\right)\big|_{\mathcal{F}^{(\pm)}}`,
      ),
      paragraph(["が示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO」のみ。ここで証明を与えた。",
        "証明には end が単位的代数の同型であること（積の保存）が必要であり、原文のように" +
          "「線型同型を一つ取る」だけでは Step 3・Step 4 が成立しない。<def_end_iso> を書き換えた理由はそちら参照。",
        "原文の statement は式のみで、両辺が F^{(±)} 上の写像として一致するという意味であることと" +
          "M の範囲が書かれていなかったため明示した（主張の内容自体は変えていない）。",
      ],
    },
  },
  {
    id: "transfer_matrix_007_definition_V1_pm",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/006_definition_V1_plus_minusの定義.typ", ordinal: 7 },
    title: { tex: String.raw`V_1^{(\pm)} \text{ の定義}` },
    labels: ["def_V1_pm"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし（複号同順）、",
      ]),
      displayMath(
        String.raw`V_1^{(\pm)} := \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1} Z_M \mp Y_M Z_1)\right)
\in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\exp`),
        " は ",
        ref("def_end_iso"),
        " の同一視のもとでの ",
        ref("def_exp"),
        " の ",
        math(String.raw`\exp`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "参照のためラベル <def_V1_pm> を付け、M の範囲と exp の意味（<def_end_iso> の同一視による）を" +
          "明示した（定義の内容自体は変えていない）。",
      ],
    },
  },
  {
    id: "transfer_matrix_008_definition_delta_M",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ", ordinal: 8 },
    title: { tex: String.raw`\delta^M_{(\mu,\nu)} \text{ の定義}` },
    labels: ["def_delta_M"],
    statement: [
      displayMath(
        String.raw`\delta^M_{(\mu,\nu)} :=
\begin{cases}
1 & (\mu \equiv \nu \pmod{M}) \\
0 & (\mu \not\equiv \nu \pmod{M})
\end{cases}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_009_claim_exp_sum",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ", ordinal: 9 },
    title: null,
    labels: ["exp_sum"],
    statement: [
      paragraph([math(String.raw`k \in \mathbb{Z}`), " について、"]),
      displayMath(
        String.raw`\sum_{j=1}^{M} \exp\!\left(\frac{2\pi i j k}{M}\right) = M\,\delta^M_{(k,0)}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`(a)\; k \equiv 0 \pmod{M}`),
        " のとき：",
        math(String.raw`l \in \mathbb{Z}`),
        " で ",
        math(String.raw`k = lM`),
        " とおくと、",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{M} e^{lM \cdot 2\pi i j/M}
= \sum_{j=1}^{M} e^{2\pi i l j}
= \sum_{j=1}^{M} (\cos 2\pi lj + i\sin 2\pi lj)
= \sum_{j=1}^{M} 1 = M`,
      ),
      paragraph([
        math(String.raw`(b)`),
        " その他のとき：等比数列の和の公式（公比 ",
        math(String.raw`r = e^{2\pi i k/M} \neq 1`),
        "）より、",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{M} r^j
= r \cdot \frac{1 - r^M}{1 - r}
= r \cdot \frac{1 - e^{2\pi i k}}{1 - r}
= r \cdot \frac{1 - 1}{1 - r}
= 0`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_010_definition_hatZ_hatY",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/009_definition_Zhat_Yhatの定義.typ", ordinal: 10 },
    title: { tex: String.raw`\hat{Z}, \hat{Y} \text{ の定義}` },
    labels: ["def_hatZ_hatY"],
    statement: [
      paragraph([
        math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`),
        " とし、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{Z}_\mu^{(\pm)}
&:= \sum_{j=1}^{M}
  \begin{cases} \mp 1 & (j = 1) \\ 1 & (j \neq 1) \end{cases}
  Z_j \exp\!\left(-i \frac{2\pi j \mu}{M}\right) \\
&= \mp Z_1 \exp\!\left(-i\frac{2\pi\mu}{M}\right)
  + \sum_{j=2}^{M} Z_j \exp\!\left(-i\frac{2\pi j\mu}{M}\right) \\
\hat{Y}_\mu
&:= \sum_{j=1}^{M} Y_j \exp\!\left(-i\frac{2\pi j\mu}{M}\right)
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_011_definition_H1_H2",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: null,
    labels: [],
    statement: [
      displayMath(
        String.raw`\begin{aligned}
H_1^{(\pm)} &:= Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1} Z_M \mp Y_M Z_1 \\
H_2 &:= Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_M Y_M
\end{aligned}`,
      ),
      paragraph(["よって、"]),
      displayMath(
        String.raw`V_1^{(\pm)} = \exp\!\left(i K_1 H_1^{(\pm)}\right), \qquad
V_2 = (2s_2)^{M/2} \exp\!\left(i K_2^* H_2\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_012_claim_H1_H2_via_hatZ_hatY",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/011_claim_H1_H2をZhat_Yhatで表す.typ", ordinal: 12 },
    title: { tex: String.raw`H_1^{(\pm)}, H_2 \text{ を } \hat{Z}, \hat{Y} \text{ で表す}` },
    labels: ["H1_H2_via_hatZ_hatY"],
    statement: [
      displayMath(
        String.raw`\begin{aligned}
H_1^{(\pm)} &= \frac{1}{M} \sum_{j=1}^{M}
  \hat{Y}_j\, \hat{Z}_{-j}^{(\pm)}\,
  \exp\!\left(-i\frac{2\pi j}{M}\right) \\
H_2 &= \frac{1}{M} \sum_{j=1}^{M} \hat{Z}_{-j}^{(-)}\, \hat{Y}_j
\end{aligned}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`H_1^{(\pm)}`),
        " について（以下 ",
        ref("def_hatZ_hatY"),
        " の展開と ",
        ref("exp_sum"),
        " を用いる）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{右辺})
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,\exp\!\left(-i\frac{2\pi j}{M}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}
\overbrace{\left(\sum_{k_1=1}^M Y_{k_1}\exp\!\left(-i k_1\frac{2\pi j}{M}\right)\right)}^{\hat{Y}_j}\,
\overbrace{\left(\sum_{k_2=1}^M\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}Z_{k_2}\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)\right)}^{\hat{Z}_{-j}^{(\pm)}}\,
\exp\!\left(-i\frac{2\pi j}{M}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\left(Y_{k_1}\exp\!\left(-i k_1\frac{2\pi j}{M}\right)\right)
\left(\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}Z_{k_2}\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)\right)
\exp\!\left(-i\frac{2\pi j}{M}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\exp\!\left(-i k_1\frac{2\pi j}{M}\right)\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)\exp\!\left(-i\frac{2\pi j}{M}\right)
(Y_{k_1}Z_{k_2}) \quad (\text{符号を前に、}YZ\text{を後ろに移動}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\exp\!\left(-i\frac{2\pi j}{M}(k_1-k_2+1)\right)(Y_{k_1}Z_{k_2}) \quad (\text{exp をまとめる}) \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\left(\sum_{j\in\{1,\dots,M\}}\exp\!\left(-(k_1-k_2+1)\,i\frac{2\pi j}{M}\right)\right)(Y_{k_1}Z_{k_2}) \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
M\,\delta^M_{-(k_1-k_2+1),\,0}(Y_{k_1}Z_{k_2}) \quad (\because \text{exp\_sum}) \\
&= \frac{1}{M}\sum_{\substack{k_1,k_2\in\{1,\dots,M\}\\ -(k_1-k_2+1)\equiv 0 \pmod{M}}}
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
M(Y_{k_1}Z_{k_2})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k_2\geq 2`),
        " の項と ",
        math(String.raw`k_2=1`),
        " の項に分けると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&= \frac{1}{M}\sum_{\substack{k_1\in\{1,\dots,M\}\\ k_2\in\{2,\dots,M\}\\ -(k_1-k_2+1)\equiv 0 \pmod{M}}} M(Y_{k_1}Z_{k_2})
+ \frac{1}{M}\sum_{\substack{k_1\in\{1,\dots,M\}\\ -k_1\equiv 0 \pmod{M}}} \mp M(Y_{k_1}Z_1) \\
&= (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1}Z_M) + (\mp Y_M Z_1) \\
&= H_1^{(\pm)}
\end{aligned}`,
      ),
      paragraph([
        "ここで第 1 項は、",
        math(String.raw`k_1\in\{1,\dots,M\}`),
        "、",
        math(String.raw`k_2\in\{2,\dots,M\}`),
        "、",
        math(String.raw`-(k_1-k_2+1)\equiv 0 \pmod{M}`),
        " すなわち ",
        math(String.raw`k_1\equiv k_2-1 \pmod{M}`),
        " より ",
        math(String.raw`k_2-1\in\{1,\dots,M-1\}`),
        " かつ ",
        math(String.raw`k_1=k_2-1`),
        " に限る（",
        math(String.raw`\{1,\dots,M-1\}`),
        " の範囲で合同を満たす ",
        math(String.raw`k_1`),
        " は一意）。第 2 項は ",
        math(String.raw`-k_1\equiv 0 \pmod{M}`),
        " かつ ",
        math(String.raw`k_1\in\{1,\dots,M\}`),
        " より ",
        math(String.raw`k_1=M`),
        "。",
      ]),
      paragraph([math(String.raw`H_2`), " について、"]),
      displayMath(
        String.raw`\begin{aligned}
(\text{右辺})
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\,\hat{Y}_j \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}
\overbrace{\left(\sum_{k_1=1}^M\begin{cases}1 & (k_1\neq 1)\\ +1 & (k_1=1)\end{cases}Z_{k_1}\exp\!\left(-i k_1\frac{2\pi(-j)}{M}\right)\right)}^{\hat{Z}_{-j}^{(-)}}\,
\overbrace{\left(\sum_{k_2=1}^M Y_{k_2}\exp\!\left(-i k_2\frac{2\pi j}{M}\right)\right)}^{\hat{Y}_j} \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\left(Z_{k_1}\exp\!\left(-i k_1\frac{2\pi(-j)}{M}\right)\right)\left(Y_{k_2}\exp\!\left(-i k_2\frac{2\pi j}{M}\right)\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\exp\!\left(-i k_1\frac{2\pi(-j)}{M}-i k_2\frac{2\pi j}{M}\right)Z_{k_1}Y_{k_2} \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\left(\sum_{j\in\{1,\dots,M\}}\exp\!\left((k_1-k_2)\,i\frac{2\pi j}{M}\right)\right)Z_{k_1}Y_{k_2} \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M M\,\delta^M_{(k_1-k_2,\,0)}Z_{k_1}Y_{k_2} \quad (\because \text{exp\_sum}) \\
&= \sum_{k_1,k_2=1}^M \delta^M_{(k_1-k_2,\,0)}Z_{k_1}Y_{k_2} \\
&= \sum_{\substack{k_1,k_2\in\{1,\dots,M\}\\ k_1-k_2\equiv 0 \pmod{M}}} Z_{k_1}Y_{k_2}
= \sum_{\substack{k_1\in\{1,\dots,M\}\\ k_1=k_2}} Z_{k_1}Y_{k_2} \\
&= Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_M Y_M \\
&= H_2
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_013_claim_hatZ_hatY_M_periodicity",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/012_claim_hatZ_hatYのM周期性.typ", ordinal: 13 },
    title: { tex: String.raw`\hat{Z}_M^{(-)} = \hat{Z}_{-M}^{(-)},\; \hat{Y}_M = \hat{Y}_{-M}` },
    labels: ["hatZ_hatY_M_periodicity"],
    statement: [
      displayMath(
        String.raw`\hat{Z}_M^{(-)} = \hat{Z}_{-M}^{(-)}, \qquad \hat{Y}_M = \hat{Y}_{-M}`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_hatZ_hatY"),
        " より、各 ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " について、",
      ]),
      displayMath(
        String.raw`\exp\!\left(-i j \frac{2\pi M}{M}\right)
= e^{-2\pi i j}
= 1
= e^{0}
= \exp\!\left(-i j \frac{2\pi(-M)}{M}\right)`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\hat{Z}_M`),
        " と ",
        math(String.raw`\hat{Z}_{-M}`),
        " の各 ",
        math(String.raw`j`),
        " 項の係数が一致する。",
        math(String.raw`\hat{Y}`),
        " も同様。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_014_claim_recover_Z_Y_from_hatZ_hatY",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/013_claim_hatZ_hatYからZ_Yの復元.typ", ordinal: 14 },
    title: { tex: String.raw`\hat{Z}, \hat{Y} \text{ から } Z, Y \text{ の復元}` },
    labels: ["recover_Z_Y_from_hatZ_hatY"],
    statement: [
      paragraph([
        ref("def_hatZ_hatY"),
        " の記号のもと、",
        math(String.raw`\hat{Z}^{(-)}`),
        " は全 ",
        math(String.raw`j`),
        " について重み ",
        math(String.raw`+1`),
        "（uniform）であり、すなわち ",
        math(String.raw`\hat{Z}_\mu^{(-)} = \sum_{j=1}^M Z_j \exp\!\left(-i j\frac{2\pi\mu}{M}\right)`),
        " である。各 ",
        math(String.raw`m \in \{1,\dots,M\}`),
        " について、次が成り立つ。",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right) = M Y_m`,
      ),
      displayMath(
        String.raw`\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right) = M Z_m`,
      ),
      paragraph(["ゆえに、"]),
      displayMath(
        String.raw`Y_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right)`,
      ),
      displayMath(
        String.raw`Z_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right)`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`m \in \{1,\dots,M\}`),
        " を任意に固定する。補題（",
        math(String.raw`\mu`),
        " についての指数和の直交性）: ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " を固定し ",
        math(String.raw`k := m-j \in \mathbb{Z}`),
        " とおく。",
        ref("exp_sum"),
        " の主張において和の変数を ",
        math(String.raw`j \leftrightarrow \mu`),
        "、定数を ",
        math(String.raw`k = m-j`),
        " と読み替えることで、",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right) = M\,\delta^M_{(m-j,\,0)} \quad (\because \text{exp\_sum})`,
      ),
      paragraph([
        "が成り立つ。さらに ",
        math(String.raw`m, j \in \{1,\dots,M\}`),
        " より ",
        math(String.raw`-(M-1)\leq m-j\leq M-1`),
        "、すなわち ",
        math(String.raw`|m-j|<M`),
        " であるから、",
        math(String.raw`m-j\equiv 0 \pmod{M}`),
        " と ",
        math(String.raw`m=j`),
        " は同値である。したがって、",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right)
= \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases} \quad (\because \text{exp\_sum})`,
      ),
      paragraph(["が成り立つ（以下この等式を ", math(String.raw`(\ast)`), " と呼ぶ）。"]),
      paragraph(["Step 1: ", math(String.raw`\hat{Y}`), " からの復元。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right)
&= \sum_{\mu=1}^M \left(\sum_{j=1}^M Y_j \exp\!\left(-i j\frac{2\pi\mu}{M}\right)\right)\exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \hat{Y}_\mu,\hat{Z}_\mu^{(-)} \text{ の定義}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M Y_j \exp\!\left(i(m-j)\frac{2\pi\mu}{M}\right) \quad (\because \text{指数法則}) \\
&= \sum_{j=1}^M Y_j \sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right) \quad (\because \text{有限二重和の順序交換}) \\
&= \sum_{j=1}^M Y_j \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases} \quad (\because (\ast)) \\
&= M Y_m
\end{aligned}`,
      ),
      paragraph(["Step 2: ", math(String.raw`\hat{Z}^{(-)}`), " からの復元。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right)
&= \sum_{\mu=1}^M \left(\sum_{j=1}^M Z_j \exp\!\left(-i j\frac{2\pi\mu}{M}\right)\right)\exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \hat{Y}_\mu,\hat{Z}_\mu^{(-)} \text{ の定義}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M Z_j \exp\!\left(i(m-j)\frac{2\pi\mu}{M}\right) \quad (\because \text{指数法則}) \\
&= \sum_{j=1}^M Z_j \sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right) \quad (\because \text{有限二重和の順序交換}) \\
&= \sum_{j=1}^M Z_j \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases} \quad (\because (\ast)) \\
&= M Z_m
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 復元式。Step 1・Step 2 で得た等式の両辺を ",
        math(String.raw`M`),
        " で割って、",
      ]),
      displayMath(
        String.raw`Y_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right), \qquad
Z_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_015_claim_Z_Y_generate_algebra",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ", ordinal: 15 },
    title: {
      text: "Z, Y から和・スカラー倍・積だけで 2^M 次の複素行列がすべて得られる",
    },
    labels: ["Z_Y_generate_algebra"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        "（004 章冒頭の記号の定義）で定義された ",
        math(String.raw`Z_1,\dots,Z_M, Y_1,\dots,Y_M \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について、集合 ",
        math(String.raw`S := \{Z_1,\dots,Z_M, Y_1,\dots,Y_M\}`),
        " を考える（",
        ref("def_kronecker"),
        " の同一視により ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C}) = \mathrm{Mat}(2^M,\mathbb{C})`),
        " であり、",
        math(String.raw`S`),
        " の元はいずれも ",
        math(String.raw`2^M`),
        " 次の複素行列である）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の部分集合 ",
        math(String.raw`T`),
        " が「閉じている」とは、次の 4 条件を満たすことをいう。",
      ]),
      list([
        [
          "(i) ",
          math(String.raw`S \subseteq T`),
          "、すなわち ",
          math(String.raw`Z_1,\dots,Z_M,Y_1,\dots,Y_M \in T`),
          "。",
        ],
        [
          "(ii) ",
          math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})} \in T`),
          "（単位行列を含む）。",
        ],
        [
          "(iii) ",
          math(String.raw`A, B \in T`),
          " ならば ",
          math(String.raw`A + B \in T`),
          "、および ",
          math(String.raw`c \in \mathbb{C}`),
          " について ",
          math(String.raw`cA \in T`),
          "（和とスカラー倍で閉じる）。",
        ],
        [
          "(iv) ",
          math(String.raw`A, B \in T`),
          " ならば ",
          math(String.raw`AB \in T`),
          "（行列の積で閉じる）。",
        ],
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " 自身は閉じているからそのような ",
        math(String.raw`T`),
        " は少なくとも 1 つ存在し、閉じている部分集合すべての共通部分もまた (i)〜(iv) を満たす",
        "（共通部分の元は各 ",
        math(String.raw`T`),
        " に属するので、和・スカラー倍・積も各 ",
        math(String.raw`T`),
        " に属し、したがって共通部分に属する）。よって、閉じている部分集合のうち最小のものが存在する。それを ",
        math(String.raw`\mathcal{A}`),
        " とおく。",
      ]),
      paragraph([
        "このとき ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^M,\mathbb{C})`),
        " である。すなわち、",
        math(String.raw`Z_1,\dots,Z_M,Y_1,\dots,Y_M`),
        " と単位行列から出発して、和・スカラー倍・行列の積を有限回繰り返すだけで ",
        math(String.raw`2^M`),
        " 次の複素行列がすべて得られる。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\sigma^x, \sigma^y, \sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " を標準的な Pauli 行列 ",
        math(String.raw`\sigma^x=\begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^y=\begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^z=\begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " とする。",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " のとおり、第 ",
        math(String.raw`k`),
        " 番目の因子（サイト）のみが対応する Pauli 行列で、他の因子はすべて ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " であるものとする。",
      ]),
      paragraph(["Step 1: 単一サイトの Pauli 行列の積公式。成分計算により、"]),
      displayMath(
        String.raw`\sigma^x\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix} = \begin{pmatrix}1&0\\0&1\end{pmatrix} = I_{\mathrm{Mat}(2,\mathbb{C})} \quad (\because \text{行列の積の成分計算})`,
      ),
      displayMath(
        String.raw`\sigma^y\sigma^z = \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix} = \begin{pmatrix}0&i\\i&0\end{pmatrix} = i\begin{pmatrix}0&1\\1&0\end{pmatrix} = i\,\sigma^x \quad (\because \text{行列の積の成分計算})`,
      ),
      paragraph([
        "第 2 式の両辺に ",
        math(String.raw`-i`),
        " を掛けると ",
        math(String.raw`\sigma^x = -i\,\sigma^y\sigma^z`),
        "（",
        math(String.raw`i^{-1}=-i`),
        "）。これらをクロネッカー積へ持ち上げる。",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の積は各因子ごとの積であり ",
        math(String.raw`(A_1\boxtimes\cdots\boxtimes A_M)(B_1\boxtimes\cdots\boxtimes B_M) = (A_1 B_1)\boxtimes\cdots\boxtimes(A_M B_M)`),
        "（",
        ref("kronecker_product_rule"),
        " (1)）。第 ",
        math(String.raw`k`),
        " 因子のみが非自明な ",
        math(String.raw`\sigma_k^a`),
        " どうしの積は（",
        math(String.raw`I:=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_k^b
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{k\text{th}}\boxtimes\cdots\boxtimes I) \\
&= (II)\boxtimes\cdots\boxtimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\boxtimes\cdots\boxtimes(II) \quad (\because \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\boxtimes\cdots\boxtimes I \quad (\because II=I)
\end{aligned}`,
      ),
      paragraph([
        "これより ",
        math(String.raw`\sigma_k^x\sigma_k^x = I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "、",
        math(String.raw`\sigma_k^x = -i\,\sigma_k^y\sigma_k^z`),
        " を得る。また異なるサイト ",
        math(String.raw`k\neq l`),
        " の ",
        math(String.raw`\sigma_k^a, \sigma_l^b`),
        " は可換である（",
        math(String.raw`k<l`),
        " として）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_l^b
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I) \\
&= I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I \quad (\because \text{クロネッカー積の積の規則}) \\
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \text{クロネッカー積の積の規則}) \\
&= \sigma_l^b \sigma_k^a
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`\mathcal{A}`),
        " が各 ",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " を含むこと。各 ",
        math(String.raw`m`),
        " について「",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x \in \mathcal{A}`),
        "」を仮定とする ",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のとき ",
        math(String.raw`\sigma_1^z=Z_1\in\mathcal{A}`),
        "、",
        math(String.raw`\sigma_1^y=Y_1\in\mathcal{A}`),
        "、Step 1 より ",
        math(String.raw`\sigma_1^x = -i\,\sigma_1^y\sigma_1^z = -i\,Y_1 Z_1 \in \mathcal{A}`),
        "。",
      ]),
      paragraph([
        math(String.raw`m\geq 2`),
        " とし ",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x\in\mathcal{A}`),
        " を仮定する。",
        math(String.raw`P_{m-1}:=\sigma_1^x\sigma_2^x\cdots\sigma_{m-1}^x`),
        " とおくと ",
        math(String.raw`P_{m-1}\in\mathcal{A}`),
        "（",
        math(String.raw`m=1`),
        " では空積 ",
        math(String.raw`P_0:=I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "）。異サイトの可換性と ",
        math(String.raw`\sigma_k^x\sigma_k^x=I`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}P_{m-1}
&= (\sigma_1^x\cdots\sigma_{m-1}^x)(\sigma_1^x\cdots\sigma_{m-1}^x) \\
&= (\sigma_1^x\sigma_1^x)(\sigma_2^x\sigma_2^x)\cdots(\sigma_{m-1}^x\sigma_{m-1}^x) \quad (\because \text{異サイトの可換性}) \\
&= I_{\mathrm{Mat}(2^M,\mathbb{C})} \quad (\because \sigma_k^x\sigma_k^x=I_{\mathrm{Mat}(2^M,\mathbb{C})})
\end{aligned}`,
      ),
      paragraph([
        "ゆえに ",
        math(String.raw`P_{m-1}`),
        " は可逆で ",
        math(String.raw`P_{m-1}^{-1}=P_{m-1}\in\mathcal{A}`),
        "。定義より ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z = P_{m-1}\sigma_m^z`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}Z_m
&= P_{m-1}P_{m-1}\sigma_m^z \quad (\because Z_m = P_{m-1}\sigma_m^z) \\
&= I_{\mathrm{Mat}(2^M,\mathbb{C})}\sigma_m^z \quad (\because P_{m-1}P_{m-1}=I_{\mathrm{Mat}(2^M,\mathbb{C})}) \\
&= \sigma_m^z
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`P_{m-1}, Z_m\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`\sigma_m^z = P_{m-1}Z_m\in\mathcal{A}`),
        "。同様に ",
        math(String.raw`Y_m = P_{m-1}\sigma_m^y`),
        " より ",
        math(String.raw`\sigma_m^y = P_{m-1}Y_m\in\mathcal{A}`),
        "、さらに Step 1 より ",
        math(String.raw`\sigma_m^x = -i\,\sigma_m^y\sigma_m^z\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\sigma_m^x,\sigma_m^y,\sigma_m^z\in\mathcal{A}`),
        " が示され、帰納法により すべての ",
        math(String.raw`k\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`\sigma_k^x,\sigma_k^y,\sigma_k^z\in\mathcal{A}`),
        "。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^M,\mathbb{C})`),
        "。まず ",
        math(String.raw`\mathcal{B}:=\{I_{\mathrm{Mat}(2,\mathbb{C})}, \sigma^x, \sigma^y, \sigma^z\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 上の基底である。実際、任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}`),
        " に対し",
      ]),
      displayMath(
        String.raw`A = \frac{a_{11}+a_{22}}{2}I_{\mathrm{Mat}(2,\mathbb{C})} + \frac{a_{12}+a_{21}}{2}\sigma^x + \frac{i(a_{12}-a_{21})}{2}\sigma^y + \frac{a_{11}-a_{22}}{2}\sigma^z \quad (\because \text{成分比較})`,
      ),
      paragraph([
        " が成り立つので ",
        math(String.raw`\mathcal{B}`),
        " は張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{B}`),
        " より基底である。次に ",
        math(String.raw`\mathcal{B}^{\boxtimes M}:=\{e_1\boxtimes\cdots\boxtimes e_M: e_1,\dots,e_M\in\mathcal{B}\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の基底である（",
        ref("tensor_basis"),
        " (2) を基底 ",
        math(String.raw`\mathcal{B}`),
        " に適用した）。一方、各 ",
        math(String.raw`e_1\boxtimes\cdots\boxtimes e_M`),
        " について、各 ",
        math(String.raw`k`),
        " で ",
        math(String.raw`\sigma_k^{a_k}:=I\boxtimes\cdots\boxtimes\overbrace{e_k}^{k\text{th}}\boxtimes\cdots\boxtimes I`),
        " とおくと、Step 1 の異サイト積公式を繰り返して",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_M^{a_M} = e_1\boxtimes e_2\boxtimes\cdots\boxtimes e_M \quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "Step 2 より各 ",
        math(String.raw`\sigma_k^{a_k}\in\mathcal{A}`),
        "（",
        math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})}\in\mathcal{A}`),
        " も含む）であり、",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`e_1\boxtimes\cdots\boxtimes e_M = \sigma_1^{a_1}\cdots\sigma_M^{a_M}\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\mathcal{B}^{\boxtimes M}\subseteq\mathcal{A}`),
        "。",
        math(String.raw`\mathcal{A}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型結合について閉じ、",
        math(String.raw`\mathcal{B}^{\boxtimes M}`),
        " は基底であるから",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2^M,\mathbb{C}) = \mathrm{span}_{\mathbb{C}}(\mathcal{B}^{\boxtimes M}) \subseteq \mathcal{A} \quad (\because \mathcal{A} \text{ は } \mathbb{C}\text{-線型結合について閉じる})`,
      ),
      paragraph([
        "一方 ",
        math(String.raw`\mathcal{A}\subseteq\mathrm{Mat}(2^M,\mathbb{C})`),
        " は定義より明らかであるから ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^M,\mathbb{C})`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "タイトルと statement にあった多元環の一般論の語彙（「環として生成する」「C 上の単位的結合多元環」" +
          "「S を含む最小の C-部分多元環」）を、「和・スカラー倍・積で閉じた最小の集合」という具体的な" +
          "言い換えへ直した（goal-alignment-audit の A-6。README 2 節「環・体などの一般論に持ち上げた証明」" +
          "を避けるため）。主張の内容と証明は変えていない。あわせて、最小の集合が存在すること" +
          "（閉じている部分集合の共通部分もまた閉じている）を明示した。",
      ],
    },
  },
]);
