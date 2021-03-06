// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

package dyno.fun.lapse;

import java.util.concurrent.atomic.AtomicBoolean;

public abstract class ProjectCellGen {
    public abstract String getPath();

    public abstract String getName();

    public abstract String getCreateTime();

    public abstract String getLength();

    public abstract String getFps();

    public abstract String getRecordDuration();

    public static native ProjectCellGen create(String path, int outW, int outH);

    private static final class CppProxy extends ProjectCellGen
    {
        private final long nativeRef;
        private final AtomicBoolean destroyed = new AtomicBoolean(false);

        private CppProxy(long nativeRef)
        {
            if (nativeRef == 0) throw new RuntimeException("nativeRef is zero");
            this.nativeRef = nativeRef;
        }

        private native void nativeDestroy(long nativeRef);
        public void destroy()
        {
            boolean destroyed = this.destroyed.getAndSet(true);
            if (!destroyed) nativeDestroy(this.nativeRef);
        }
        protected void finalize() throws java.lang.Throwable
        {
            destroy();
            super.finalize();
        }

        @Override
        public String getPath()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getPath(this.nativeRef);
        }
        private native String native_getPath(long _nativeRef);

        @Override
        public String getName()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getName(this.nativeRef);
        }
        private native String native_getName(long _nativeRef);

        @Override
        public String getCreateTime()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getCreateTime(this.nativeRef);
        }
        private native String native_getCreateTime(long _nativeRef);

        @Override
        public String getLength()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getLength(this.nativeRef);
        }
        private native String native_getLength(long _nativeRef);

        @Override
        public String getFps()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getFps(this.nativeRef);
        }
        private native String native_getFps(long _nativeRef);

        @Override
        public String getRecordDuration()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getRecordDuration(this.nativeRef);
        }
        private native String native_getRecordDuration(long _nativeRef);
    }
}
