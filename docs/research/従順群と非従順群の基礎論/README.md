# 従順群と非従順群の基礎論（厳密版教科書）

従順性（amenability）の基礎論を、**登場するすべての記号・演算子について所属集合を明示し、暗黙の同一視・記号の濫用を一切行わない**方針で書く。記述が冗長になっても、各トークンの住処を常に添字等で表示する。RΛ 双対プロジェクト（[`../R-Lambda-duality/`](../R-Lambda-duality/README.md)）で従順群／非従順群の別が本質的に効く（従順群でエントロピー＝FK 行列式が清潔、非従順で sofic entropy へ、[`../数え上げエントロピーと特殊値/06`](../数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md)）ため、その土台を厳密に固める。

---

## 0. この教科書の厳密性方針（第0章の要約）

- **すべての元は所属を明示**：$x\in X$ の形で書き、$x$ 単独で放置しない。
- **すべての写像は始域・終域を明示**：$f\colon A\to B$。適用 $f(a)\in B$（$a\in A$）。
- **演算子は構造を添字に**：群演算 $\cdot_G\colon G\times G\to G$、実数の加法 $+_{\mathbb R}$、順序 $\le_{\mathbb R}$、実数の絶対値 $|\cdot|_{\mathbb R}$。単位元 $e_G\in G$、実数の零元 $0_{\mathbb R}\in\mathbb R$、恒等関数 $\mathbf 1_G\in\ell^\infty(G,\mathbb R)$ 等を**互いに区別**する。
- **暗黙の同一視を禁止**：例えば有限集合の濃度 $|F|\in\mathbb Z_{\ge0}$（整数）と、それを実数とみた $\iota_{\mathbb Z\hookrightarrow\mathbb R}(|F|)\in\mathbb R$ を、比を取る箇所では明示的に区別する（§04）。埋め込み写像には名前を付ける。
- **可算・非可算の別を追跡**（CLAUDE.md 厳密性原則）：$\mathbb R$ への脱出（上限・下限・極限・積分）を使う箇所を明示する。

詳細な規約は [`00_記法と集合論的規約.md`](00_記法と集合論的規約.md)。

---

## 1. 章立て

- [`00_記法と集合論的規約.md`](00_記法と集合論的規約.md) — 集合論的背景（ZFC・濃度）、記号規約、埋め込み写像の命名、演算子の添字規則。以降の全章がこの規約に従う。
- [`01_群_準同型_作用.md`](01_群_準同型_作用.md) — 群 $(G,\cdot_G,e_G,\mathrm{inv}_G)$ の公理的定義、部分群・剰余類・商群、準同型、群作用 $\alpha\colon G\times X\to X$、左移動作用素 $L_s$。
- [`02_関数空間ℓ∞と平均.md`](02_関数空間ℓ∞と平均.md) — 有界関数空間 $\ell^\infty(G,\mathbb R)$（Banach 空間）、上限ノルム、左移動の $\ell^\infty$ への作用、**平均（mean）** の厳密定義、左不変平均。
- [`03_従順性の定義.md`](03_従順性の定義.md) — 従順群＝左不変平均をもつ群。両側不変平均との同値、有限群の従順性（計数平均）、最初の帰結。
- [`04_Følner条件と同値定理.md`](04_Følner条件と同値定理.md) — Følner ネット・Følner 条件、Reiter 条件、Day の漸近不変性、**同値定理**（不変平均 ⟺ Følner ⟺ Reiter）の厳密な主張と証明。濃度と実数比の区別を徹底。
- [`05_従順群の例と閉包性質.md`](05_従順群の例と閉包性質.md) — アーベル群（$\mathbb Z^d$ の明示的 Følner 箱、Markov–Kakutani）、有限群、劣指数増大群の従順性。部分群・商・拡大・有向合併に関する閉包性質。
- [`06_非従順性_パラドキシカル分解_Tarski.md`](06_非従順性_パラドキシカル分解_Tarski.md) — パラドキシカル分解の厳密定義、Tarski の定理（従順 ⟺ 非パラドキシカル）、自由群 $F_2$ の ping-pong によるパラドキシカル分解、$F_2$ を含む群の非従順性、Tits 交代律（主張）。
- [`07_従順群のクラスと本プロジェクトへの接続.md`](07_従順群のクラスと本プロジェクトへの接続.md) — 初等従順群 $\mathrm{EG}$、$\mathrm{EG}\subsetneq\mathrm{AG}$（Grigorchuk 群）、増大度、sofic 群。RΛ 双対での役割（Følner 平均化＝エントロピー＝FK 行列式＝$L^2$-torsion、非従順で崩れる清潔さと sofic への移行）。

---

## 2. 主要文献

- F. P. Greenleaf, *Invariant Means on Topological Groups and Their Applications*, Van Nostrand (1969).
- A. L. T. Paterson, *Amenability*, Math. Surveys Monogr. 29, AMS (1988).
- J.-P. Pier, *Amenable Locally Compact Groups*, Wiley (1984).
- V. Runde, *Lectures on Amenability*, Lecture Notes in Math. 1774, Springer (2002).
- S. Wagon, *The Banach–Tarski Paradox*, Cambridge (1985)（Tarski の定理・パラドキシカル分解）.
- N. P. Brown, N. Ozawa, *$C^*$-Algebras and Finite-Dimensional Approximations*, AMS (2008)（sofic・従順の作用素環的側面）.
- Ceccherini-Silberstein, Coornaert, *Cellular Automata and Groups*, Springer (2010)（Følner・sofic）.
