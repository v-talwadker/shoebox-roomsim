function [abs_echograms, echograms] = compute_echograms_arrays(room, src, rec, abs_wall, imgSrcOrder)

nRec = size(rec,1);
nSrc = size(src,1);
% limit the RIR by reflection order or by time-limit
% type = 'maxTime';
% time = 0.16;
type = 'maxOrder';
% compute echogram due to pure propagation (frequency-independent)
for ns=1:nSrc
    for nr=1:nRec
        disp('')
        disp(['Compute echogram: Source ' num2str(ns) ' - Receiver ' num2str(nr)])
        % compute echogram
        % echograms(ns, nr) = ims_coreMtx(room, src(ns,:), rec(nr,:), type, time);
        echograms(ns, nr) = ims_coreMtx(room, src(ns,:), rec(nr,:), type, imgSrcOrder);
    end
end

% apply boundary absorption
for ns = 1:nSrc
    for nr=1:nRec
        disp('')
        disp(['Apply absorption: Source ' num2str(ns) ' - Receiver ' num2str(nr)])
        % compute echogram
        abs_echograms(ns, nr, :) = absorption_module(echograms(ns,nr), abs_wall);
    end
end
