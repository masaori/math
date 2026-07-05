# Boyd–Deninger–Beilinson 理論（Mahler 測度 ＝ $L$ 函数の特殊値）

「整数係数多項式の **Mahler 測度** が、その零点集合が定める代数多様体の **$L$ 函数の特殊値**（正則子経由）に等しい」という一連の予想・定理群のまとめ。

**動機（本リポジトリ内の位置づけ）**: `docs/research/R-Lambda-duality/` §9 で、可積分格子模型の自由エネルギー $-\beta f=\log m(P)$（$P\in\mathbb{Z}[z^\pm,w]$ スペクトル曲線の Mahler 測度）が閉形式を持つ条件を「$\{P=0\}$ の数論型 ＝ $m(P)$ が特殊 $L$ 値」に翻訳した。その数論の実体がこの理論。ここでは可解性の特徴づけに必要な数論を独立にまとめる。

---

## 記述上の原則（本リポジトリ共通・厳守）

1. **数学的厳密性**: 登場するすべての記号がどの集合に属するかを明示する。$\mathbb{Q},\overline{\mathbb{Q}},\mathbb{R},\mathbb{C},\mathbb{Q}_p$ などの分別、可算/非可算、収束を語れるか否かを常に併記する。
2. **比喩を使わない**。
3. **未証明と既証明を分ける**。Beilinson 予想の大半は予想、Borel（数体）・一部の楕円曲線（Rogers–Zudilin 等）は定理。都度明示する。

---

## 全体像（一枚の対応表）

共通の素材：整数（または代数的）係数 Laurent 多項式 $P\in\mathbb{Z}[x_1^{\pm1},\dots,x_n^{\pm1}]$、その零点集合 $V(P)=\{P=0\}$（代数多様体, $n=2$ で曲線）。

| 素点 $v$ | 測度 | 正則子（regulator）| $L$ 函数の特殊値 | 状態 |
|---|---|---|---|---|
| $\infty$（アルキメデス）| Mahler 測度 $m(P)\in\mathbb{R}$ | Beilinson 正則子（Deligne コホモロジーへ）| $L(V,s)$ の非臨界特殊値 | 予想（低次元で定理）|
| $p$（非アルキメデス）| $p$ 進 Mahler 測度 $m_p(P)\in\mathbb{C}_p$ | syntomic/Coleman 正則子 | $p$ 進 $L$ 函数の特殊値 | 予想（Besser–Deninger）|

**核心命題（Beilinson の枠組み）**: $m(P)$ は多様体 $V(P)$ 上の **$K$ 群の元 $\{x_1,\dots\}$（Milnor 記号）の正則子の値**として書け、Beilinson 予想により $V(P)$ の $L$ 函数の特殊値（有理数倍）に一致する。$\infty$ と $p$ は**同一の動機的 $L$ 函数の異なる素点での特殊値**（これが R-Λ 双対 6-1 の成熟形）。

---

## ファイル一覧

- [00_Mahler測度と正則子.md](00_Mahler測度と正則子.md) — Mahler 測度の定義（$\int_{\mathbb{T}^n}\log|P|$）、Jensen 公式、Lehmer 問題、Kronecker、Smyth の最初の多変数評価（$\to$ Dirichlet $L$ 値）。正則子写像の導入。
- [01_Beilinson予想.md](01_Beilinson予想.md) — Beilinson 予想の一般形（動機的コホモロジー $\to$ Deligne コホモロジーの正則子行列式 ＝ $L$ 特殊値）、Borel（数体の $\zeta$）・Bloch（楕円曲線 $K_2$）の特殊例。
- [02_Boyd予想と楕円ダイログ.md](02_Boyd予想と楕円ダイログ.md) — Boyd の数値予想（2 変数 $\to$ 楕円曲線 $L'(E,0)$）、Deninger の $K_2$ 解釈、楕円ダイログ（Bloch–Wigner–Zagier）、Rogers–Zudilin による証明例。
- [03_p進版_Besser-Deninger.md](03_p進版_Besser-Deninger.md) — $p$ 進 Mahler 測度、syntomic 正則子、$p$ 進 $L$ 値、Deninger の $p$ 進エントロピー。R-Λ 双対の $\Lambda$ 側（$\mu_p$）との対応。
- [04_格子模型とRΛ双対への接続.md](04_格子模型とRΛ双対への接続.md) — 自由エネルギー ＝ Mahler 測度（dimer/Ising, Kenyon, LSW）、スペクトル曲線の数論型と閉形式型（種数 0/1/高次）、可解系の族の特徴づけへの含意。

---

## 主要文献

- C. J. Smyth, "On measures of polynomials in several variables", *Bull. Austral. Math. Soc.* 23 (1981).（$m(1+x+y)$, $m(1+x+y+z)$）
- D. Boyd, "Mahler's measure and special values of L-functions", *Experiment. Math.* 7 (1998).（予想の集大成）
- C. Deninger, "Deligne periods of mixed motives, K-theory and the entropy of certain $\mathbb{Z}^n$-actions", *J. Amer. Math. Soc.* 10 (1997).（$m(P)$＝正則子、エントロピーとの結合）
- A. Beilinson, "Higher regulators and values of L-functions", *J. Soviet Math.* 30 (1985).（一般予想）
- M. Rogers, W. Zudilin, "On the Mahler measure of $1+X+1/X+Y+1/Y$", *Int. Math. Res. Not.* (2014).（Deninger 予想の証明）
- A. Besser, C. Deninger, "$p$-adic Mahler measures", *J. reine angew. Math.* 517 (1999).（$p$ 進版）
- F. Brunault, W. Zudilin, *Many Variations of Mahler Measures*, Cambridge (2020).（現代的総説）
- D. Lind, K. Schmidt, T. Ward, "Mahler measure and entropy for commuting automorphisms of compact groups", *Invent. Math.* 101 (1990).（エントロピー＝Mahler 測度）
