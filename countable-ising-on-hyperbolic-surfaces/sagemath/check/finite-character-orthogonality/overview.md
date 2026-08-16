# 有限第一ホモロジー群上の文字直交関係の検算

**対象ラベル**: `theorem_finite_character_orthogonality`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_theorem_character_orthogonality`）
- 範囲: 次元 `0` から `4` の有限 `F_2` ベクトル空間について、全ての二つのホモロジー類に対する整数符号文字の積の総和

## チェック一覧

実行日: 2026-08-16

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_orthogonality.sage` | 乗法性による和の移し替え、非零類を `1_{F_2}` へ送る文字の存在、その文字による符号反転対合、最終的な場合分けを全列挙で照合する | PASS | 次元 `0` から `4` の全てのホモロジー類の組について直交関係が成立した |

## 備考

- 非可算への脱出はない。`GF(2)` と `ZZ` の厳密演算だけを用いた。
- 有限 Fourier 逆変換は後続の主張で扱う。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-character-orthogonality/check_orthogonality.sage
```
