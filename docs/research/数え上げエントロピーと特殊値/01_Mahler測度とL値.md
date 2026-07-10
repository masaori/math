# 01 Mahler 測度と $L$ 値（既知結果の landscape）

$n$ 変数 Laurent 多項式 $P$ の Mahler 測度 $m(P)=\frac1{(2\pi i)^n}\int_{\mathbb T^n}\log|P|\frac{dx_1}{x_1}\cdots$。$n=1$ は Jensen で代数的。$n\ge2$ で整（代数）係数の $m(P)$ がしばしば **$L$ 函数の特殊値の有理（代数）倍**になる。[E]＝定理、[C/O]＝予想。

標準書: F. Brunault, W. Zudilin, *Many Variations of Mahler Measures*, Cambridge (2020)。

## 1. 基礎

**Smyth (1981) [E]**（種数0の原型）:
$$m(1+x+y)=L'(\chi_{-3},-1)=\frac{3\sqrt3}{4\pi}L(\chi_{-3},2),\qquad m(1+x+y+z)=\frac7{2\pi^2}\zeta(3).$$

**Cassaigne–Maillot [E]**（三項式＝dilog）: $\pi\,m(a+bx+cy)$ は三角不等式が成れば Bloch–Wigner dilog $D$ ＋角度×対数、否なら $\pi\log\max(|a|,|b|,|c|)$。特殊化で Catalan $\beta(2)$。

**Deninger (1997) [E 枠組み/C/O 値]**: 2 変数で $C=\{P=0\}$、$m(P)$（初等項を除く）＝記号 $\{x,y\}\in K_2(C)$ の Beilinson 正則子。導手15 例 $m(1{+}x{+}\frac1x{+}y{+}\frac1y)\stackrel?=L'(E,0)$ を Bloch–Beilinson で予言。

**Beilinson 予想背景**: 動機的コホモロジー $\to$ Deligne コホモロジーの正則子の共体積 $=L^{(i)}$（$\bmod\mathbb{Q}^\times$）。Mahler 測度は計算可能な正則子の実例。

**Boyd (1998) [C/O]**: 数百族を高精度数値検証、$m(P)=r\,L'(E,0)=r\frac{N}{4\pi^2}L(E,2)$（$r\in\mathbb{Q}$, $E$ 導手 $N$）を定式化。elliptic story の実証的基盤。**Chinburg 予想**（1984）: 全ての奇 $\chi$ で $L'(\chi,-1)$ が 2 変数 Mahler 測度の有理倍として実現。

## 2. 種数1（楕円曲線）

**中心族** $P_k=x+\frac1x+y+\frac1y+k$。$k\ne0,\pm4$ で $\{P_k=0\}$ は楕円 $E_k$、$m(P_k)\stackrel?=r_k L'(E_k,0)$。Deninger 例 $k=1$（導手15）。

- **Rodriguez-Villegas (1999) [E for CM]**: $m(P_k)$ を Eisenstein–Kronecker–Lerch 級数（modular parameter）で表示、$E_k$ が **CM** の $k$ で $L$ 値等式を証明（CM で Beilinson が定理）。**tempered**（Newton 多角形の面が自明 tame symbol）条件＝clean $L$ 値が出る指標。
- **Rogers–Zudilin (2012, 2014) [E]**: 「Rogers–Zudilin 法」で予想を定理化。$m(1{+}x{+}\frac1x{+}y{+}\frac1y)=L'(E_{15},0)=\frac{15}{4\pi^2}L(E,2)$ を証明（IMRN 2014）。Compositio 2012 で導手20,24、CM 導手27,36 の超幾何表示。
- **Mellit (2009→) [E]**: elliptic dilog / parallel lines で導手14 ほか、測度間の等式を証明。
- **Brunault (2016) [E]**: Siegel 単数の正則子公式で導手 **14,21,35,48,54** の Boyd 予想を証明。
- **Lalín ほか [E]**: 導手21（J. LMS 2016）、isogeny と Mahler 測度（JTNB 2013）、genus 2 曲線への正則子法（arXiv:1811.05189）、代数的積分法で $\zeta(3),\zeta(5)$ 評価（Duke 2007）。
- **非 tempered/非 reciprocal [E, 近年]**: Samart（arXiv:2301.05390）、Brunault ほか（Res. Math. Sci. 2019）。余分な Dirichlet $L$ 補正項。

**総括**: 一般 Boyd 予想 $m(P)=rL'(E,0)$ は**一般には未証明**だが、導手 11,14,15,17,19,20,21,24,27,30,35,36,37,48,54,… で**個別に定理**。

## 3. K3・Calabi–Yau（3–4変数, weight $\ge3$）

- **Bertin (2006) [E/C/O]**: $x+\frac1x+y+\frac1y+z+\frac1z-k$ の零点は K3 族（しばしば Picard 数20, CM）。$m$ を weight-3 CM newform の $L(f,3)$ ＋ Dirichlet 補正で表示。最初の weight-3 現象。
- **Samart (2013–16) [E]**: 3 変数 Mahler 測度 $=r_1 L'(f,0)+r_2 L'(\chi,-1)$（$f$ weight-3 CM newform）を証明、新 $_pF_{p-1}$ 評価。elliptic trilogarithm（2016）、複数 modular forms の $L$ 値の線形結合（2016）。
- **Papanikolas–Rogers–Samart (2014) [E]**: 4 変数 Mahler 測度（零点＝CY3）が $S_4(\Gamma_0(8))$ の weight-4 newform の特殊 $L$ 値＋$\zeta$ で表される（$_6F_5(1)$ 相当）。weight-4 の実例。
- **超幾何/格子和（Rogers, Zudilin）[E]**: Mahler 測度を楕円積分のモーメント・Ramanujan 型級数に接続。

## 4. Dirichlet $L$・$\zeta(3)$・Catalan（種数0 の zoo）

有理曲線 $\to$ polylog/Dirichlet 世界（楕円曲線なし）。証明済み例: Smyth の 2 式；Cassaigne–Maillot 経由の $\beta(2)/\pi$（Catalan）；Vandervelde（双線形 $axy+bx+cy+d$）；Lalín（多変数 $\zeta(2k-1)$）。統制原理: **tempered 有理曲線多項式の Mahler 測度は $\{L'(\chi,-1),\zeta(3),\dots\}$ の $\mathbb{Q}$-span**（Bloch–Wigner–Ramakrishnan 正則子）。**Chinburg 予想**（全 Dirichlet $L'$ が Mahler 測度で実現）は小導手で既知、一般に未解決。

## 5. 一般的な予想枠組み

1. $m(P)$ は $\{P=0\}$ の mixed motive の**周期**＝記号（Milnor $\{x_1,\dots\}$）の Beilinson 正則子。
2. Beilinson 予想でこれ ＝ $L^{(j)}(H^\bullet(\{P=0\}))$ の有理倍。閉形式の weight ＝ $H^{n-1}$ の weight（種数0→dilog/$\zeta(3)$/Dirichlet；楕円→$L(E,2)$；K3→weight-3；CY3→weight-4）。
3. **閉形式が期待される条件**: **tempered**（Newton 多面体の面が自明境界記号）。tempered＋該当 Beilinson ⇒ clean $L$ 値；非 tempered ⇒ 低 weight 補正項；generic ⇒ 閉形式なし。
4. **CM の役割**: $\{P=0\}$ が CM なら Beilinson が定理（Bloch, Deninger）ゆえ証明可能。RV の CM・Samart の CM weight-3 が定理なのはこのため。
5. **Boyd–Lawton 定理 [E]**: 多変数 Mahler 測度は 1 変数の極限。多変数極限へ一般化（Brunault–Guilloux–Mehrabdollahei–Pengo 2024）。

## 6. 近年（2015–2025）

- **higher/multiple Mahler 測度 [E]**: $\log^k|P|$（Kurokawa–Lalín–Ochiai 2008）、zeta Mahler 測度、log-sine 評価（Borwein–Straub–Wan–Zudilin）、$p$ 進 higher Mahler 測度。
- **exact 多項式と Deligne–Beilinson コホモロジー [E/条件付]**: Trieu（arXiv:2412.00893, 2024–25）、4 変数 exact を $L(\text{K3},4)$ に、Beilinson 下で $m((x{+}1)(y{+}1)(z{+}1)+t)$ を weight-3 level-7 newform に。**一般機構**の現状最前線。
- **Chinburg 新証拠 (2026)**: arXiv:2603.20820（どの多項式がどの Dirichlet $L'$ を実現するかの明示分類へ）。
- **Ising との直結**: Viswanathan arXiv:2407.19531（2024）。

**明示分類はあるか**: 完全なものはない。最も近いのは「tempered＋$\{P=0\}$ の型 ⇒ 予言 weight の $L$ 値」＋ Chinburg 予想（種数0方向）。どの有理倍 $r$ が出るかの必要十分な組合せ判定は未解決（Brunault–Zudilin 2020 が field の指針的未解決問題として提示）。

## 参考文献
Smyth (1981) Bull. AMS 23; Boyd (1998) Exp. Math. 7; Deninger (1997) JAMS 10; Rodriguez-Villegas (1999) *Topics in Number Theory*; Rogers–Zudilin (2012) Compositio 148, (2014) IMRN; Mellit (arXiv:1207.4722); Brunault (2016) JNT 163; Lalín (2016) J. LMS 93; Bertin (2006) Mirror Symmetry V; Samart (2013) Ramanujan J. 32; Papanikolas–Rogers–Samart (2014) Math. Z. 276; Kurokawa–Lalín–Ochiai (2008) Acta Arith. 135; Brunault–Zudilin (2020) *Many Variations of Mahler Measures*, Cambridge.
