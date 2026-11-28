#!/usr/bin/env node
/**
 * Lean の点検の直しの研究管理の記録（docs/tasks/lean-audit-research-management-log.md）の表「件数」から、
 * 四つの観点（分離・繋がり・未定義の記号・一対一）ごとの一日の減りと、件数が零になる見込みの日を出す。
 *
 * 研究管理は、この出力を毎回そのまま報告と記録に使う。見込みを回ごとに別の数え方で出すと、
 * 前回の見込みから早まったか遅れたかを比べられないので、出し方をここに固定する。
 *
 * - 一日の減り: 前々回の記録から今回の記録までの減りを、その間の日数で割る。
 *   判断の基準（前々回の記録から減っているか）と同じ幅にする。
 * - 観点の見込みの日: 今回の記録の日に「残り ÷ 一日の減り」の切り上げの日数を足す。
 *   残りが零ならその日。一日の減りが零以下なら見込みを出さない。
 * - 全体の見込みの日: 四つの観点の見込みの日のうち最も遅い日。ゴールラインは四つが全て零になることなので、
 *   最も遅い観点が全体を決める。一つでも見込みを出せない観点があれば、全体の見込みも出さない。
 * - 前回の見込みからの変化: 前回の記録までの件数で同じ計算をした全体の見込みの日との差。
 *
 * 使い方: node structured-latex/tools/estimate-lean-audit-completion.ts [--table]
 *   --table を付けると、記録の表「終わる見込み」の全ての行を出す（前々回の記録がある回から）。
 */

import { readFileSync } from "node:fs";
import { join } from "node:path";

import { structuredLatexDir } from "./content-modules.ts";

const logPath = join(structuredLatexDir, "..", "docs", "tasks", "lean-audit-research-management-log.md");

const ASPECTS = ["分離", "繋がり", "未定義の記号", "一対一"] as const;
type Aspect = (typeof ASPECTS)[number];

type MeasurementRecord = { date: string; counts: Record<Aspect, number> };

const DAY_MS = 24 * 60 * 60 * 1000;

function leadingInteger(cell: string): number {
  const match = cell.trim().match(/^[\d,]+/);
  if (match === null) throw new Error(`件数の欄が数で始まっていない: ${cell}`);
  return Number(match[0].replaceAll(",", ""));
}

function readRecords(): MeasurementRecord[] {
  const lines = readFileSync(logPath, "utf8").split("\n");
  const start = lines.findIndex((line) => line.trim() === "## 件数");
  if (start < 0) throw new Error(`節「件数」が無い: ${logPath}`);
  const records: MeasurementRecord[] = [];
  for (const line of lines.slice(start + 1)) {
    if (line.startsWith("## ")) break;
    if (!line.startsWith("| 20")) continue;
    // 列は 日付・読解終点のコミット・分離・繋がり・未定義の記号・一対一・和・差 の順。
    const [dateCell, , separation, connection, undefinedSymbols, oneToOne] = line.split("|").slice(1, -1);
    if (
      dateCell === undefined ||
      separation === undefined ||
      connection === undefined ||
      undefinedSymbols === undefined ||
      oneToOne === undefined
    ) {
      throw new Error(`表「件数」の行の欄が足りない: ${line}`);
    }
    const date = dateCell.trim().slice(0, 10);
    if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) throw new Error(`日付の欄が読めない: ${dateCell}`);
    records.push({
      date,
      counts: {
        分離: leadingInteger(separation),
        繋がり: leadingInteger(connection),
        未定義の記号: leadingInteger(undefinedSymbols),
        一対一: leadingInteger(oneToOne),
      },
    });
  }
  return records;
}

function addDays(date: string, days: number): string {
  return new Date(Date.parse(`${date}T00:00:00Z`) + days * DAY_MS).toISOString().slice(0, 10);
}

function daysBetween(from: string, to: string): number {
  return Math.round((Date.parse(`${to}T00:00:00Z`) - Date.parse(`${from}T00:00:00Z`)) / DAY_MS);
}

type AspectEstimate = { remaining: number; perDay: number; completion: string | null };
type Estimate = {
  date: string;
  aspects: Record<Aspect, AspectEstimate>;
  completion: string | null;
  slowest: Aspect[];
};

function estimateAt(records: MeasurementRecord[], index: number): Estimate | null {
  const now = records[index];
  const before = records[index - 2];
  if (now === undefined || before === undefined) return null;
  const span = daysBetween(before.date, now.date);
  if (span <= 0) throw new Error(`記録の日付が進んでいない: ${before.date} → ${now.date}`);
  const aspects = {} as Record<Aspect, AspectEstimate>;
  for (const aspect of ASPECTS) {
    const remaining = now.counts[aspect];
    const perDay = (before.counts[aspect] - remaining) / span;
    const completion =
      remaining === 0 ? now.date : perDay > 0 ? addDays(now.date, Math.ceil(remaining / perDay)) : null;
    aspects[aspect] = { remaining, perDay, completion };
  }
  const completions = ASPECTS.map((aspect) => aspects[aspect].completion);
  const completion = completions.includes(null)
    ? null
    : (completions as string[]).reduce((latest, date) => (date > latest ? date : latest));
  const slowest =
    completion === null
      ? ASPECTS.filter((aspect) => aspects[aspect].completion === null)
      : ASPECTS.filter((aspect) => aspects[aspect].completion === completion);
  return { date: now.date, aspects, completion, slowest };
}

function monthDay(date: string): string {
  const [, month, day] = date.split("-").map(Number);
  return `${month}/${day}`;
}

function formatDate(date: string, reference: string): string {
  return date.slice(0, 4) === reference.slice(0, 4) ? monthDay(date) : `${date.slice(0, 4)}/${monthDay(date)}`;
}

function formatPerDay(perDay: number): string {
  const rounded = Math.round(perDay * 10) / 10;
  if (rounded === 0) return "0";
  return rounded > 0 ? `−${rounded.toLocaleString("en-US")}` : `+${(-rounded).toLocaleString("en-US")}`;
}

function formatChange(current: Estimate, previous: Estimate | null): string {
  if (current.completion === null) return "見込みを出せない";
  if (previous === null || previous.completion === null) return "前回は見込みを出せなかった";
  const shift = daysBetween(previous.completion, current.completion);
  const from = formatDate(previous.completion, current.date);
  if (shift < 0) return `前回の ${from} から ${-shift} 日早まった`;
  if (shift > 0) return `前回の ${from} から ${shift} 日遅れた`;
  return `前回の ${from} から変わらない`;
}

const records = readRecords();

if (process.argv.includes("--table")) {
  console.log(`| 日付 | ${ASPECTS.join(" | ")} | 全体 | 前回の見込みからの変化 |`);
  console.log(`|---|${ASPECTS.map(() => "---|").join("")}---|---|`);
  for (let index = 2; index < records.length; index++) {
    const current = estimateAt(records, index)!;
    const cells = ASPECTS.map((aspect) => {
      const { perDay, completion } = current.aspects[aspect];
      return `${completion === null ? "見込みなし" : formatDate(completion, current.date)}（一日 ${formatPerDay(perDay)}）`;
    });
    const overall =
      current.completion === null
        ? `見込みなし（${current.slowest.join("・")}が減っていない）`
        : `${formatDate(current.completion, current.date)}（${current.slowest.join("・")}）`;
    console.log(`| ${current.date} | ${cells.join(" | ")} | ${overall} | ${formatChange(current, estimateAt(records, index - 1))} |`);
  }
} else {
  const index = records.length - 1;
  const current = estimateAt(records, index);
  if (current === null) {
    console.log("前々回の記録が無いので、見込みを出せない");
  } else {
    console.log(`記録 ${current.date} の時点`);
    for (const aspect of ASPECTS) {
      const { remaining, perDay, completion } = current.aspects[aspect];
      console.log(
        `${aspect}: 残り ${remaining.toLocaleString("en-US")}、一日 ${formatPerDay(perDay)}、見込み ${
          completion === null ? "なし" : formatDate(completion, current.date)
        }`,
      );
    }
    console.log(
      `全体: 見込み ${current.completion === null ? "なし" : formatDate(current.completion, current.date)}、決めている観点 ${current.slowest.join("・")}、${formatChange(current, estimateAt(records, index - 1))}`,
    );
  }
}
