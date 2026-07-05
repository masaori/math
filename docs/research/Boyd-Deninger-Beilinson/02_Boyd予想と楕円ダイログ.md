# 02 Boyd 予想と楕円ダイログ（種数 1 の Mahler 測度 ＝ $L'(E,0)$）

種数 1（零点集合が楕円曲線）での Mahler 測度＝$L$ 値。可積分格子模型でいえば八頂点・臨界近傍に対応する最重要ケース。

## Boyd の数値予想（1998）

Boyd は 2 変数整数多項式族の Mahler 測度を高精度数値計算し、零点集合が楕円曲線 $E$ を定めるとき
$$
m(P)\ \overset{?}{=}\ r\cdot L'(E,0),\qquad r\in\mathbb{Q}^\times
$$
となる例を多数発見した（"Mahler's measure and special values of L-functions", *Experiment. Math.* 7, 1998）。$L(E,s)$ は $E/\mathbb{Q}$ の Hasse–Weil $L$ 函数
$$
L(E,s)=\prod_{p\text{ 良}}\bigl(1-a_p p^{-s}+p^{1-2s}\bigr)^{-1}\times(\text{悪い素点因子}),\quad a_p=p+1-\#E(\mathbb{F}_p),
$$
$L'(E,0)$ は $s=0$ での微分（函数等式で $L(E,2)$ と結ぶ、$\mathrm{ord}_{s=0}L=1$ が典型）。

**代表族**: $P_k(x,y)=x+\tfrac1x+y+\tfrac1y+k$（$k\in\mathbb{Z}$）。$\{P_k=0\}$ は $k$ に依る楕円曲線 $E_k$。Boyd は各 $k$ で $m(P_k)=r_k L'(E_k,0)$（$r_k\in\mathbb{Q}$）を数値予想。

## Deninger の $K_2$ 解釈（1997）

Boyd の前年、Deninger は $m(P)$ を **$K_2$ の正則子**として概念化した（"Deligne periods of mixed motives, K-theory and the entropy of certain $\mathbb{Z}^n$-actions", *J. AMS* 10, 1997）。$C=\{P=0\}$ 上の関数対 $\{x,y\}\in K_2(C)$ の Beilinson 正則子が $m(P)$ に等しく（ファイル 00 の $\frac1{2\pi}\int_\gamma\eta$）、Bloch–Beilinson 予想（ファイル 01 特殊例 2）を通じて $L'(E,0)$ に結ぶ。**これで Boyd の数値予想が Beilinson 予想の帰結として位置づいた**。

Deninger の代表的予想値：
$$
m\!\left(1+x+\tfrac1x+y+\tfrac1y\right)\ \overset{?}{=}\ L'(E,0),\quad E:\ \text{導手 }15\text{ の楕円曲線}.
$$
（曲線 $1+x+1/x+y+1/y=0$ は導手 15 の $E$ に双有理同値。）

## 楕円ダイログによる明示

正則子核は**楕円ダイログ**。$E(\mathbb{C})\cong\mathbb{C}^\times/q^{\mathbb{Z}}$（$q\in\mathbb{C}^\times,|q|<1$）と表し、Bloch–Wigner $D$（ファイル 01）から
$$
D_E(z):=\sum_{n\in\mathbb{Z}}D(q^n z)\quad(z\in\mathbb{C}^\times),
$$
これを $E$ 上のダイビジャーに拡張した $\widehat D_E$ を使う。Beilinson–Levin により
$$
\mathrm{reg}\{x,y\}=(\text{定数})\times\sum_{(\text{記号の台})}(\text{整数係数})\,\widehat D_E(\cdots),
$$
右辺が $L'(E,0)$ の有理数倍に等しい（Beilinson 予想）。$D_E$ は $\mathbb{R}$ 値超越函数で、$q$（したがって $E$ の周期）を通じてのみ $\mathbb{R}$ へ脱出する。可算な記号データ（$K_2$ の元）＋ $E$ の $q$-展開で決まる。

## 証明された例（定理）

- **Rogers–Zudilin (2014)**: $m(1+x+\tfrac1x+y+\tfrac1y)=L'(E_{15},0)$（Deninger の導手 15 予想）を証明。手法はモジュラー単数・Eisenstein–Kronecker 級数・$L$ 値の Rankin–Selberg 積分（$m$ をモジュラー形式の周期積分に書き換え、$L$ 値に帰着）。
- **Brunault, Mellit, Lalín ほか**: Boyd の族の他メンバー、$K_3$ 曲面（3 変数）の一部、$m(P)$＝$L$ 値の追加例を証明。総説は Brunault–Zudilin, *Many Variations of Mahler Measures* (2020)。

**状態の切り分け**: Boyd 予想の**個別例は多数証明**、しかし「族全体・任意の楕円曲線での $m=rL'$」は**一般には未証明**（Beilinson 予想が一般に未解決なため）。

## 種数による閉形式の型（可解系への含意）

| 零点集合 $\{P=0\}$ の型 | Mahler 測度 $m(P)$ | ダイログ | 対応する格子模型（目安）|
|---|---|---|---|
| 種数 0（有理, 円分）| $0$ または $\log(\text{代数的数})$（Kronecker/Smyth）| 初等・Bloch–Wigner $D$ | 自明・自由フェルミオン単純部 |
| 種数 0 だが非自明 | Dirichlet $L$ 値（$L(\chi,2)$ 等, Smyth）| Bloch–Wigner $D$ | 六頂点（有理スペクトル曲線）|
| 種数 1（楕円）| $r\,L'(E,0)$（Boyd/Deninger）| 楕円ダイログ $D_E$ | 八頂点・Ising 臨界近傍（楕円）|
| 種数 $\ge2$・高次 | 高次 $L$ 値・モジュラー（未整備）| 高次正則子 | 一般には非可解 |

**含意（R-Λ 双対 §9 と接続）**: 「可解＝閉形式で書ける」の**型**が、スペクトル曲線の**種数・数論型で決まる**。六頂点（種数 0）は初等/Dirichlet、八頂点（種数 1）は楕円 $L'(E,0)$、それ以上は一般に閉じない。可解系の族の特徴づけとは、**スペクトル曲線がこれら特殊型（低種数・特殊 $L$ 値をもつ）に入る条件の分類**にほかならない。
