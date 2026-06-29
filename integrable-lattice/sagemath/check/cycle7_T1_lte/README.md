# cycle 7 / T1: ℝ/Λ 双対の Λ 側＝LTE 構造（clean な厳密例）

スクリプト `lte_structure.sage`、出力 `.out`（SageMath 10.6）。

## 設定（最小の clean 例）

$P(z)=z-c$（1変数）。周期点数 $a_L=\prod_{\zeta^L=1}(\zeta-c)=(-1)^L(c^L-1)$、$|a_L|=c^L-1$。
これは「1サイト・状態重み $c$」の格子模型の分配関数の代数版。

## 両素点（確認済み, 厳密）

- **ℝ 側**: $\dfrac1L\log|a_L|\to\log c=m(z-c)$（Mahler 測度＝自由エネルギー＝エントロピー）。検証: c=2 で →0.6931, c=3 で →1.0986。
- **Λ 側**: $\Phi_L=\log(c^L-1)\in\Lambda$ の $\ell_p$ 係数 $v_p(c^L-1)$ は **LTE（lifting-the-exponent）で厳密・決定可能**:
  $$v_p(c^L-1)=\begin{cases}0 & \mathrm{ord}_p(c)\nmid L\\ v_p(c^{\mathrm{ord}_p(c)}-1)+v_p(L) & \mathrm{ord}_p(c)\mid L\end{cases}\quad(p\text{ 奇},\ p\nmid c).$$
  **予測＝実測が L=1..24 で全ケース True**（c=2,3, p=3,5,7,11）。

## 岩澤 μ_p（p 進エントロピー単一数）は generic に 0

岩澤塔 $L=p^n$ での $v_p(c^{p^n}-1)$ は全例で $[0,0,0,0]$ ⇒ $\mu_p=0$。
理由: $\mathrm{ord}_p(c)\mid p^n$ となるのは $\mathrm{ord}_p(c)$ が $p$ 冪のとき（稀, Wieferich 的）。一般に岩澤 $\mu=0$（Iwasawa μ=0 予想領域）。

## 結論（正直に・双対の Λ 側の正しい姿）

- **双対の Λ 側の本体は、単一数 $\mu_p$（p 進エントロピー）ではなく、全 $L$ にわたる LTE/円分構造**。
- $\mu_p$ は generic に 0（非自明例は Wieferich 的で稀）。よって「p 進 Mahler 測度＝単一数」を双対の Λ 側と見るのは痩せ過ぎ。**豊かな Λ 側＝LTE による $v_p(a_L)$ の完全な算術構造**であり、これは**決定可能・形式検証可能**（LTE は初等的に証明・`decide` 可能）。
- これで cycle 6 の「Λ 側＝p 進エントロピー」を精密化: p 進エントロピー（μ_p）はその一断面（しばしば自明）、本体は LTE 構造。

## T1 Reframe としての成果

統計力学の自由エネルギー（$\log c$, ℝ）と、その有限サイズ Massieu $\Phi_L\in\Lambda$ の素因数構造（LTE, 決定可能）を、同一多項式 $z-c$ の二素点として厳密・初等・機械検証可能に並置。LTE は Lean 等で `decide`/帰納証明可能（形式検証の良い標的）。
