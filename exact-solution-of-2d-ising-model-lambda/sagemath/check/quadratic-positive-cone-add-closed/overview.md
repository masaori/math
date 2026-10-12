# 正錐と加法の両立の行別検算

**対象ラベル**: `claim_quadratic_positive_cone_add_closed`

本文 `structured-latex/content/main-text.ts` の「正錐と加法の両立」に対応する。表示の四等号、転送の含意、九場合の十二所属の計17行に一ファイルずつ置く。所属のうち三場合は、逆順に既証補題を適用する行と転送する行を分ける。

係数の標本は `sign*n/d`（`n = 0,...,4`、`d = 1,...,4`、`sign = ±1`）の重複を除いた有理数から取る。三条件のいずれかを満たす係数対は264組で、非負係数143組、負の第二係数47組、負の第一係数74組である。二つの入力が正錐に属するという仮定だけで抽出し、和の正性では絞らない。

行別検算では厳密な二次体 `QQ[r]/(r^2-2)` の二つの根 `s=r,-r` を使う。各根で係数から元を作り、体で和を計算した後、標準形から `s` に関する係数を取り出して表示とする。和の表示を係数和と置いて済ませない。二根合計139,392組で表示と転送を検査し、九場合の所属行はその場合の入力だけを使う。対の等号・順序・体の計算はすべて厳密で、実数体・複素数体や浮動小数点を使わない。有限標本の検算であり、一般の証明は本文と Lean 三版に置く。

| ファイル | 本文の行 | 状態 | 結果 |
|---|---|---|---|
| `check_representation_add.sage` | 表示の加法保存 | PASS | 139392 等式 |
| `check_commute_first_coefficient.sage` | 第一係数の加法可換 | PASS | 139392 等式 |
| `check_commute_second_coefficient.sage` | 第二係数の加法可換 | PASS | 139392 等式 |
| `check_representation_reverse_add.sage` | 逆順の和の表示 | PASS | 139392 等式 |
| `check_membership_transfer.sage` | 表示の等号による所属の転送 | PASS | 139392 含意 |
| `check_nonnegative_nonnegative.sage` | 非負係数・非負係数: 既証補題による所属 | PASS | 40898 所属 |
| `check_nonnegative_negative_second.sage` | 非負係数・負の第二係数: 既証補題による所属 | PASS | 13442 所属 |
| `check_nonnegative_negative_first.sage` | 非負係数・負の第一係数: 既証補題による所属 | PASS | 21164 所属 |
| `check_negative_second_nonnegative_reverse.sage` | 負の第二係数・非負係数: 既証補題による逆順の所属 | PASS | 13442 所属 |
| `check_negative_second_nonnegative.sage` | 負の第二係数・非負係数: 転送後の所属 | PASS | 13442 所属 |
| `check_negative_second_negative_second.sage` | 負の第二係数・負の第二係数: 既証補題による所属 | PASS | 4418 所属 |
| `check_negative_second_negative_first.sage` | 負の第二係数・負の第一係数: 既証補題による所属 | PASS | 6956 所属 |
| `check_negative_first_nonnegative_reverse.sage` | 負の第一係数・非負係数: 既証補題による逆順の所属 | PASS | 21164 所属 |
| `check_negative_first_nonnegative.sage` | 負の第一係数・非負係数: 転送後の所属 | PASS | 21164 所属 |
| `check_negative_first_negative_second_reverse.sage` | 負の第一係数・負の第二係数: 既証補題による逆順の所属 | PASS | 6956 所属 |
| `check_negative_first_negative_second.sage` | 負の第一係数・負の第二係数: 転送後の所属 | PASS | 6956 所属 |
| `check_negative_first_negative_first.sage` | 負の第一係数・負の第一係数: 既証補題による所属 | PASS | 10952 所属 |

`_prelude.sage` に標本・二次体・表示の抽出を置く。`check.sage` は既存の有理係数69,696組の統合検算（和の正性・係数和の可換性・九場合の網羅）を保ったうえで、17行を本文の順に実行する。

| 第一の係数対 | 第二の係数対 | 二根合計の入力数 |
|---|---|---|
| 非負係数 | 非負係数 | 40,898 |
| 非負係数 | 負の第二係数 | 13,442 |
| 非負係数 | 負の第一係数 | 21,164 |
| 負の第二係数 | 非負係数 | 13,442 |
| 負の第二係数 | 負の第二係数 | 4,418 |
| 負の第二係数 | 負の第一係数 | 6,956 |
| 負の第一係数 | 非負係数 | 21,164 |
| 負の第一係数 | 負の第二係数 | 6,956 |
| 負の第一係数 | 負の第一係数 | 10,952 |

プロジェクト直下での実行:

```sh
/home/masaori/.local/share/math-mamba/envs/sage/bin/sage sagemath/check/quadratic-positive-cone-add-closed/check.sage
/home/masaori/.local/share/math-mamba/envs/sage/bin/sage sagemath/check/quadratic-positive-cone-add-closed/check_negative_first_negative_second.sage
```

2026-10-12 01:26 UTC: 統合実行が PASS。本文17行は合計877,914件（等式557,568件、含意139,392件、所属180,954件）で通過し、既存69,696組の統合検算も通過した。個別代表 `check_negative_first_negative_second.sage` は `/tmp` から絶対パスで起動し、6,956所属が PASS。CLI 起動時は隣接する `_prelude.sage` の実在を確認してから `__file__` を使い、存在しなければ `sys.argv[0]` から場所を求める。
