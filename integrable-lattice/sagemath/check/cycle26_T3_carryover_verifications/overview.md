# cycle 26 / T3 Pure: 3 サイクル持ち越しの未検証 2 件 — 対象ラベル

対応する証明本体: [`outputs/reports/cycle26_T3_carryover_verifications.md`](../../../outputs/reports/cycle26_T3_carryover_verifications.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_U` | 係数の情報階層。本検証は、その第 3 層をなす**過渡欠損 $T_\mathrm{def}$** について、cycle 22 定理 D2 の**レベルごとの判定**（「$(1.1)$ がレベル $n$ で成り立つ $\iff S(n)=T_\mathrm{def}$」）を、Matrix–Tree 定理で独立に計算した塔の値と突き合わせて確認する。従来の照合は $n\ge n_0$ に限っていたが、本検証は **$n=0$ を含む全レベル**を見る |
| `paper_prop_M` | 一般の塔の閉形式 $(1.1)$。本検証の Step D は、cycle 21 §6.3 が名指しした $\ell=2$ トーラスについて、$(1.1)$ が $n=1$ から成り立つことが**定理 D2 の判定の内側にある**ことを確定させる |

## 検証する主張（証明本体との対応）

| 証明本体の項目 | 内容 | Step |
|---|---|---|
| 持ち越し (i) の帰結 | $T_\mathrm{def}=0$ の塔で $(1.1)$ が $n=0$ で成り立つ（cycle22 注 3.1 が「Step L では確認していない」と書いた帰結） | C |
| 持ち越し (i) の限定 | 「実在の塔で $\delta_M$ の符号が混ざる例は確認していない」（cycle22 定理 D2 の証明の但し書き） | A |
| レベルごとの判定 | $(1.1)$ がレベル $n$ で成り立つ $\iff S(n)=T_\mathrm{def}$ | B |
| 持ち越し (ii) | cycle21 §6.3 の $\ell=2$ トーラスで、$n=1$ からの一致が保証の内側か外か | D |

## 量の帰属（$\mathbb{R}$ 脱出の有無）

$\Theta_M,\ \delta_M,\ S(n),\ T_\mathrm{def}$ は $\mathbb{Q}$（$\alpha,\beta,\gamma$ が非整数になりうるため）、
$\kappa_n$ と $\mathrm{ord}_\ell(\kappa_n)$ は $\mathbb{Z}$。
すべて整数行列式・有理数演算・$\ell$ 進付値で閉じており、**本検証は $\mathbb{R}$ へ一度も脱出しない**。
浮動小数点は 1 箇所も使っていない。
