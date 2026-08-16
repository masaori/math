# 有限第一ホモロジー群上の Fourier 逆変換の検算

**対象ラベル**: `theorem_finite_fourier_inverse_transform`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_theorem_inverse_transform`）
- 範囲: 次元 `0` から `4` の有限 `F_2` ベクトル空間について、任意の入力多項式族を表す独立な不定元に対する有限 Fourier 変換と逆変換

## チェック一覧

実行日: 2026-08-17

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_inverse_transform.sage` | Fourier 変換の展開、有限和の交換、文字直交関係による縮約、文字数の有理数逆数による復元を記号的に照合する | PASS | 次元 `0` から `4` の全てのホモロジー類について逆変換が成立した |

## 備考

- 入力族の各成分を独立な不定元に置いたため、特定の数値例ではなく任意の多項式族に対する線形恒等式を検算した。
- 分母 `|H^vee|` の逆数を取る箇所だけ `QQ` を用いる。その他は `GF(2)` と整数符号の有限和である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-fourier-inverse-transform/check_inverse_transform.sage
```
