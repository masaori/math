# 06. 文献調査：$Z_E$ → Massieu → 2 次元 Ising 厳密解（臨界指数）

**問い**：$Z_E$ から Massieu 自由エントロピー（[04](04_ZEと自由エネルギー.md)）を介して 2 次元 Ising の厳密解（臨界指数）を導く先行研究はあるか。

**要点（結論先出し）**：$E$（指数体）枠そのものを使った論文は無い（枠付けが本プロジェクト固有）。だが [05](05_相転移はΦで論じられるか.md) (a) の「Massieu $=\log Z$ ＋代数的零点 → 臨界指数」と**数学的に同一の研究プログラム**が確立している ── **Lee–Yang / Fisher 零点による臨界指数決定**。整数係数分配関数 $=Z_E$、零点 $=$ 代数的 $=E$ 内、指数抽出 $=N\to\infty$ スケーリング $=\mathbb{R}$、という対応が綺麗につく。$E$ 上で可算的に再定式化する点だけが未踏。

## 1. なぜ Lee–Yang / Fisher が一致なのか

[05](05_相転移はΦで論じられるか.md) (a) の主張：有限格子で $Z_N(x)=\sum_n\Omega_N(n)\,x^n\in\mathbb{N}[x]$（整数係数）→ 零点は代数的 $\in\overline{\mathbb{Q}}\subset E$ → 転移は零点の正実軸への詰め寄り。文献での対応：

- 有限 Ising 分配関数は低温変数 $x=e^{-2\beta J}$（または $\tanh\beta J$）で**整数係数多項式**（Kaufman 多項式・再帰関係）。係数は各エネルギーの配置数 $\Omega_N\in\mathbb{N}$＝まさに $Z_E$。
- その零点（Fisher 零点＝複素温度、Lee–Yang 零点＝複素磁場）から**有限サイズスケーリングで臨界指数 $\nu,\sigma$ 等を抽出**。

つまり (a) は Lee–Yang/Fisher プログラムを「零点の代数性」と「$E$ 内の量化言明」として読み直したものに相当。

## 2. 主要文献

**基礎（零点と相転移）**
- Lee–Yang (1952) 原論文、Fisher 零点（複素温度、Fisher 1965）。
- Density of the Fisher zeroes for the Ising model — arXiv:cond-mat/0001409（零点密度が軌跡上で対数発散）。
- Some New Results on Yang–Lee Zeros of the Ising Model Partition Function — arXiv:cond-mat/9512149。

**零点から臨界指数（本命の一致）**
- Determination of universal critical exponents using Lee–Yang theory — arXiv:1905.02379（Phys. Rev. Research 1, 023004, 2019）。Lee–Yang 零点の有限サイズスケーリングから普遍臨界指数を抽出。相転移を跨がずに指数が出る。
- Exploring Lee–Yang and Fisher zeros in the 2D Ising model through multipoint Padé approximants — arXiv:2312.03178（Phys. Rev. D 109, 074505）。

**整数係数・組合せ的 $Z$（＝$Z_E$ そのもの）**
- Onsager's solution: the combinatorial method（Kac–Ward / dimer 経由、数え上げ）。
- Recursion relations for the partition function of the 2D Ising model — arXiv:cond-mat/0605568（Kaufman 解を整数係数多項式へ、$2^m\times2^n$ 再帰）。
- An exact solution to the partition function of the finite-size Ising Model — arXiv:1805.01366／Rigorous Calculation of the Partition Function for Finite Number — arXiv:1110.2561。

**Massieu / 自由エントロピー（定義側）**
- Free entropy / Massieu function（Wikipedia）：自由エントロピー $=\log Z$、$\Phi=-\beta F$。命名は確立しているが Ising 臨界指数導出に直結させた文献は薄い。

## 3. 我々の枠組みとのギャップ（新規性の余地）

1. **臨界指数は依然 $N\to\infty$ のスケーリング極限から出る**＝$\mathbb{R}$。文献はすべて $\mathbb{C}$ 上の解析性・極限を自由に使う。[05](05_相転移はΦで論じられるか.md) §2「指数は還元不能に $\mathbb{R}/\mathbb{C}$」と整合。
2. **「零点が代数的 $\in E$」「感受率の非有界性 $\sup_N\chi_N=\infty$ を $\forall M\in\mathbb{Q}\,\exists N$ で書く」という $E$ 内・可算な再定式化を明示的にやった文献は見当たらない**。Lee–Yang/Fisher は数値的・解析的に $\mathbb{C}$ で扱う。→ 本プロジェクト固有の貢献ポイントになりうる。
3. 構成的／計算可能／可述的（reverse math 的）な統計力学で Ising 指数を扱う系統は今回ヒットせず。空白。

## 4. 一言

**「$Z_E$→Massieu→Ising 臨界指数」の実体は Lee–Yang/Fisher 零点プログラム（特に arXiv:1905.02379）。整数係数分配関数＝$Z_E$、零点＝代数的＝$E$ 内、指数抽出＝$N\to\infty$ スケーリング＝$\mathbb{R}$、という対応がつく。$E$ 上で可算的に再定式化する点だけが未踏で、そこが本プロジェクトの差分。**
