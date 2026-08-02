# 経路: 量子 CA の指数理論と作用素代数

**一言**: この経路には、本プロジェクトが探している対応の**最も完成度の高い実例**がある。
すなわち **「CA 規則 → $\Lambda$ に値をとる完全不変量」**（GNVW 指数）である。

## 設定

量子 CA（QCA）とは、準局所代数 $\mathcal{A}=\bigotimes_{x\in\mathbb{Z}^D}M_d(\mathbb{C})$ の
**局所性を保つ $*$-自己同型** $\alpha$ のこと（$\alpha$ は台を有限距離しか広げない）。

- 古典 CA（可逆）は、対角部分代数に制限した QCA として埋め込まれる。
- 有限深さ量子回路（finite-depth circuit）は QCA だが、逆は成り立たない。
  最も簡単な非自明例は**シフト**。

## GNVW 指数（1 次元・完全分類）

Gross–Nesme–Vogts–Werner, "Index theory of one dimensional quantum walks and cellular automata",
*Comm. Math. Phys.* **310** (2012) 419。

各 1 次元 QCA $\alpha$ に**正の有理数** $\operatorname{ind}(\alpha)\in\mathbb{Q}_{>0}$ を割り当てる：

$$
\operatorname{ind}(\alpha)=\frac{\eta(\alpha^{-1}(\mathcal{A}_A),\mathcal{A}_B)}{\eta(\mathcal{A}_A,\alpha^{-1}(\mathcal{A}_B))}
$$

（$\mathcal{A}_A,\mathcal{A}_B$ は隣接区間上の作用素代数、$\eta$ は代数の「重なり」の次元）。

**性質**:

- 合成・テンソル積に関して**乗法的**: $\operatorname{ind}(\alpha\beta)=\operatorname{ind}(\alpha)\operatorname{ind}(\beta)$。
- $\operatorname{ind}(\alpha)=1\iff\alpha$ は有限深さ回路。
- 2 つの QCA が同じ指数を持つ $\iff$ 安定同値。**1 次元では指数が完全不変量。**
- 直観的な意味：**量子情報が右向きに正味どれだけ「汲み上げられる」か**。
  シフトなら $\operatorname{ind}=d$（局所次元）。

### これが $\Lambda$ そのものであること（本プロジェクトの着眼）

$$
\big(\mathbb{Q}_{>0},\times\big)\ \xrightarrow[\ \cong\ ]{\ \log\ }\ \big(\Lambda,+\big),\qquad
\log:\ q\mapsto\sum_p v_p(q)\,\ell_p .
$$

これは `docs/discussion/対数順序群上の統計力学/00_記号と定義.md` の $\Lambda$ の定義そのものである。したがって

> **QCA の GNVW 指数の対数は $\Lambda$ の元であり、合成に関して加法的である。**
> すなわち $\log\operatorname{ind}:\{\text{1D QCA}\}\to\Lambda$ は群準同型。

この量は**完全に決定可能**（有限次元の代数の次元の比＝有理数）で、
$\mathbb{R}$ 脱出をまったく含まない。「情報の流れ」という物理的に意味のある量が
$\Lambda$ 値の完全不変量になっている——これは
`docs/discussion/可算性の効用/00_可算で完結することの工学的効用.md` の中心テーゼの、物理側からの独立な支持例である（→ 種「Λ値不変量の三つの顔」）。

**文献での扱い**: 指数が有理数であることは強調されるが、
「$\mathbb{Q}_{>0}\cong\Lambda$ で素因数分解の構造を持つ」という見方は見当たらない。
局所次元 $d$ の素因数だけが指数に現れる（$\operatorname{ind}\in\langle p: p\mid d\rangle$）ので、
**$\Lambda$ の台が有限で、模型の局所次元で決まる**。この構造は使われていない。

## 高次元と Clifford QCA

Haah, "Clifford quantum cellular automata: Trivial group in 2D and Witt group in 3D",
*J. Math. Phys.* **62** (2021) 092202 (arXiv:1907.02075)。

$D$ 次元格子、各セルが素数 $p$ 次元 qudit、Pauli 行列を Pauli 行列のテンソル積に写す
（Clifford）並進不変 QCA を扱う。

- **代数的翻訳**: そのような QCA は、**Laurent 多項式環上の単位行列式をもつ反エルミート形式**
  に対応する。形式が QCA を（Clifford 回路とシフトを除いて）決定する。
- **$D=2$**: 形式は常に自明 ⇒ 2 次元の並進不変 Clifford QCA はすべて自明。
- **$D=3$**: 任意の奇素数 $p$ で非自明例が存在し、**$\mathbb{F}_p$ の Witt 群**が
  「全並進不変 Clifford QCA / 自明なもの」の部分群になる。
- 任意の $D$ で、並進不変 Clifford QCA の **4 乗は自明**。
- 非自明例は、可換 Pauli Hamiltonian の基底状態をほどくことで得られ、
  露出した表面は 2 次元の可換 Pauli Hamiltonian では実現できない**異常な位相秩序**を持つ。

**帰属**: Laurent 多項式環 $\mathbb{F}_p[x_1^{\pm},\dots,x_D^{\pm}]$ 上の代数——
**完全に可算・有限体上の代数**であり、$\mathbb{R}$ は一切現れない。
Witt 群は有限群（$p$ に依存）。

### 中心電荷との接続（ここで $\mathbb{R}$ が現れる）

Shirley–Chen–Dua–Ellison–Tantivasadakarn–Williamson,
"Three-dimensional quantum cellular automata from chiral semion surface topological order and beyond",
*PRX Quantum* **3** (2022) 030326 (arXiv:2202.05442)。

- QCA の**指数は情報流のカイラリティを測る位相不変量**であり、
  **エンタングルメント・エントロピーの下界が指数の 2 倍**で与えられる（全 Rényi エントロピーで成立）。
- 余次元 2 の欠陥は**カイラル中心電荷 $4\bmod8$** を担う。
- 非零のカイラル中心電荷（mod 8）を持つ $2{+}1$ 次元境界の位相秩序は、
  可換射影子（commuting projector）では実現できない。

**この経路の可算性の観点での要点**:

$$
\underbrace{\operatorname{ind}\in\mathbb{Q}_{>0}\cong\Lambda}_{\text{1D, 決定可能}}
\ \longrightarrow\
\underbrace{c_-\bmod8\in\text{有限群}}_{\text{2D 境界}}
\ \longrightarrow\
\underbrace{c_-\in\mathbb{R}}_{\text{CFT}}
$$

**$\Lambda$ → 有限群 → $\mathbb{R}$ という梯子が、そのまま物理的階層になっている。**
どこで $\mathbb{R}$ が本当に必要になるかを、この系列は明示的に示している（→ 種「Λ値不変量の三つの顔」）。

## 融合圏スピン鎖上の指数（$\Lambda\to\overline{\mathbb{Q}}$ の拡大）

Jones–Naaijkens–Penneys–Wallick ほか, "An index for quantum cellular automata on fusion spin chains",
*Ann. Henri Poincaré* (2024), arXiv:2309.10961。

- テンソル積 Hilbert 空間の代わりに**融合圏スピン鎖**上で QCA を定義すると、
  指数の値は**量子次元が生成する群**に値をとる。
- 例: Kramers–Wannier 双対に対応する作用素の指数は $\sqrt2$（Ising 圏の量子次元）。
  arXiv:2607.21728 "Quantum cellular automata from Kramers–Wannier dualities and modular relations"、
  arXiv:2605.15194 "Non-invertible symmetries on tensor-product Hilbert spaces and quantum cellular automata"。

**帰属**: $\sqrt2\notin\mathbb{Q}$ だが $\sqrt2\in\overline{\mathbb{Q}}$。
つまり指数群が $\mathbb{Q}_{>0}\cong\Lambda$ から $\overline{\mathbb{Q}}_{>0}$ へ拡大する。
**これは `docs/discussion/可算性の効用/00_可算で完結することの工学的効用.md` の決定可能性の梯子 $\Lambda\prec\overline{\mathbb{Q}}$ の物理的実現である**：

| QCA の舞台 | 指数群 | 帰属 |
|---|---|---|
| テンソル積 Hilbert 空間（可逆対称性） | $\mathbb{Q}_{>0}$ | **$\Lambda$** |
| 融合圏スピン鎖（非可逆対称性） | 量子次元の生成群 | $\overline{\mathbb{Q}}$ |
| 連続極限（CFT） | 中心電荷 | $\mathbb{R}$（有理 CFT なら $\mathbb{Q}$） |

**どの段階でも決して非可算にならない**（最下段の CFT を除く）ことに注意。
「非可逆対称性を入れると $\Lambda$ から $\overline{\mathbb{Q}}$ へ上がる」という
明確な階段が見えている（→ 種「Λ値不変量の三つの顔」）。

## 可逆 CA と Cuntz 代数

古典可逆 CA 全体は両側 full shift の自己同型群 $\operatorname{Aut}(\sigma_n)$（$n=$ 状態数）をなす。
作用素代数側では：

- Cuntz 代数 $\mathcal{O}_n$ の**制限 Weyl 群**の $\operatorname{Out}(\mathcal{O}_n)$ における像が、
  $n$ が素数のとき $\operatorname{Aut}(\sigma_n)$ と同一視される（Conti–Hong–Szymański、
  Cuntz が 1980 年に提起した問いへの回答）。
- **置換的（permutative）自己同型**は $[n]^k$ の安定置換と全単射に対応する。
  すなわち**有限の組合せデータ**。

**帰属**: 完全に組合せ的・可算。$\mathcal{O}_n$ は $C^*$ 代数（非可算）だが、
自己同型の分類に使われるのは有限の置換データである（見かけだけの $\mathbb{R}$ 脱出に近い：見かけの非可算性）。

## その他の関連（QCA の周辺）

- Freedman–Hastings, "Classification of quantum cellular automata", *CMP* (2020) — 高次元の枠組み。
- Farrelly, "A review of quantum cellular automata", *Quantum* **4** (2020) 368 — 総説。
- Ma–Li–Cheng, "Quantum cellular automata on symmetric subalgebras", *Quantum* (2026) —
  有限アーベル群対称性の下での対称部分代数上の QCA。
- Clifford QCA と TQFT・可逆部分代数（*PRX Quantum*, 2025）— 全空間次元での実現と
  **代数的 $L$ 理論に整合する次元周期性**。

## この経路の空白

1. **GNVW 指数を $\Lambda$ 値の量として扱った研究がない。** 素因数分解の構造
   （どの素数が台に乗るか、$v_p(\operatorname{ind})$ が何を意味するか）は未探索（→ 種「Λ値不変量の三つの顔」）。
2. **古典可逆 CA に限ったときの指数の意味が整理されていない。**
   置換行列に対する指数は何か。決定論的 CA の「情報流」と加法的保存量の関係は。
3. **Clifford QCA の Laurent 多項式（$\mathbb{F}_p$ 上）と、「代数力学」の経路の線形 CA の Laurent 多項式は
   同じ環である。** 両者を繋いだ議論は見当たらない（→ 種「線形CAとMahler測度」と 種「Λ値不変量の三つの顔」の接続）。
