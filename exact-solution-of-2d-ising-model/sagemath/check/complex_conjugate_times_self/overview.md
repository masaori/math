# SageMath Check: complex_conjugate_times_self

## 対象

**対象ラベル**: `complex_conjugate_times_self` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`
- ブロック: `exp_conjugation_claim_complex_conjugate_times_self`（複素共役と自分自身の積は絶対値の二乗の包含）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `conj(z) z` から `(|z|^2)_C` までの 5 行 | `check_chain.sage` | `z = (x, y)` の `x, y` を不定元に置いて隣り合う行が等しい（`|z|^2 = x^2 + y^2` は `abs_basic_properties` (2)） | **PASS** | 厳密等号 |
| 主張 | 同上 | 具体の 20 点で、本文の `|z|`（`AA` の平方根）の二乗と、QQbar の `abs` の二乗の両方と比べた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点はない。ℂ は実数の対で持ち、`|z|` は `AA` で厳密に平方根を取った。

具体の点で QQbar の `abs` と比べた。

## 確かめられない行と理由

`(x,-y)(x,y) = (xx-(-y)y, xy+(-y)x)` の行は `definition_of_cc` の積の定義そのもので同語反復である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_conjugate_times_self
```

実行ログは `sagemath/check/complex_conjugate_times_self/logs/` に保存する。
