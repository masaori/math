# cycle 8 / T1 Reframe: 最小双対モデル z−c の完全命題（自由エネルギー ↔ LTE）

トラック1 Reframe の完結した小例: 統計力学の自由エネルギーと有限サイズ Massieu $\Phi_L\in\Lambda$ を、同一多項式 $z-c$ の二素点として**厳密・初等・形式検証可能**に並置。検証 `sagemath/check/cycle7_T1_lte/`（LTE: p 奇・p=2 とも全 True）。

## モデル

$c\in\mathbb{Z}_{\ge2}$。多項式 $P(z)=z-c$ の $L$-周期点分配 $a_L=\prod_{\zeta^L=1}(\zeta-c)=(-1)^L(c^L-1)$、$|a_L|=c^L-1\in\mathbb{N}$。
（＝1サイト・重み $c$ の格子分配の代数版／代数力学 $z\mapsto$ の周期点数。）

## 命題 R（ℝ 側, アルキメデス）

$$f:=\lim_{L\to\infty}\frac1L\log|a_L|=\log c=m(z-c)\quad(\text{Mahler 測度}=\text{自由エネルギー}=\text{エントロピー}).$$
（$m(z-c)=\max(1,|c|)=c$ の対数。LSW の最小例。）住処 $\mathbb{R}$（連続極限＝ℝ脱出 (b)）。

## 命題 Λ（$p$ 進, 各素点）— LTE で完全・決定可能

$\Phi_L=\log|a_L|\in\Lambda$、その $\ell_p$ 係数 $v_p(c^L-1)$ は **lifting-the-exponent (LTE)** で閉じる:

- **$p$ 奇, $p\nmid c$**: $\mathrm{ord}_p(c)=d$ として
  $$v_p(c^L-1)=\begin{cases}0,& d\nmid L,\\ v_p(c^{d}-1)+v_p(L),& d\mid L.\end{cases}$$
- **$p=2$, $c$ 奇**:
  $$v_2(c^L-1)=\begin{cases}v_2(c-1),& L\ \text{奇},\\ v_2(c-1)+v_2(c+1)+v_2(L)-1,& L\ \text{偶}.\end{cases}$$
- **$p\mid c$**: $c^L\equiv0$, $v_p(c^L-1)=0$。

住処 $\Lambda$（係数 $\in\mathbb{Z}$）。等号・順序は素因数分解・整数比較で**無条件決定可能**、$\mathbb{R}$ 不使用。検証: c=2,3（p 奇）, c=3,5,7,9,15（p=2）で予測＝実測 全 True。

## 双対（命題 R ↔ 命題 Λ）

同一の $z-c$ から:
- $\infty$ 素点 → $\log c$（自由エネルギー, ℝ, 連続極限）。
- $p$ 素点 → $v_p(c^L-1)$ の LTE 構造（$\Phi_L$ の素因数構造, Λ, 有限・決定可能）。
- 岩澤 $\mu_p$（塔 $L=p^n$ の線形成長率）は $\mathrm{ord}_p(c)$ が $p$ 冪のとき以外 0（generic 自明; cycle7）。**Λ 側の本体は単一数 $\mu_p$ でなく全 $L$ の LTE 構造**。

## 形式検証（T1 の眼目）

LTE は**初等的に証明可能・`decide` 可能**:
- $v_p(c^L-1)$ の各分岐は $\mathbb{Z}$ 上の付値・整除条件で、Lean/Coq の `decide`/帰納で証明できる（実解析・$\mathbb{R}$ 不要、強度 RCA₀ 級）。witness = $(d=\mathrm{ord}_p(c),\ v_p(c^d-1))$。
- Lean ターゲット仕様: 定理 `v_p(c^L-1) = if d ∣ L then v_p(c^d-1)+v_p(L) else 0`（p 奇）。Mathlib に `multiplicity`/LTE 補題あり（`multiplicity.Nat.pow_sub_one` 系）→ 既存補題で形式化可能。
- 環境に Lean 未導入のため本サイクルは仕様確定まで（実装は導入後）。

## 位置づけ（正直に）

- 数学的中身（Mahler 測度＝エントロピー、LTE）は既知。本命題の Reframe 価値は、**統計力学の自由エネルギーと有限サイズ Φ の素因数構造を、同一多項式の二素点として、可算・決定可能・形式検証可能に明示パッケージ**したこと。最小だが完結した双対の実例。
- 一般のスペクトル曲線 $P(z,w)$ への拡張が cycle 9+ の課題（六頂点・Ising、L 函数経由）。
