# SageMath Check: 145_exp_converges

## 対象

**対象ラベル**: `exp_converges` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`

- 範囲: 有限次元ノルム線型空間上の線型写像 X について Σ(1/n!)X^n が各点収束すること

各点収束を「任意のベクトル v について部分和が Cauchy であること」と「極限が exp(X)v に一致すること」で確認する。極限写像が線型であることも見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_pointwise.sage` | 部分和の Cauchy 性、極限 = exp(X)v、極限の線型性 | 84 | 9.249e-16 | **PASS** |
| 02 | `check_02_matrix_unit_norm_chain.sage` | Step 4 の ‖E^{(k,l)}‖ = 1 の鎖を一行ずつ（|0_K|・|1_K| の準備、成分の絶対値の二乗、行ごとの和、ノルムの 5 行）。K = ℝ は QQ、K = ℂ は QQbar（ι(x) は実部 x・虚部 0 の対から作る）、n = 1〜5 の全 (k,l)、和は左から順に、AA で厳密。否定の対照 1 件 | 2525 | 0 | **PASS** |
| 03 | `check_03_matrix_unit_zero_entry.sage` | Step 4 の行列単位による展開の (i,j) 成分で、(k,l) ≠ (i,j) の項 y_kl·0 = 0（K = ℝ は real_times_zero_is_zero、K = ℂ は complex_times_zero_is_zero）、(i,j) の項 y_ij·1 = y_ij、和 = y_ij。K = ℝ は QQ[y_kl]、K = ℂ は実数の対 (u_kl, v_kl) を QQ[u,v] の不定元で、n = 1〜3 の全 (i,j)・(k,l)。否定の対照 1 件 | 225 | 0 | **PASS** |
| 04 | `check_04_matrix_unit_expansion_entry_chain.sage` | Step 4 の行列単位による展開の (i,j) 成分の鎖を一行ずつ。準備の t_kl = y_kl·0 = 0（(k,l) ≠ (i,j)）、t_ij = y_ij·1 = y_ij、s_k = Σ_l 0 = 0（k ≠ i）、s_i = t_ij = y_ij と、主の鎖の 8 個の等号（有限和の成分は成分の有限和（外側・内側）、スカラー倍は成分ごと、t_kl・s_k の置き方、0 の項を落とす、s_i = y_ij、Y = (y_kl) の書き方の y_ij = Y_ij。Y は成分の辞書として別に作る）。準備の鎖は t_ij・s_i の置き方を開く行を別に確かめ、t_kl（(k,l) ≠ (i,j)）・s_k（k ≠ i）の置き方を開く行は次の行と合わせて確かめる。行列は成分の辞書、和は左から順に。K = ℝ は QQ[y_kl]、K = ℂ は実数の対 (u_kl, v_kl) を QQ[u,v] の不定元で、n = 1〜3 の全 (i,j)。否定の対照 2 件 | 820 | 0 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

次元は 2,4,9,16（ad_X を線型写像として扱う場面の n² に相当する次元を含む）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 145
```

実行ログは `sagemath/check/145_exp_converges/logs/` に保存してある（この表の数値はそのログから取った）。
