# SageMath Check: 108_sqrt_expansion_via_polar

## 対象

**対象ラベル**: `sqrt_expansion_via_polar` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: √z の定義式（pr₁,pr₂,s_[0,2π) 経由）と代表元表示 (√r, θ/2 − nπ) の一致

左辺は <def_sqrt_cc> の定義式をそのまま実装したもの、右辺は代表元 (r,θ) と n から組んだもので、経路が独立になっている。代表元を 2π ずらしても右辺が変わらないこと、z=0 の別扱い、(√z)²=z、arg(√z)∈[0,π) も確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_expansion.sage` | 定義式と代表元表示の一致、代表元非依存、z=0、分枝 | 632 | 1.014e-15 | **PASS** |
| 02 | `check_02_zero_radius_rows.sage` | `r = 0` の場合の冒頭の `0 − 2·0·π = 0 − 0·π = 0 − 0 = 0`（`real_times_zero_is_zero`（`x → 2`）・`real_zero_times_is_zero`（`x → π`）・`a − 0 = a`）と、左辺の鎖の `(1/2)·(0 − 2·0·π) = (1/2)·0 = 0` の行（π を不定元とする `QQ[π]` の多項式で一行ずつ）、`0 ≤ 0 − 2kπ < 2π` を満たす整数が `k = 0` だけであること（RIF の π で区間演算）と、整数を取り違えた否定の対照 | 6（等号 5・整数の同定 1） | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない（01 だけ。02 は `QQ[π]` と区間演算の厳密計算）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 108
```

実行ログは `sagemath/check/108_sqrt_expansion_via_polar/logs/` に保存してある（この表の数値はそのログから取った）。
