# 整数符号実現の乗法性の検算

**対象ラベル**: `claim_integer_sign_character_multiplicativity`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_claim_integer_sign_character_multiplicativity`）
- 範囲: 次元 `0` から `4` の有限 `F_2` ベクトル空間について、全ての `F_2` 値文字と全てのホモロジー類の組で、和の整数符号が各整数符号の積に等しいこと

## チェック一覧

実行日: 2026-08-16

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_multiplicativity.sage` | 文字の線形性、`F_2` の加法、整数符号実現の二場合、最終的な乗法性を全列挙で照合する | PASS | 次元 `0` から `4` の全ての文字とホモロジー類の組について等式が成立した |

## 備考

- 非可算への脱出はない。`GF(2)` と `ZZ` の厳密演算だけを用いた。
- 文字直交関係は後続の主張で扱う。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/integer-sign-character-multiplicativity/check_multiplicativity.sage
```
