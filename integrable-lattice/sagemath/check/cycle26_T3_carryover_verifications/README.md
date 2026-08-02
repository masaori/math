# cycle 26 / T3 Pure: 持ち越し未検証 2 件 — 手順と限界

対応する証明本体: [`outputs/reports/cycle26_T3_carryover_verifications.md`](../../../outputs/reports/cycle26_T3_carryover_verifications.md)。
対象ラベルの宣言は [overview.md](overview.md)、実行結果は [RESULTS.md](RESULTS.md)。

## 何を確かめているか（一言で）

cycle 22 定理 D2 の**レベルごとの判定**——

> $(1.1)$ がレベル $n$ で成り立つ $\iff S(n)=T_\mathrm{def}$

——を、Matrix–Tree 定理で独立に計算した $\mathrm{ord}_\ell(\kappa_n)$ と突き合わせる。
**従来の照合（cycle 22 Step E）は $n\ge n_0$ に限っていたので、$n=0$ と $n<n_0$ は
1 度も突き合わされていなかった。** そこが 2 件の持ち越しの正体である。

## ファイル

| ファイル | 内容 |
|---|---|
| `carryover.sage` | Step A–D をすべて含む 1 本。`../cycle22_T3_coefficients_d_e/_defs22.sage` を load する |
| `carryover.out` | 生ログ |

## Step の割り当て

| Step | 何をするか | 閉じる持ち越し |
|---|---|---|
| A | $\delta_M$ を実測し、$T_\mathrm{def}=0$ の塔を「全 $\delta_M=0$」と「総和だけ $0$」に分ける。符号が混ざる塔を探す | (i) の但し書き |
| B | 判定と実測を全レベル（$n=0$ を含む）で突き合わせる | (i) の判定そのもの |
| C | $n=0$ の同値を単独で出す | (i) の帰結（注 3.1） |
| D | $\ell=2$ トーラスを名指しで調べ、$(1.1)$ の成立開始レベルを機械が決める | (ii) |

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle26_T3_carryover_verifications
sage carryover.sage
```

実測 419.0 秒（設計上限「1 本 20 分以内」の内側）。壁時計上限は Step A に 700 秒、
Step B に 700 秒を置いてある。**打ち切ったら件数と中身を必ず出力する**（実測は打ち切り 0 件）。

## 設計上の要点

- **判定が空振りでないことを数で示す。** 「判定も実測も一致」だけでなく
  **「判定も実測も不一致」の件数を出す**（実測 139 件）。これが 0 なら判定に中身が無い。
- **結論を人が書かず、機械に決めさせる。** Step D の「成立開始レベル」は
  実測した $S(n)$ から求め、$1$ でなければ FAIL にする。
- **$\mathbb{R}$ へ脱出しない。** 整数行列式・有理数演算・$\ell$ 進付値だけ。浮動小数点 0 箇所。

## 限界

- **母集団の外は見ていない**（133 塔 $\times\ \ell\in\{2,3\}$、有効 191 組）。
  「$T_\mathrm{def}=0$ かつ符号が混ざる塔は無い」とは言えない。「この母集団には無い」だけである。
- **レベルの上限**: $\kappa_n$ は $\ell^{2n}|V|$ 次の行列式なので $\ell=2$ で $n\le4$、$\ell=3$ で $n\le3$。
- **これは証明ではない。** 定理 D2 は cycle 22 で証明済みで、ここで足したのは帰結の裏取りである。
