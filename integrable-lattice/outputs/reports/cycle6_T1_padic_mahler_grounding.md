# cycle 6 / T1: ℝ/Λ 双対の Λ 側を既知理論（p 進エントロピー）に接地

検証: `sagemath/check/cycle6_T1_padic_mahler/`。文献: Besser–Deninger「p-adic Mahler measures」, Deninger「p-adic entropy and a p-adic Fuglede–Kadison determinant」, 「p-adic Mahler measure and ℤ-covers of links」(torsion 成長・Alexander 多項式・p 進エントロピー・岩澤 μ_p の balance formula)。

## 主張（双対の両側の既知理論的 backbone）

整数多項式 $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$ の周期点数 $a_L=\prod_{z^L=w^L=1}P\in\mathbb{Z}$ について:

- **ℝ 側（アルキメデス）**: $\dfrac1{L^2}\log|a_L|\to m(P)$（Mahler 測度＝自由エネルギー＝位相的エントロピー）。**既知**（Lind–Schmidt–Ward; Ising で精密 arXiv:2407.19531）。検証: $\to 1.508$。
- **Λ 側（$p$ 進）**: 岩澤塔 $L=p^n$ での $v_p(a_{p^n})$ の線形成長率 ＝ **Deninger の $p$ 進エントロピー** ＝ **Besser–Deninger の $p$ 進 Mahler 測度** ＝ **岩澤 $\mu_p$ 不変量**。**これも既知理論**（予想ではない）。

⇒ ℝ/Λ 双対は「同一整数多項式 $P$ の、アルキメデス Mahler 測度（ℝ＝自由エネルギー）と $p$ 進 Mahler 測度（Λ＝$\Phi$ の素因数構造の成長）」という、**両側とも確立した理論への接続**になった。cycle 4 で「Λ 側は予想」としたが、**Deninger の p 進エントロピー理論がまさにその Λ 側**である。

## 本プロジェクトの位置（正直に）

- **新しい数学ではない**: 双方とも既知（Mahler 測度＝エントロピー、p 進エントロピー＝p 進 Mahler）。本プロジェクトの寄与（T1 Reframe）は、**統計力学の自由エネルギーと、その有限サイズ版 Massieu $\Phi_L\in\Lambda$ の素因数構造を、同一多項式の二つの素点での Mahler 測度として、可算・決定可能・形式検証可能な言葉で並置・明示**したこと。
- **D-U2 命題 A（有限 $L$ の $v_p$ の周期・決定可能性）はこの理論の「有限・初等・決定可能な顔」**。p 進エントロピー（μ_p）は塔 $L=p^n$ の極限の顔。

## 検証データ

- $(1/L^2)\log|a_L|$: L=2..9 で 1.354→1.508（→ m(P)）。
- p=2 塔 (L=2,4,8): $v_2=[0,0,0]$ ⇒ $\mu_2=0$。p=3 塔 (L=3,9): $v_3=[0,0]$ ⇒ $\mu_3=0$。
- ⇒ この $P$ は小素数で **$p$ 進エントロピー（μ_p）= 0**（$a_{p^n}$ が $p$ 進単数）。非自明な μ_p を見るには $P\bmod p$ が $p$ 冪根上に零点をもつ $P$ が要る（次の課題）。

## 含意・次（cycle 7+）

- 非自明な μ_p（p 進エントロピー>0）をもつ $P$ を構成し、$v_p(a_{p^n})$ の線形成長＝μ_p を実証（Iwasawa μ の具体例）。
- Ising スペクトル曲線（arXiv:2407.19531 の Laurent 多項式）で両素点を計算し、ℝ側=楕円曲線 L 函数、Λ側=同曲線の p 進 L/μ_p、を対応づける（双対の最深部、L 函数経由）。
- 研究ノート `docs/research/R-Lambda-duality/` を本接地で更新（別途）。
