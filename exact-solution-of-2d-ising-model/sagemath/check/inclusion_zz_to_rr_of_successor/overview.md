# SageMath Check: inclusion_zz_to_rr_of_successor

## 対象

**対象ラベル**: `inclusion_zz_to_rr_of_successor` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_of_successor`（`n ∈ ℤ` なら `ι(n+1) = ι(n)+1`。`ι` は `inclusion_zz_to_rr`）
- 範囲: `n ∈ ℤ_{≥0}` の 1 行、`n = -1` の 5 行、`n = -(p+1)`（`p ∈ ℤ_{≥1}`）の 11 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `n ∈ ℤ_{≥0}`: `ι(n+1) = ι(n)+1`（`inclusion_zz_to_rr` の定義） | `check_proof_lines.sage` | `n = 0..199` で QQ の等号。`ι` は定義の再帰（共通の準備 `sagemath/_shared/inclusion_zz_to_rr_by_definition.sage`） | **PASS** |
| `n = -1`: `ι((-1)+1) = ι(0) = 0 = (-1)+1 = (-ι(1))+1 = ι(-1)+1` | `check_proof_lines.sage` | 5 個の等号（QQ） | **PASS** |
| `n = -(p+1)`: `ι(-(p+1)+1) = ι(((-p)+(-1))+1) = ι((-p)+((-1)+1)) = ι((-p)+0) = ι(-p) = -ι(p) = -ι(p)+0 = -ι(p)+((-1)+1) = (-ι(p)+(-1))+1 = -(ι(p)+1)+1 = -ι(p+1)+1 = ι(-(p+1))+1` | `check_proof_lines.sage` | `p = 1..199` で 11 個の等号（QQ。1 行目は `int_negation_of_sum_is_sum_of_negations`、2〜4 行目は ℤ の加法の結合律・加法の逆元・和の単位元。`-(x+y) = (-x)+(-y)` は `real_negation_of_sum_is_sum_of_negations`） | **PASS** |
| 主張 | `check_proof_lines.sage` | `n = -200..199` で主張と、組み込みの埋め込み `QQ(n)` との一致 | **PASS** |

等号は 3194 個。否定コントロール: 定義の負の元の節 `ι(-n) := -ι(n)` を `ι'(-n) := -ι(n) - 1` に取り違えた写像 `ι'` では、`n = -1` で `ι'(0) = 0 ≠ -1 = ι'(-1)+1`。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い。範囲は `-200 ≤ n ≤ 199`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は再帰の定義と QQ の結合律・加法逆元をなぞるので構成上一致する。中身は組み込みの埋め込みとの比較にある。
- `n = -(p+1)` の 2〜4 行目（`ι(((-p)+(-1))+1)`・`ι((-p)+((-1)+1))`・`ι((-p)+0)`）は、`ι` の引数を Python の整数として先に計算するので、どれも `ι(-p)` と同じ値になる。この 3 行は行の書き写しの誤りだけを検出する。ℤ の等式そのものは `int_negation_of_sum_is_sum_of_negations` の検算（`ZZ[x, y]` で各段）が確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_zz_to_rr_of_successor
```

実行ログは `logs/` に保存する。
