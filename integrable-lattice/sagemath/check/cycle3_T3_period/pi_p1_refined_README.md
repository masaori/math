# cycle 8 / T3: π(p,1) の精密公式と等号条件（確定）

スクリプト `pi_p1_refined.sage`, `pi_p1_strict_demo.sage`、出力 `.out`（SageMath 10.6）。

## 精密公式（rigorous）

$\mathrm{Tr}\,T^N\bmod p=\sum_{\lambda}(m_\lambda\bmod p)\,\lambda^N$（$\lambda$＝相異固有値 $\in\overline{\mathbb{F}_p}^\times$, $m_\lambda$＝代数的重複度）。相異 $\lambda$ の幾何列 $\{\lambda^N\}$ は**一次独立**だから、$\sum$ の周期は係数 $m_\lambda\not\equiv0$ の項の order の lcm:
$$\boxed{\ \pi(p,1)=\mathrm{lcm}\{\mathrm{ord}(\lambda):\ p\nmid m_\lambda\}\ }$$

## 等号条件（cycle7 の $\pi=\mathrm{lcm}_{\text{all}}$ はいつか）

$$\pi(p,1)=\mathrm{lcm}\{\mathrm{ord}(\lambda):\text{全}\lambda\}\iff \text{lcm に効く全固有値の重複度が } p\nmid m_\lambda.$$
重複度が $p\mid m_\lambda$ の固有値は**トレース mod p から脱落**し、その order が他に無ければ周期を真に下げる（strict $<$）。

## 検証

- 六頂点 27 例: 全て $\pi(p,1)=\mathrm{lcm}_{\text{refined}}$（OK）。これらでは strict は出ず（脱落固有値の order が他と重複）。
- **構成例で strict を実演**: $T=\mathrm{diag}(A^{\times p},B)$（$A$=companion($x^2-3x+1$), $B$=companion($x-2$)）。$A$ の固有値は重複度 $p\equiv0$ で脱落:
  - p=7: $\pi=3=\mathrm{lcm}_{\text{refined}}$, $\mathrm{lcm}_{\text{all}}=24$ → **strict**。
  - p=13: $\pi=12$, $\mathrm{lcm}_{\text{all}}=84$ → **strict**。
  - 全例 $\pi=\mathrm{lcm}_{\text{refined}}$（精密公式 confirmed）。

## T3 トラックの確定事項（まとめ）

1. D-U2 命題 A: $v_p(Z_N)$ は周期 $\pi(p,k)$ で最終周期（決定可能, cycle3）。
2. $\pi(p,1)=\mathrm{lcm}\{\mathrm{ord}(\lambda): p\nmid m_\lambda\}$（精密・rigorous, cycle8）。一次独立による。
3. 周期上界 $\pi(p,k)\mid p^{k-1}\pi(p,1)$（既知）→ 全体で $v_p(Z_N)$ の周期は固有値 order と重複度から**決定可能・閉形**。
4. Wall 等号 $\pi(p,k)=p^{k-1}\pi(p,1)$ は一般・可積分とも不成立（棄却, cycle6）。

⇒ D-U2 の Λ 側（Massieu $\Phi$ の $\ell_p$ 係数の周期構造）は、固有値の F̄_p 上 order と mod-p 重複度で**完全に決定可能**。形式検証に乗る初等的命題群。
