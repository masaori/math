# `F_2` 値文字の整数符号実現の検算

**対象ラベル**: `def_integer_sign_character_realization`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_integer_sign_character_realization`）
- 範囲: 次元 `0` から `4` の有限 `F_2` ベクトル空間について、全ての `F_2` 値文字の各値を本文の二場合に従って整数 `+1` または `-1` へ送ること

## チェック一覧

実行日: 2026-08-16

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 全ての係数ベクトルとホモロジー類について、`0_{F_2}` を整数 `+1`、`1_{F_2}` を整数 `-1` へ送る二場合を照合する | PASS | 全ての像が `{-1,+1}` に入り、本文の定義と一致した |

## 備考

- 非可算への脱出はない。`GF(2)` と `ZZ` の厳密演算だけを用いた。
- この検算は写像の定義だけを対象とする。符号文字の乗法性と文字直交関係は後続の主張で扱う。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/integer-sign-character-realization/check_definition.sage
```
