# SageMath Check: power_of_two_in_integers_is_at_least_one

## 対象

**対象ラベル**: `power_of_two_in_integers_is_at_least_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_power_of_two_in_integers_is_at_least_one`（`M ∈ ℤ_{≥0}` なら `2_ℤ^M ∈ ℤ_{≥1}`。冪は `def_power_of_integer`）
- 範囲: `M = 0` の 2 行、帰納法の段の 8 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `M = 0`: `2_ℤ^0 = 1_ℤ ≥ 1_ℤ` | `check_proof_lines.sage` | 冪を `def_power_of_integer` の再帰（共通の準備 `sagemath/_shared/inclusion_zz_to_rr_by_definition.sage`）で作り、等号と不等号 | **PASS** |
| 帰納法の段: `2^{M+1} = 2^M·2 = 2^M(1+1) = 2^M·1 + 2^M·1 = 2^M + 2^M ≥ 1+1 ≥ 1+0 = 1` | `check_proof_lines.sage` | `M = 0..39` で 4 個の等号と 3 個の不等号と最後の等号 | **PASS** |
| 主張 | `check_proof_lines.sage` | `M = 0..39` で `2_ℤ^{M+1} ≥ 1` と、組み込みの冪 `ZZ(2)^{M+1}` との一致 | **PASS** |
| 帰納法の段の単位元の 2 行の根拠（`set_and_algebra_notation` の ℤ の x ·_ℤ 1_ℤ = x（x → 2_ℤ^M、2 箇所へ）と x +_ℤ 0_ℤ = x（x → 1_ℤ）） | `check_identity_rows_cite_set_and_algebra_notation.sage` | 2^M を不定元に置いた ZZ[P] と M = 0..39 の値で、行に書いた形と代入どおりに（形の左右は多項式環が正規化するので区別できず、レビューの目視で確かめた） 43 個の等号。対照: 単位元を取り違えた形 2 個 | **PASS** |

比較は 442 個（`check_proof_lines.sage`）。単位元の行の根拠の検算 `check_identity_rows_cite_set_and_algebra_notation.sage` は別に 43 個と否定の対照 2 個。否定コントロール: 底を `0_ℤ` に取り違えると `M = 1` で `1` 以上にならない。

## 計算の帰属と範囲

- **厳密**: 値はすべて ZZ。ℝ への脱出は無い。範囲は `M ≤ 40`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の等号は再帰の定義と ZZ の分配法則をなぞるので構成上一致する。中身は組み込みの冪との比較にある。
