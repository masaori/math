# SageMath Check: 133_matrix_completeness

## 対象

**対象ラベル**: `matrix_completeness` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: (1) 完備性（証明の骨格）、(2) 絶対収束判定: Σ‖B_m‖ が収束 ⟹ ΣB_m が収束し ‖ΣB_m‖ ≤ Σ‖B_m‖

‖B_m‖ が等比数列になるように作った列で、部分和の Cauchy 性と上界を確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_absolute_convergence.sage` | 等比和との一致、部分和の Cauchy 性、上界 | 45 | 0.000e+00 | **PASS** |
| 02 | `check_02_cauchy_completeness.sage` | (1) の証明の骨格: Cauchy 性の sup の単調減少と理論上界、Step 1 の max\|a_ij\| ≤ ‖A‖、閉形式との一致 | 80 | 1.071e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

(1) 完備性そのもの（任意の Cauchy 列が収束する）は数値では検証できない。01 で見ているのは (2) の絶対収束判定の帰結である。02 は (1) の**証明の骨格**を検査する: Cauchy 列 A_N := Σ_{m≤N} r^m C を構成し、sup_{N,M≥N₀}‖A_N−A_M‖ が N₀ について単調非増加で理論上界 2\|r\|^{N₀+1}‖C‖/\|1−r\| を破らないこと、Step 1 の評価 max\|(A_N−A)_ij\| ≤ ‖A_N−A‖ が全 N で成り立つこと、極限が独立に計算できる閉形式 C/(1−r) と一致することを確認している（最後が同語反復でない独立経路）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 133
```

実行ログは `sagemath/check/133_matrix_completeness/logs/` に保存してある（この表の数値はそのログから取った）。
