import { existsSync, readFileSync, writeFileSync } from "node:fs";
import { randomUUID } from "node:crypto";
import { resolve } from "node:path";
import { fileURLToPath } from "node:url";

export function beginOrResume(path: string, head: string) {
  const state: unknown = existsSync(path)
    ? JSON.parse(readFileSync(path, "utf8"))
    : { run: randomUUID(), base: head };
  if (typeof state !== "object" || state === null || !("run" in state) || !("base" in state)
    || typeof state.run !== "string" || !/^[a-zA-Z0-9-]+$/.test(state.run)
    || typeof state.base !== "string" || !/^[0-9a-f]{40}$/.test(state.base)) {
    throw new Error("未完実行の記録が不正。成果を保持して停止する");
  }
  if (!existsSync(path)) writeFileSync(path, JSON.stringify(state) + "\n", { flag: "wx" });
  return { run: state.run, base: state.base };
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const [, , path, head] = process.argv;
  if (!path || !head) throw new Error("usage: run-state.ts <marker> <HEAD>");
  const state = beginOrResume(path, head);
  console.log(`${state.run} ${state.base}`);
}
