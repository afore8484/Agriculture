import { X } from "lucide-react";
import { ReactNode } from "react";

interface ModalProps {
  open: boolean;
  onClose: () => void;
  title: string;
  children: ReactNode;
  width?: string;
}

export function Modal({ open, onClose, title, children, width = "max-w-lg" }: ModalProps) {
  if (!open) return null;
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/40" onClick={onClose} />
      <div className={`relative bg-white rounded-xl shadow-xl ${width} w-full mx-4 max-h-[90vh] overflow-y-auto`}>
        <div className="flex items-center justify-between p-5 border-b border-border">
          <h3>{title}</h3>
          <button onClick={onClose} className="p-1 hover:bg-muted rounded"><X className="w-5 h-5" /></button>
        </div>
        <div className="p-5">{children}</div>
      </div>
    </div>
  );
}

interface ConfirmDialogProps {
  open: boolean;
  onClose: () => void;
  onConfirm: () => void;
  title: string;
  message: string;
  confirmText?: string;
  cancelText?: string;
  type?: "danger" | "warning" | "info";
}

export function ConfirmDialog({ open, onClose, onConfirm, title, message, confirmText = "确认", cancelText = "取消", type = "info" }: ConfirmDialogProps) {
  if (!open) return null;
  const btnClass = type === "danger" ? "bg-red-500 hover:bg-red-600" : type === "warning" ? "bg-amber-500 hover:bg-amber-600" : "bg-primary hover:bg-primary/90";
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/40" onClick={onClose} />
      <div className="relative bg-white rounded-xl shadow-xl max-w-sm w-full mx-4 p-6">
        <h3 className="mb-2">{title}</h3>
        <p className="text-muted-foreground text-[14px] mb-6 whitespace-pre-line">{message}</p>
        <div className="flex justify-end gap-3">
          <button onClick={onClose} className="px-4 py-2 border border-border rounded-lg hover:bg-muted text-[14px]">{cancelText}</button>
          <button onClick={() => { onConfirm(); }} className={`px-4 py-2 text-white rounded-lg text-[14px] ${btnClass}`}>{confirmText}</button>
        </div>
      </div>
    </div>
  );
}